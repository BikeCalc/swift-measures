// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreNumericOperators
import NumericsExtended

/// A numeric value paired with a unit.
///
/// Values are stored as `Double`. The generic unit type identifies the available unit definitions; a composed unit
/// additionally carries its physical dimension at runtime. Conversion preserves the represented quantity by applying
/// the source and destination coefficients and constants.
///
/// Initialization stores the supplied value and unit without validating their range. Use `isValid` to check the value
/// and conversion definition against the unit's reference-scale range.
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
        return self.isValidForConversion
            && self.isWithinValidRange
    }

    /// A Boolean value indicating whether this measure is within its dimension's valid range.
    internal var isWithinValidRange: Bool {
        let baseValue: Double = self.value * self.unit.coefficient + self.unit.constant

        return self.unit.validRange.contains(baseValue)
    }

    /// A Boolean value indicating whether this measure defines a finite, invertible conversion.
    internal var isValidForConversion: Bool {
        return self.value.isFinite
            && self.hasValidConversionUnit
    }

    /// A Boolean value indicating whether the unit defines a finite, invertible conversion.
    private var hasValidConversionUnit: Bool {
        return self.unit.coefficient.isFinite
            && self.unit.coefficient.isZero == false
            && self.unit.constant.isFinite
    }
}

// MARK: - Addable

