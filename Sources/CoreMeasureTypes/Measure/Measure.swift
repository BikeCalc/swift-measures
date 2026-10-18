// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import NumericsExtended

/// A numeric value paired with a unit.
///
/// Values are stored as `Double`. The generic unit type identifies the available unit definitions; a composed unit
/// additionally carries its physical dimension at runtime. Conversion preserves the represented quantity by applying
/// the source and destination coefficients and constants.
///
/// Initialization, conversion, and arithmetic do not enforce the unit's valid range or clamp values to its bounds. Use
/// `isValid` to check the value and conversion definition against the unit's reference-scale range. `isNaT` detects
/// nonfinite values and invalid conversion parameters independently of that range.
///
/// Addition and subtraction operate on readings expressed in the left operand's unit. Scalar multiplication and
/// division scale the stored reading without applying the unit's coefficient or constant. For offset units, this
/// differs from scaling an absolute value on the reference scale.
///
/// Absolute quantities and differences are not represented by distinct types. In particular, subtracting temperatures
/// retains the left operand's temperature unit; the result does not acquire temperature-difference conversion
/// semantics.
public struct Measure<UnitType>
where UnitType: Unit {
    /// The keys used to encode and decode a measure.
    private enum CodingKeys: String, CodingKey {
        /// The value of the measure.
        case value = "value"

        /// The unit associated with the measure.
        case unit = "unit"
    }

    /// The value of this measure.
    public let value: Double

    /// The unit associated with this measure.
    public let unit: UnitType

    /// Creates a new instance with the specified value and unit.
    ///
    /// - Parameters:
    ///   - value: The value.
    ///   - unit: The unit.
    public init<Source>(
        _ value: Source,
        _ unit: UnitType
    )
    where Source: BinaryFloatingPoint {
        self.value = .init(value)
        self.unit = unit
    }

    /// Creates a new instance with the specified value and unit.
    ///
    /// - Parameters:
    ///   - value: The value.
    ///   - unit: The unit.
    public init<Source>(
        _ value: Source,
        _ unit: UnitType
    )
    where Source: BinaryInteger {
        self.value = .init(value)
        self.unit = unit
    }

    /// A boolean value indicating whether this measure has a valid conversion and lies within its unit's valid range.
    public var isValid: Bool {
        return self.isNaT == false
            && self.isWithinValidRange
    }

    /// A boolean value indicating whether this measure is within its dimension's valid range.
    internal var isWithinValidRange: Bool {
        let baseValue: Double = self.value * self.unit.coefficient + self.unit.constant

        return self.unit.validRange.contains(baseValue)
    }
}

// MARK: - Addable

extension Measure: Addable
where UnitType: Equatable {
    public typealias Addend = Self
    public typealias Sum = Self

    /// Returns the sum of readings expressed in the first measure's unit.
    ///
    /// The second measure is converted before the readings are combined. The result retains the first unit, including
    /// its constant, and is not clamped to its valid range.
    ///
    /// - Parameters:
    ///   - lhs: The first measure.
    ///   - rhs: The measure to add.
    /// - Returns: The sum in the first measure's unit, or NaT if either operand is NaT, the units are incompatible,
    ///   or conversion or addition produces a nonfinite result.
    public static func + (
        _ lhs: Self,
        _ rhs: Self.Addend
    ) -> Self.Sum {
        guard lhs.isNaT == false, rhs.isNaT == false, lhs.unit.isCompatible(with: rhs.unit) else {
            return .nat
        }

        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value
        let newValue: Double = lhsValue + rhsValue

        guard newValue.isFinite else {
            return .nat
        }

        return .init(newValue, lhs.unit)
    }
}

// MARK: - ApproximatelyEquatable

extension Measure: ApproximatelyEquatable {
    /// The measure type used to express an absolute difference.
    public typealias AbsoluteTolerance = Self

    /// The floating-point type used to express a dimensionless relative difference.
    public typealias RelativeTolerance = Double

