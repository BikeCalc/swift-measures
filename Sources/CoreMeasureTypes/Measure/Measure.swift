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
/// `isValid` to check the value and conversion definition against the unit's reference-scale range.
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

    /// An error related to a measure's units.
    public enum UnitError: Equatable, Error, Sendable {
        /// The units are incompatible.
        ///
        /// For composed units, this means their physical dimensions differ.
        case incompatibleUnits
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
        return self.isValidForConversion
            && self.isWithinValidRange
    }

    /// A Boolean value indicating whether this measure is within its dimension's valid range.
    internal var isWithinValidRange: Bool {
        let baseValue: Double = self.value * self.unit.coefficient + self.unit.constant

        return self.unit.validRange.contains(baseValue)
    }

    /// A Boolean value indicating whether this measure has a finite value and a valid conversion definition.
    package var isValidForConversion: Bool {
        return self.value.isFinite
            && self.hasValidConversionUnit
    }

    /// A Boolean value indicating whether the unit has a finite positive coefficient and a finite constant.
    private var hasValidConversionUnit: Bool {
        return self.unit.coefficient.isFinite
            && self.unit.coefficient > 0
            && self.unit.constant.isFinite
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
    /// - Returns: The sum in the first measure's unit.
    /// - Precondition: The units are compatible, both coefficients are finite and positive, and both constants are
    ///   finite.
    public static func + (
        _ lhs: Self,
        _ rhs: Self.Addend
    ) -> Self.Sum {
        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value
        let newValue: Double = lhsValue + rhsValue

        return .init(newValue, lhs.unit)
    }

    /// Returns the sum after converting the other measure to this measure's unit.
    ///
    /// Adds the readings in this unit, retaining its constant and without clamping the result to its valid range.
    ///
    /// Values follow ordinary `Double` arithmetic. The inherited mutating method leaves this measure unchanged if the
    /// units are incompatible and this method throws.
    ///
    /// - Parameter addend: The measure to add.
    /// - Returns: The sum in this measure's unit.
    /// - Throws: `Self.UnitError.incompatibleUnits` if the operand units are incompatible.
    /// - Precondition: Both unit coefficients are finite and positive and both constants are finite, as required for
    ///   conversion.
    public func adding(_ addend: Self.Addend) throws -> Self.Sum {
        guard self.unit.isCompatible(with: addend.unit) else {
            throw Self.UnitError.incompatibleUnits
        }

        return self + addend
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
    /// magnitude in the base unit. Matching infinities compare equal; NaN, invalid conversions or tolerances, and
    /// conversion overflow return `false`.
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
        guard self.unit.isCompatible(with: other.unit),
            self.unit.isCompatible(with: absoluteTolerance.unit),
            self.hasValidConversionUnit,
            other.hasValidConversionUnit,
            absoluteTolerance.isValidForConversion,
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

        // Allow an infinite converted value only when its input was already infinite. A finite input that becomes
        // infinite during conversion has overflowed and must not compare equal to another infinity. NaN passes neither
        // check.
        guard toleranceValue.isFinite,
            lhsValue.isFinite || (self.value.isInfinite && lhsValue.isInfinite),
            rhsValue.isFinite || (other.value.isInfinite && rhsValue.isInfinite)
        else {
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
    /// Conversion can introduce floating-point rounding. Equality is exact rather than approximate, and NaN values
    /// compare unequal.
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
        guard self.unit.isCompatible(with: other.unit) else {
            return false
        }

        let lhsValue: Double = self.value * self.unit.coefficient + self.unit.constant
        let rhsValue: Double = other.value * other.unit.coefficient + other.unit.constant

        return lhsValue == rhsValue
    }
}

// MARK: - Comparable

extension Measure: Comparable
where UnitType: Equatable {
    /// Returns a boolean value indicating whether this measure is less than the specified measure.
    ///
    /// Compatible units follow ordinary `Double` comparison behavior, including unordered NaN values.
    ///
    /// - Parameter other: The measure to compare with this measure.
    /// - Returns: The comparison result after converting the other measure to this measure's unit.
    /// - Throws: `Self.UnitError.incompatibleUnits` if the operand units are incompatible.
    /// - Precondition: Compatible units have finite positive coefficients and finite constants.
    public func isLess(than other: Self) throws -> Bool {
        guard self.unit.isCompatible(with: other.unit) else {
            throw Self.UnitError.incompatibleUnits
        }

        return self < other
    }

    /// Returns a boolean value indicating whether this measure is less than or equal to the specified measure.
    ///
    /// Compatible units follow ordinary `Double` comparison behavior, including unordered NaN values.
    ///
    /// - Parameter other: The measure to compare with this measure.
    /// - Returns: The comparison result after converting the other measure to this measure's unit.
    /// - Throws: `Self.UnitError.incompatibleUnits` if the operand units are incompatible.
    /// - Precondition: Compatible units have finite positive coefficients and finite constants.
    public func isLessThanOrEqual(to other: Self) throws -> Bool {
        guard self.unit.isCompatible(with: other.unit) else {
            throw Self.UnitError.incompatibleUnits
        }

        return self <= other
    }

    /// Returns a boolean value indicating whether this measure is greater than the specified measure.
    ///
    /// Compatible units follow ordinary `Double` comparison behavior, including unordered NaN values.
    ///
    /// - Parameter other: The measure to compare with this measure.
    /// - Returns: The comparison result after converting the other measure to this measure's unit.
    /// - Throws: `Self.UnitError.incompatibleUnits` if the operand units are incompatible.
    /// - Precondition: Compatible units have finite positive coefficients and finite constants.
    public func isGreater(than other: Self) throws -> Bool {
        guard self.unit.isCompatible(with: other.unit) else {
            throw Self.UnitError.incompatibleUnits
        }

        return self > other
    }

    /// Returns a boolean value indicating whether this measure is greater than or equal to the specified measure.
    ///
    /// Compatible units follow ordinary `Double` comparison behavior, including unordered NaN values.
    ///
    /// - Parameter other: The measure to compare with this measure.
    /// - Returns: The comparison result after converting the other measure to this measure's unit.
    /// - Throws: `Self.UnitError.incompatibleUnits` if the operand units are incompatible.
    /// - Precondition: Compatible units have finite positive coefficients and finite constants.
    public func isGreaterThanOrEqual(to other: Self) throws -> Bool {
        guard self.unit.isCompatible(with: other.unit) else {
            throw Self.UnitError.incompatibleUnits
        }

        return self >= other
    }

    /// Returns a boolean value indicating whether the first measure is less than the second.
    ///
    /// Incompatible units are unordered and return `false`. Compatible units are compared after converting the second
    /// measure to the first measure's unit, following ordinary `Double` comparison behavior.
    ///
    /// - Parameters:
    ///   - lhs: The first measure to compare.
    ///   - rhs: The second measure to compare.
    /// - Returns: The comparison result, or `false` if the units are incompatible.
    /// - Precondition: Compatible units have finite positive coefficients and finite constants.
    public static func < (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        guard lhs.unit.isCompatible(with: rhs.unit) else {
            return false
        }

        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value

        return lhsValue < rhsValue
    }

    /// Returns a boolean value indicating whether the first measure is less than or equal to the second.
    ///
    /// Incompatible units are unordered and return `false`. Compatible units are compared after converting the second
    /// measure to the first measure's unit, following ordinary `Double` comparison behavior.
    ///
    /// - Parameters:
    ///   - lhs: The first measure to compare.
    ///   - rhs: The second measure to compare.
    /// - Returns: The comparison result, or `false` if the units are incompatible.
    /// - Precondition: Compatible units have finite positive coefficients and finite constants.
    public static func <= (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        guard lhs.unit.isCompatible(with: rhs.unit) else {
            return false
        }

        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value

        return lhsValue <= rhsValue
    }

    /// Returns a boolean value indicating whether the first measure is greater than the second.
    ///
    /// Incompatible units are unordered and return `false`. Compatible units are compared after converting the second
    /// measure to the first measure's unit, following ordinary `Double` comparison behavior.
    ///
    /// - Parameters:
    ///   - lhs: The first measure to compare.
    ///   - rhs: The second measure to compare.
    /// - Returns: The comparison result, or `false` if the units are incompatible.
    /// - Precondition: Compatible units have finite positive coefficients and finite constants.
    public static func > (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        guard lhs.unit.isCompatible(with: rhs.unit) else {
            return false
        }

        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value

        return lhsValue > rhsValue
    }

    /// Returns a boolean value indicating whether the first measure is greater than or equal to the second.
    ///
    /// Incompatible units are unordered and return `false`. Compatible units are compared after converting the second
    /// measure to the first measure's unit, following ordinary `Double` comparison behavior.
    ///
    /// - Parameters:
    ///   - lhs: The first measure to compare.
    ///   - rhs: The second measure to compare.
    /// - Returns: The comparison result, or `false` if the units are incompatible.
    /// - Precondition: Compatible units have finite positive coefficients and finite constants.
    public static func >= (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        guard lhs.unit.isCompatible(with: rhs.unit) else {
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
    /// unit. Values outside the unit's valid range are not rejected. Measurement values follow ordinary `Double`
    /// arithmetic: infinity and NaN propagate, and overflow may produce infinity.
    ///
    /// The source and destination units must be compatible. For composable units, their physical dimensions must match.
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
    /// - Returns: A measure expressed in the destination unit.
    /// - Precondition: The source and destination units are compatible, both coefficients are finite and positive, and
    ///   both constants are finite.
    public func converted(to unit: UnitType) -> Self {
        precondition(
            self.unit.isCompatible(with: unit),
            "Cannot convert between units with incompatible dimensions."
        )

        precondition(
            self.unit.coefficient.isFinite && self.unit.coefficient > 0,
            "Conversion requires a finite positive source coefficient."
        )

        precondition(
            unit.coefficient.isFinite && unit.coefficient > 0,
            "Conversion requires a finite positive destination coefficient."
        )

        precondition(
            self.unit.constant.isFinite,
            "Conversion requires a finite source constant."
        )

        precondition(
            unit.constant.isFinite,
            "Conversion requires a finite destination constant."
        )

        // Identical scales and offsets cancel; preserve the value without conversion rounding.
        if self.unit.coefficient == unit.coefficient, self.unit.constant == unit.constant {
            return .init(self.value, unit)
        }

        let referenceValue: Double = self.value * self.unit.coefficient + self.unit.constant
        let value: Double = (referenceValue - unit.constant) / unit.coefficient

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
            self.isValidForConversion,
            other.isValidForConversion
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
    /// not the absolute reference value. The result follows ordinary `Double` arithmetic and is not clamped.
    ///
    /// - Parameters:
    ///   - lhs: The measure whose reading is scaled.
    ///   - rhs: The scalar used to scale the reading.
    /// - Returns: The quotient in the original unit.
    public static func / (
        _ lhs: Self,
        _ rhs: Self.Divisor
    ) -> Self.Quotient {
        let lhsValue: Double = lhs.value
        let newValue: Double = lhsValue / rhs

        return .init(newValue, lhs.unit)
    }

    public static func % (
        _ lhs: Self,
        _ rhs: Self.RemainderDivisor
    ) -> Self.Remainder {
        let lhsValue: Double = lhs.value
        let newValue: Double = lhsValue.truncatingRemainder(dividingBy: rhs)

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
            self.isValidForConversion,
            other.isValidForConversion
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
    /// not the absolute reference value. The result follows ordinary `Double` arithmetic and is not clamped.
    ///
    /// - Parameters:
    ///   - lhs: The measure whose reading is scaled.
    ///   - rhs: The scalar used to scale the reading.
    /// - Returns: The product in the original unit.
    public static func * (
        _ lhs: Self,
        _ rhs: Self.Multiplier
    ) -> Self.Product {
        let lhsValue: Double = lhs.value
        let newValue: Double = lhsValue * rhs

        return .init(newValue, lhs.unit)
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
    /// - Returns: The difference in the first measure's unit.
    /// - Precondition: The units are compatible, both coefficients are finite and positive, and both constants are
    ///   finite.
    public static func - (
        _ lhs: Self,
        _ rhs: Self.Subtrahend
    ) -> Self.Difference {
        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value
        let newValue: Double = lhsValue - rhsValue

        return .init(newValue, lhs.unit)
    }

    /// Returns the difference after converting the other measure to this measure's unit.
    ///
    /// Subtracts the readings in this unit, retaining its constant and without clamping the result to its valid range.
    /// Subtracting temperatures does not create a distinct temperature-difference quantity.
    ///
    /// Values follow ordinary `Double` arithmetic. The inherited mutating method leaves this measure unchanged if the
    /// units are incompatible and this method throws.
    ///
    /// - Parameter subtrahend: The measure to subtract.
    /// - Returns: The difference in this measure's unit.
    /// - Throws: `Self.UnitError.incompatibleUnits` if the operand units are incompatible.
    /// - Precondition: Both unit coefficients are finite and positive and both constants are finite, as required for
    ///   conversion.
    public func subtracting(_ subtrahend: Self.Subtrahend) throws -> Self.Difference {
        guard self.unit.isCompatible(with: subtrahend.unit) else {
            throw Self.UnitError.incompatibleUnits
        }

        return self - subtrahend
    }
}