extension Measure: Addable
where UnitType: Equatable {
    public typealias Addend = Self
    public typealias Sum = Self

    public static func + (
        _ lhs: Self,
        _ rhs: Self.Addend
    ) -> Self.Sum {
        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value
        let newValue: Double = lhsValue + rhsValue

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
    /// Returns a boolean value indicating whether this value is canonically equal to the specified value.
    ///
    /// Conversion can introduce floating-point rounding. Use
    /// `isApproximatelyEqual(to:absoluteTolerance:relativeTolerance:)` when a tolerance is appropriate.
    ///
    /// For example:
    ///
    /// ```swift
    /// let oneMeter: Measure<Length> = .init(1, .meter)
    /// let oneHundredCentimeters: Measure<Length> = .init(100, .centimeter)
    /// print(oneMeter.isCanonicallyEqual(to: oneHundredCentimeters))
    /// // Prints "true"
    /// ```
    ///
    /// - Parameter other: An instance to compare.
    /// - Returns: `true` if the converted base values are exactly equal, and `false` otherwise.
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
    public static func < (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value

        return lhsValue < rhsValue
    }
}

// MARK: - Convertible

extension Measure: Convertible {
    /// Returns this measure converted to the specified unit.
    ///
    /// The units must be compatible. Composed units must have matching physical dimensions; conversion does not change
    /// a length into an area. Values outside the unit's valid range are not rejected by this method.
    ///
    /// For example:
    ///
    /// ```swift
    /// let measure: Measure<Length> = .init(1, .meter).converted(to: .centimeter)
    /// print(measure)
    /// // Prints "100.0 cm"
    /// ```
    ///
    /// - Parameter unit: The unit to convert to.
    /// - Returns: The converted measure.
    /// - Precondition: The source and destination units are compatible.
    public func converted(to unit: UnitType) -> Self {
        precondition(
            self.unit.isCompatible(with: unit),
            "Cannot convert between units with incompatible dimensions."
        )

        // Identical valid scales and offsets cancel; preserve the value without conversion rounding.
        if self.hasValidConversionUnit,
            self.unit.coefficient == unit.coefficient,
            self.unit.constant == unit.constant
        {
            return .init(self.value, unit)
        }

        let lhsValue: Double = self.value * self.unit.coefficient + self.unit.constant
        let newValue: Double = (lhsValue - unit.constant) / unit.coefficient

        return .init(newValue, unit)
    }

    /// Converts this measure to the specified unit.
    ///
    /// For example:
    ///
    /// ```swift
    /// var measure: Measure<Length> = .init(1, .meter)
    /// measure.convert(to: .centimeter)
    /// print(measure)
    /// // Prints "100.0 cm"
    /// ```
    ///
    /// - Parameter unit: The unit to convert to.
    /// - Precondition: The source and destination units are compatible.
    public mutating func convert(to unit: UnitType) {
        self = self.converted(to: unit)
    }
}

extension Measure
where UnitType: ComposableUnit {
    /// Returns this measure expressed in a compatible named or composed unit.
    ///
    /// The units must have matching dimensions. Conversion applies both units' coefficients and constants,
    /// without simplifying or normalizing the destination unit. It does not enforce the destination's valid range.
    ///
    /// For example:
    ///
    /// ```swift
    /// let distance = Measure(2, ComposedUnit(Length.kilometer))
    ///
    /// print(distance.converted(to: Length.meter))
    /// // Prints "2000.0 m"
    /// ```
    ///
    /// - Parameter unit: The destination unit, which may have a different concrete type.
    /// - Returns: A measure expressed in the destination unit.
    /// - Precondition: Dimensions match, the destination coefficient is finite and positive, and its constant is finite.
    ///   The input, any intermediate coherent value, and the converted value must be finite.
    public func converted<Destination>(to unit: Destination) -> Measure<Destination>
    where Destination: ComposableUnit {
        precondition(
            self.unit.dimension == unit.dimension,
            "Cannot convert between units with incompatible dimensions."
        )

        precondition(
            unit.coefficient.isFinite && unit.coefficient > 0,
            "Conversion requires a finite positive destination coefficient."
        )

        precondition(
            unit.constant.isFinite,
            "Conversion requires a finite destination constant."
        )

        // Identical scales and offsets cancel; preserve the value without conversion rounding.
        if self.unit.coefficient == unit.coefficient, self.unit.constant == unit.constant {
            precondition(
                self.value.isFinite,
                "Conversion requires a finite source value, even when the units have identical scales and offsets."
            )

            return .init(self.value, unit)
        }

        let value: Double = (self.convertedToCoherentUnit().value - unit.constant) / unit.coefficient

        precondition(
            value.isFinite,
            "Conversion must produce a finite value; the destination scale or offset may cause overflow."
        )

        return .init(value, unit)
    }

    /// Returns this measure expressed in its coherent SI unit, applying its scale and offset.
    private func convertedToCoherentUnit() -> Measure<ComposedUnit> {
        precondition(
            self.value.isFinite,
            "Coherent conversion requires a finite source value."
        )

        let unit = ComposedUnit(dimension: self.unit.dimension)
        let value: Double = self.value * self.unit.coefficient + self.unit.constant

        precondition(
            value.isFinite,
            "Coherent conversion must produce a finite value after applying the source coefficient and constant."
        )

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

extension Measure
where UnitType: ComposableUnit {
    /// Returns the quotient of two measures in a composed coherent SI unit.
    ///
    /// Each value is converted to its coherent SI unit before division, applying its coefficient and constant.
    /// Both converted values and the result must be finite. The converted divisor must be nonzero.
    ///
    /// - Parameters:
    ///   - lhs: The numerator measure.
    ///   - rhs: The denominator measure.
    /// - Returns: The quotient with the numerator dimension divided by the denominator dimension.
    public static func / <Other>(
        _ lhs: Self,
        _ rhs: Measure<Other>
    ) -> Measure<ComposedUnit>
    where Other: ComposableUnit {
        let left: Measure<ComposedUnit> = lhs.convertedToCoherentUnit()
        let right: Measure<ComposedUnit> = rhs.convertedToCoherentUnit()

        precondition(
            right.value != 0,
            "Division requires a nonzero divisor after conversion to coherent units."
        )

        let value: Double = left.value / right.value

        precondition(
            value.isFinite,
            "Division must produce a finite value; the quotient may overflow even with a nonzero divisor."
        )

        return .init(value, (left.unit / right.unit))
    }

    /// Returns the quotient of this measure and another measure in coherent SI units.
    ///
    /// - Parameter divisor: The measure to divide by; its converted coherent value must be nonzero.
    /// - Returns: The quotient with a composed unit.
    /// - Throws: No errors in the current implementation; invalid inputs still fail preconditions.
    public func dividing<Other>(by divisor: Measure<Other>) throws -> Measure<ComposedUnit>
    where Other: ComposableUnit {
        return self / divisor
    }
}

extension Measure
where UnitType == ComposedUnit {
    /// Stores the composed coherent SI quotient of the two measures in the left-hand-side variable.
    ///
    /// Applies the same conversions and preconditions as measure division. The stored dimension may change.
    ///
    /// - Parameters:
    ///   - lhs: The composed measure to replace.
    ///   - rhs: The measure used as the divisor.
    public static func /= <Other>(
        _ lhs: inout Self,
        _ rhs: Measure<Other>
    ) where Other: ComposableUnit {
        lhs = lhs / rhs
    }

    /// Replaces this measure with its composed coherent SI quotient with another measure.
    ///
    /// The stored dimension may change. Constants are applied to absolute values before division.
    ///
    /// - Parameter divisor: The measure used as the divisor.
    /// - Throws: No errors in the current implementation; invalid inputs still fail preconditions.
    public mutating func divide<Other>(by divisor: Measure<Other>) throws
    where Other: ComposableUnit {
        self = try self.dividing(by: divisor)
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
        guard self.unit.isCompatible(with: other.unit), self.isValidForConversion, other.isValidForConversion else {
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

    public static func * (
        _ lhs: Self,
        _ rhs: Self.Multiplier
    ) -> Self.Product {
        let lhsValue: Double = lhs.value
        let newValue: Double = lhsValue * rhs

        return .init(newValue, lhs.unit)
    }
}

extension Measure
where UnitType: ComposableUnit {
    /// Returns the product of two measures in a composed coherent SI unit.
    ///
    /// Each value is converted to its coherent SI unit before multiplication. Constants therefore apply to absolute
    /// values, rather than differences. Both converted values and the result must be finite.
    ///
    /// For example:
    ///
    /// ```swift
    /// let area = Measure<Length>(2, .meter) * Measure<Length>(3, .meter)
    ///
    /// print(area.converted(to: Area.squareMeter))
    /// // Prints "6.0 m²"
    /// ```
    ///
    /// - Parameters:
    ///   - lhs: The first measure.
    ///   - rhs: The second measure.
    /// - Returns: The product with the combined physical dimension.
    public static func * <Other>(
        _ lhs: Self,
        _ rhs: Measure<Other>
    ) -> Measure<ComposedUnit>
    where Other: ComposableUnit {
        let left: Measure<ComposedUnit> = lhs.convertedToCoherentUnit()
        let right: Measure<ComposedUnit> = rhs.convertedToCoherentUnit()
        let value: Double = left.value * right.value

        precondition(
            value.isFinite,
            "Multiplication must produce a finite value; the product must not overflow."
        )

        return .init(value, (left.unit * right.unit))
    }

    /// Returns the product of this measure and another measure in coherent SI units.
    ///
    /// - Parameter multiplier: The measure to multiply by, applying its scale and constant first.
    /// - Returns: The product with a composed unit.
    /// - Throws: No errors in the current implementation; invalid inputs still fail preconditions.
    public func multiplying<Other>(by multiplier: Measure<Other>) throws -> Measure<ComposedUnit>
    where Other: ComposableUnit {
        return self * multiplier
    }
}

extension Measure
where UnitType == ComposedUnit {
    /// Stores the composed coherent SI product of the two measures in the left-hand-side variable.
    ///
    /// Applies the same conversions and preconditions as measure multiplication. The stored dimension may change.
    ///
    /// - Parameters:
    ///   - lhs: The composed measure to replace.
    ///   - rhs: The measure used as the multiplier.
    public static func *= <Other>(
        _ lhs: inout Self,
        _ rhs: Measure<Other>
    ) where Other: ComposableUnit {
        lhs = lhs * rhs
    }

    /// Replaces this measure with its composed coherent SI product with another measure.
    ///
    /// The stored dimension may change. Constants are applied to absolute values before multiplication.
    ///
    /// - Parameter multiplier: The measure used as the multiplier.
    /// - Throws: No errors in the current implementation; invalid inputs still fail preconditions.
    public mutating func multiply<Other>(by multiplier: Measure<Other>) throws
    where Other: ComposableUnit {
        self = try self.multiplying(by: multiplier)
    }
}

// MARK: - Raisable

extension Measure: Raisable
where UnitType: ComposableUnit & Equatable {
    /// The integer exponent applied to the value and its physical dimension.
    public typealias Exponent = Int

    /// The result of exponentiation, whose dimension may differ from the original measure.
    public typealias Power = Measure<ComposedUnit>

    /// Returns a boolean value indicating whether this measure is an integer power of a possibly different measure type.
    ///
    /// Dimensions determine the integer exponent whenever the base has a physical dimension. Both values are converted
    /// to coherent SI values, including offsets, and compared exactly. When both dimensions are dimensionless, the
    /// numeric `isPower(of:)` implementation determines the result.
    ///
    /// Invalid conversions, nonfinite coherent values, and zero bases with negative exponents return `false`.
    /// Physical valid ranges are not enforced. Evaluating a composed dimension uses ordinary integer arithmetic.
    ///
    /// For example:
    ///
    /// ```swift
    /// let area = Measure(4, Area.squareMeter)
    /// let length = Measure(2, Length.meter)
    ///
    /// print(area.isPower(of: length))
    /// // Prints "true"
    /// ```
    ///
    /// - Parameter other: The base measure, whose unit may have a different concrete type or dimension.
    /// - Returns: `true` if an integer power of the base represents this quantity; otherwise, `false`.
    public func isPower<Other>(of other: Measure<Other>) -> Bool
    where Other: ComposableUnit {
        guard self.isValidForConversion, other.isValidForConversion else {
            return false
        }

        let value: Double = self.value * self.unit.coefficient + self.unit.constant
        let base: Double = other.value * other.unit.coefficient + other.unit.constant

        guard value.isFinite, base.isFinite else {
            return false
        }

        var exponent: Self.Exponent?

        for (valueExponent, baseExponent) in zip(
            self.unit.dimension.exponents,
            other.unit.dimension.exponents
        ) {
            if baseExponent == 0 {
                guard valueExponent == 0 else {
                    return false
                }
            } else {
                // Int.min divided by -1 has no representable integer result.
                guard valueExponent != Self.Exponent.min || baseExponent != -1 else {
                    return false
                }

                guard valueExponent % baseExponent == 0 else {
                    return false
                }

                let candidate: Self.Exponent = valueExponent / baseExponent

                if let exponent {
                    guard exponent == candidate else {
                        return false
                    }
                } else {
                    exponent = candidate
                }
            }
        }

        guard let exponent else {
            return value.isPower(of: base)
        }

        guard base != 0 || exponent >= 0 else {
            return false
        }

        let power: Double = base ** exponent

        return power.isFinite && value == power
    }

    /// Returns this measure raised to an integer power in a composed coherent SI unit.
    ///
    /// The value is converted to its coherent SI unit before exponentiation, applying its coefficient and constant.
    /// The converted value and result must be finite. A zero converted value requires a nonnegative exponent.
    /// An exponent of zero returns a dimensionless measure with value one.
    ///
    /// - Parameters:
    ///   - lhs: The measure to raise to a power.
    ///   - rhs: The integer exponent.
    /// - Returns: The power with each physical dimension exponent multiplied by the specified exponent.
    public static func ** (
        _ lhs: Self,
        _ rhs: Self.Exponent
    ) -> Self.Power {
        let coherent: Measure<ComposedUnit> = lhs.convertedToCoherentUnit()

        precondition(
            coherent.value != 0 || rhs >= 0,
            "Exponentiation cannot raise a zero coherent value to a negative exponent."
        )

        let value: Double = coherent.value ** rhs

        precondition(
            value.isFinite,
            "Exponentiation must produce a finite value; the power must not overflow."
        )

        return .init(value, (coherent.unit ** rhs))
    }

    /// Returns this measure raised to the specified integer exponent in coherent SI units.
    ///
    /// - Parameter exponent: The integer exponent.
    /// - Returns: The power with a composed unit.
    /// - Throws: No errors in the current implementation; invalid inputs still fail preconditions.
    public func raising(to exponent: Self.Exponent) throws -> Self.Power {
        return self ** exponent
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

    public static func - (
        _ lhs: Self,
        _ rhs: Self.Subtrahend
    ) -> Self.Difference {
        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value
        let newValue: Double = lhsValue - rhsValue

        return .init(newValue, lhs.unit)
    }
}