    /// Returns whether this value and another agree within either of the specified tolerances.
    ///
    /// Absolute tolerance represents a difference and ignores the unit's offset. Relative tolerance scales the larger
    /// magnitude in the base unit. NaT operands, invalid tolerances, and conversion overflow return `false`.
    /// NaT is never approximately equal to itself.
    ///
    /// For example:
    ///
    /// ```swift
    /// let calculated: Measure<Length> = .init(0.1 + 0.2, .meter)
    /// let expected: Measure<Length> = .init(0.3, .meter)
    /// print(calculated.isApproximatelyEqual(to: expected, absoluteTolerance: .init(0.001, .millimeter)))
    /// // Prints "true"
    /// ```
    ///
    /// - Parameters:
    ///   - other: The value to compare.
    ///   - absoluteTolerance: The nonnegative, finite maximum absolute difference.
    ///   - relativeTolerance: The relative difference allowed, between zero and one inclusive.
    /// - Returns: `true` if the values agree within either tolerance, and `false` otherwise.
    public func isApproximatelyEqual(
        to other: Self,
        absoluteTolerance: Self.AbsoluteTolerance,
        relativeTolerance: Self.RelativeTolerance = 0
    ) -> Bool {
        guard self.isNaT == false,
            other.isNaT == false,
            self.unit.isCompatible(with: other.unit),
            self.unit.isCompatible(with: absoluteTolerance.unit),
            absoluteTolerance.isNaT == false,
            absoluteTolerance.value >= 0,
            relativeTolerance.isFinite,
            relativeTolerance >= 0,
            relativeTolerance <= 1
        else {
            return false
        }

        let lhsValue: Double = (self.value * self.unit.coefficient + self.unit.constant)
        let rhsValue: Double = (other.value * other.unit.coefficient + other.unit.constant)
        let toleranceValue: Double = absoluteTolerance.value * abs(absoluteTolerance.unit.coefficient)

        guard toleranceValue.isFinite, lhsValue.isFinite, rhsValue.isFinite else {
            return false
        }

        if lhsValue == rhsValue {
            return true
        }

        let difference: Double = abs(lhsValue - rhsValue)
        let scale: Double = max(abs(lhsValue), abs(rhsValue))
        let bound: Double = max(toleranceValue, relativeTolerance * scale)

        return difference.isFinite && difference <= bound
    }
}

// MARK: - CanonicallyEquatable

extension Measure: CanonicallyEquatable {
    /// Returns a boolean value indicating whether this measure is canonically equal to the specified measure.
    ///
    /// The units must be compatible. For composable units, their physical dimensions must match. Both values are
    /// converted to their reference scale using their coefficients and constants, then compared exactly. Unit symbols
    /// are not compared.
    ///
    /// Conversion can introduce floating-point rounding. Equality is exact rather than approximate. NaT operands
    /// and nonfinite reference-scale values compare unequal, including when comparing a measure with itself.
    ///
    /// For example:
    ///
    /// ```swift
    /// let oneMeter: Measure<Length> = .init(1, .meter)
    /// let oneHundredCentimeters: Measure<Length> = .init(100, .centimeter)
    ///
    /// print(oneMeter.isCanonicallyEqual(to: oneHundredCentimeters))
    /// // Prints "true"
    /// ```
    ///
    /// - Parameter other: The measure to compare with this measure.
    /// - Returns: `true` if the units are compatible and the converted values are exactly equal, and `false` otherwise.
    public func isCanonicallyEqual(to other: Self) -> Bool {
        guard self.isNaT == false, other.isNaT == false, self.unit.isCompatible(with: other.unit) else {
            return false
        }

        let lhsValue: Double = self.value * self.unit.coefficient + self.unit.constant
        let rhsValue: Double = other.value * other.unit.coefficient + other.unit.constant

        return lhsValue.isFinite && rhsValue.isFinite && lhsValue == rhsValue
    }
}

// MARK: - Comparable

extension Measure: Comparable
where UnitType: Equatable {
    /// Returns a boolean value indicating whether the first measure is less than the second.
    ///
    /// Incompatible units, NaT operands, and nonfinite conversion results are unordered and return `false`. Otherwise,
    /// the second measure is converted to the first measure's unit before comparison.
    ///
    /// - Parameters:
    ///   - lhs: The first measure to compare.
    ///   - rhs: The second measure to compare.
    /// - Returns: The comparison result, or `false` if the units are incompatible.
    public static func < (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        guard lhs.isNaT == false, rhs.isNaT == false, lhs.unit.isCompatible(with: rhs.unit) else {
            return false
        }

        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value

        return lhsValue < rhsValue
    }

    /// Returns a boolean value indicating whether the first measure is less than or equal to the second.
    ///
    /// Incompatible units, NaT operands, and nonfinite conversion results are unordered and return `false`. Otherwise,
    /// the second measure is converted to the first measure's unit before comparison.
    ///
    /// - Parameters:
    ///   - lhs: The first measure to compare.
    ///   - rhs: The second measure to compare.
    /// - Returns: The comparison result, or `false` if the units are incompatible.
    public static func <= (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        guard lhs.isNaT == false, rhs.isNaT == false, lhs.unit.isCompatible(with: rhs.unit) else {
            return false
        }

        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value

        return lhsValue <= rhsValue
    }

    /// Returns a boolean value indicating whether the first measure is greater than the second.
    ///
    /// Incompatible units, NaT operands, and nonfinite conversion results are unordered and return `false`. Otherwise,
    /// the second measure is converted to the first measure's unit before comparison.
    ///
    /// - Parameters:
    ///   - lhs: The first measure to compare.
    ///   - rhs: The second measure to compare.
    /// - Returns: The comparison result, or `false` if the units are incompatible.
    public static func > (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        guard lhs.isNaT == false, rhs.isNaT == false, lhs.unit.isCompatible(with: rhs.unit) else {
            return false
        }

        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value

        return lhsValue > rhsValue
    }

    /// Returns a boolean value indicating whether the first measure is greater than or equal to the second.
    ///
    /// Incompatible units, NaT operands, and nonfinite conversion results are unordered and return `false`. Otherwise,
    /// the second measure is converted to the first measure's unit before comparison.
    ///
    /// - Parameters:
    ///   - lhs: The first measure to compare.
    ///   - rhs: The second measure to compare.
    /// - Returns: The comparison result, or `false` if the units are incompatible.
    public static func >= (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        guard lhs.isNaT == false, rhs.isNaT == false, lhs.unit.isCompatible(with: rhs.unit) else {
            return false
        }

        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value

        return lhsValue >= rhsValue
    }
}

// MARK: - Convertible

extension Measure: Convertible {
    /// Returns this measure converted to the specified unit.
    ///
    /// Conversion applies both units' coefficients and constants without simplifying or normalizing the destination
    /// unit. Values outside the unit's valid range are not rejected. NaT inputs, invalid destination conversion
    /// parameters, incompatible dimensions, and nonfinite conversion results return NaT of the destination unit type.
    ///
    /// Compatible composable units have matching physical dimensions. A NaT result uses the unit type's NaT
    /// representation rather than retaining the requested destination unit.
    ///
    /// For example:
    ///
    /// ```swift
    /// let distance: Measure<Length> = .init(1, .meter)
    ///
    /// print(distance.converted(to: Length.centimeter))
    /// // Prints "100.0 cm"
    /// ```
    ///
    /// - Parameter unit: The unit to convert to.
    /// - Returns: A measure expressed in the destination unit, or NaT when conversion cannot produce a finite result.
    public func converted(to unit: UnitType) -> Self {
        guard self.isNaT == false,
            unit.coefficient.isFinite,
            unit.coefficient > 0,
            unit.constant.isFinite,
            self.unit.isCompatible(with: unit)
        else {
            return .nat
        }

        // Identical scales and offsets cancel; preserve the value without conversion rounding.
        if self.unit.coefficient == unit.coefficient, self.unit.constant == unit.constant {
            return .init(self.value, unit)
        }

        let referenceValue: Double = self.value * self.unit.coefficient + self.unit.constant
        let value: Double = (referenceValue - unit.constant) / unit.coefficient

        guard value.isFinite else {
            return .nat
        }

        return .init(value, unit)
    }
}

// MARK: - CustomDebugStringConvertible

extension Measure: CustomDebugStringConvertible {
    /// A textual representation of this instance suitable for debugging.
    public var debugDescription: String {
        return "Measure<\(UnitType.self)>(\(self.value), \(self.unit))"
    }
}

// MARK: - CustomStringConvertible

extension Measure: CustomStringConvertible {
    /// A textual representation of this instance.
    ///
    /// For example:
    ///
    /// ```swift
    /// let measure: Measure<Length> = .init(1, .meter)
    /// print(measure)
    /// // Prints "1.0 m"
    /// ```
    public var description: String {
        return self.value.description + " " + self.unit.symbol
    }
}

// MARK: - Decodable

extension Measure: Decodable
where UnitType: Decodable {
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Self.CodingKeys> = try decoder.container(keyedBy: Self.CodingKeys.self)

        let value: Double = try container.decode(Double.self, forKey: .value)
        let unit: UnitType = try container.decode(UnitType.self, forKey: .unit)

        self.init(value, unit)
    }
}

// MARK: - Divisible

extension Measure: Divisible
where UnitType: Equatable {
    public typealias Divisor = Double
    public typealias Quotient = Self
    public typealias RemainderDivisor = Double
    public typealias Remainder = Self

    @available(*, deprecated)
    public var reciprocal: Self? {
        // TODO: Fix Measure reciprocal
        // Add a Reciprocal associated type to Divisible so composable measures can return Measure<ComposedUnit>
        // The reciprocal of 2 m is 0.5 m⁻¹, which cannot be represented by Self.
        return nil
    }

    @available(*, deprecated)
    public var isInvertible: Bool {
        // TODO: Fix Measure isInvertible
        // Implement alongside reciprocal after Divisible supports a different reciprocal type. Apply the unit's
        // coefficient and constant first, then require a finite, nonzero base value and a finite, nonzero reciprocal.
        // For example, 0 °C is invertible, but 0 K is not.
        return false
    }

    public func isDivisible(by other: Self) -> Bool {
        guard self.unit.isCompatible(with: other.unit),
            self.isNaT == false,
            other.isNaT == false
        else {
            return false
        }

        // Equal scales cancel when neither unit has an offset; avoid introducing conversion rounding.
        if self.unit.coefficient == other.unit.coefficient,
            self.unit.constant == 0,
            other.unit.constant == 0
        {
            return self.value.isDivisible(by: other.value)
        }

        let lhsValue: Double = self.value * self.unit.coefficient + self.unit.constant
        let rhsValue: Double = other.value * other.unit.coefficient + other.unit.constant

        guard lhsValue.isFinite, rhsValue.isFinite else {
            return false
        }

        return lhsValue.isDivisible(by: rhsValue)
    }

    /// Returns the quotient by dividing the stored reading by a scalar.
    ///
    /// The unit is preserved without applying its coefficient or constant. For offset units, this scales the reading,
    /// not the absolute reference value. Finite results are not clamped to the valid range. NaT operands, nonfinite
    /// scalars, and nonfinite results produce NaT.
    ///
    /// - Parameters:
    ///   - lhs: The measure whose reading is scaled.
    ///   - rhs: The scalar used to scale the reading.
    /// - Returns: The finite quotient in the original unit, or NaT, including when the divisor is zero.
    public static func / (
        _ lhs: Self,
        _ rhs: Self.Divisor
    ) -> Self.Quotient {
        guard lhs.isNaT == false, rhs.isFinite else {
            return .nat
        }

        let lhsValue: Double = lhs.value
        let newValue: Double = lhsValue / rhs

        guard newValue.isFinite else {
            return .nat
        }

        return .init(newValue, lhs.unit)
    }

    /// Returns the truncating remainder of the stored reading divided by a scalar.
    ///
    /// Finite results retain the original unit without applying its coefficient or constant. NaT operands, nonfinite
    /// scalars, and nonfinite results produce NaT. Valid ranges are not enforced.
    ///
    /// - Parameters:
    ///   - lhs: The measure whose reading is divided.
    ///   - rhs: The scalar divisor.
    /// - Returns: The finite remainder in the original unit, or NaT, including when the divisor is zero.
    public static func % (
        _ lhs: Self,
        _ rhs: Self.RemainderDivisor
    ) -> Self.Remainder {
        guard lhs.isNaT == false, rhs.isFinite else {
            return .nat
        }

        let lhsValue: Double = lhs.value
        let newValue: Double = lhsValue.truncatingRemainder(dividingBy: rhs)

        guard newValue.isFinite else {
            return .nat
        }

        return .init(newValue, lhs.unit)
    }
}

// MARK: - Encodable

extension Measure: Encodable
where UnitType: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Self.CodingKeys> = encoder.container(keyedBy: Self.CodingKeys.self)

        try container.encode(self.value, forKey: .value)
        try container.encode(self.unit, forKey: .unit)
    }
}

// MARK: - Equatable

extension Measure: Equatable
where UnitType: Equatable {
    public static func == (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        guard lhs.isNaT == false, rhs.isNaT == false else {
            return false
        }

        return lhs.value == rhs.value
            && lhs.unit == rhs.unit
    }
}

// MARK: - Hashable

extension Measure: Hashable
where UnitType: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
        hasher.combine(self.unit)
    }
}

// MARK: - Multipliable

extension Measure: Multipliable
where UnitType: Equatable {
    public typealias Multiplier = Double
    public typealias Product = Self

    public func isMultiple(of other: Self) -> Bool {
        guard self.unit.isCompatible(with: other.unit),
            self.isNaT == false,
            other.isNaT == false
        else {
            return false
        }

        // Equal scales cancel when neither unit has an offset; avoid introducing conversion rounding.
        if self.unit.coefficient == other.unit.coefficient, self.unit.constant == 0, other.unit.constant == 0 {
            return self.value.isMultiple(of: other.value)
        }

        let lhsValue: Double = self.value * self.unit.coefficient + self.unit.constant
        let rhsValue: Double = other.value * other.unit.coefficient + other.unit.constant

        guard lhsValue.isFinite, rhsValue.isFinite else {
            return false
        }

        return lhsValue.isMultiple(of: rhsValue)
    }

    /// Returns the product by multiplying the stored reading by a scalar.
    ///
    /// The unit is preserved without applying its coefficient or constant. For offset units, this scales the reading,
    /// not the absolute reference value. Finite results are not clamped to the valid range. NaT operands, nonfinite
    /// scalars, and nonfinite results produce NaT.
    ///
    /// - Parameters:
    ///   - lhs: The measure whose reading is scaled.
    ///   - rhs: The scalar used to scale the reading.
    /// - Returns: The finite product in the original unit, or NaT.
    public static func * (
        _ lhs: Self,
        _ rhs: Self.Multiplier
    ) -> Self.Product {
        guard lhs.isNaT == false, rhs.isFinite else {
            return .nat
        }

        let lhsValue: Double = lhs.value
        let newValue: Double = lhsValue * rhs

        guard newValue.isFinite else {
            return .nat
        }

        return .init(newValue, lhs.unit)
    }
}

// MARK: - RepresentableByNaT

extension Measure: RepresentableByNaT {
    public var isNaT: Bool {
        return self.value.isFinite == false
            || self.unit.coefficient.isFinite == false
            || self.unit.coefficient <= 0
            || self.unit.constant.isFinite == false
    }

    public static var nat: Self {
        let unit: UnitType = .init(
            coefficient: .nan,
            constant: .nan,
            symbol: "NaT"
        )

        return .init(Double.nan, unit)
    }
}

// MARK: - Sendable

extension Measure: Sendable
where UnitType: Sendable {}

// MARK: - Subtractable

extension Measure: Subtractable
where UnitType: Equatable {
    public typealias Subtrahend = Self
    public typealias Difference = Self

    /// Returns the difference of readings expressed in the first measure's unit.
    ///
    /// The second measure is converted before the readings are combined. The result retains the first unit, including
    /// its constant, and is not clamped to its valid range. Subtracting temperatures does not create a distinct
    /// temperature-difference quantity.
    ///
    /// - Parameters:
    ///   - lhs: The first measure.
    ///   - rhs: The measure to subtract.
    /// - Returns: The difference in the first measure's unit, or NaT if either operand is NaT, the units are
    ///   incompatible, or conversion or subtraction produces a nonfinite result.
    public static func - (
        _ lhs: Self,
        _ rhs: Self.Subtrahend
    ) -> Self.Difference {
        guard lhs.isNaT == false, rhs.isNaT == false, lhs.unit.isCompatible(with: rhs.unit) else {
            return .nat
        }

        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value
        let newValue: Double = lhsValue - rhsValue

        guard newValue.isFinite else {
            return .nat
        }

        return .init(newValue, lhs.unit)
    }
}
