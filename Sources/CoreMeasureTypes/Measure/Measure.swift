// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import NumericsExtended

/// A representation of a measure.
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

    /// A Boolean value indicating whether this measure is valid.
    public var isValid: Bool {
        return self.isValidForConversion
            && self.isWithinValidRange
    }

    /// A Boolean value indicating whether this measure is within its dimension's valid range.
    internal var isWithinValidRange: Bool {
        let baseValue: Double = self.value * self.unit.coefficient + self.unit.constant

        return UnitType.validRange.contains(baseValue)
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
    public static func + (_ lhs: Self, _ rhs: Self) -> Self {
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
    /// ```swift
    /// let measure: Measure<Length> = .init(1, .meter).converted(to: .centimeter)
    /// print(measure)
    /// // Prints "100.0 cm"
    /// ```
    ///
    /// - Parameter unit: The unit to convert to.
    /// - Returns: The converted measure.
    public func converted(to unit: UnitType) -> Self {
        precondition(self.unit.isCompatible(with: unit))

        let lhsValue: Double = self.value * self.unit.coefficient + self.unit.constant
        let newValue: Double = (lhsValue - unit.constant) / unit.coefficient
        return .init(newValue, unit)
    }

    /// Converts this measure to the specified unit.
    ///
    /// ```swift
    /// var measure: Measure<Length> = .init(1, .meter)
    /// measure.convert(to: .centimeter)
    /// print(measure)
    /// // Prints "100.0 cm"
    /// ```
    ///
    /// - Parameter unit: The unit to convert to.
    public mutating func convert(to unit: UnitType) {
        self = self.converted(to: unit)
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

extension Measure {
    /// Returns a Boolean value indicating whether this measure's value is divisible by the specified value.
    ///
    /// - Parameter other: The value to test.
    /// - Returns: `true` if this measure's value is divisible by the specified value, and `false` otherwise.
    public func isDivisible(by other: Double) -> Bool {
        return self.value.isDivisible(by: other)
    }

    /// Returns the quotient of dividing the first specified value by the second.
    ///
    /// - Parameters:
    ///   - lhs: The dividend.
    ///   - rhs: The divisor.
    /// - Returns: The quotient.
    public static func / (_ lhs: Self, _ rhs: Double) -> Self {
        let lhsValue: Double = lhs.value
        let newValue: Double = lhsValue / rhs

        return .init(newValue, lhs.unit)
    }

    /// Divides the first specified value by the second and stores the quotient in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: The dividend.
    ///   - rhs: The divisor.
    public static func /= (_ lhs: inout Self, _ rhs: Double) {
        lhs = lhs / rhs
    }

    /// Returns the remainder of dividing the first specified value by the second.
    ///
    /// - Parameters:
    ///   - lhs: The dividend.
    ///   - rhs: The divisor.
    /// - Returns: The remainder.
    public static func % (_ lhs: Self, _ rhs: Double) -> Self {
        let lhsValue: Double = lhs.value
        let newValue: Double = lhsValue.truncatingRemainder(dividingBy: rhs)

        return .init(newValue, lhs.unit)
    }

    /// Divides the first specified value by the second and stores the remainder in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: The dividend.
    ///   - rhs: The divisor.
    public static func %= (_ lhs: inout Self, _ rhs: Double) {
        lhs = lhs % rhs
    }

    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - Parameter divisor: The divisor.
    /// - Returns: The quotient.
    public func dividing(by divisor: Double) -> Self {
        return self / divisor
    }

    /// Divides this value by the specified value and produces the quotient.
    ///
    /// - Parameter divisor: The divisor.
    public mutating func divide(by divisor: Double) {
        self /= divisor
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

extension Measure {
    /// Returns a Boolean value indicating whether this measure's value is a multiple of the specified value.
    ///
    /// - Parameter other: The value to test.
    /// - Returns: `true` if this measure's value is a multiple of the specified value, and `false` otherwise.
    public func isMultiple(of other: Double) -> Bool {
        return self.value.isMultiple(of: other)
    }

    /// Returns the product of multiplying the two specified values.
    ///
    /// - Parameters:
    ///   - lhs: The multiplicand.
    ///   - rhs: The multiplier.
    /// - Returns: The product.
    public static func * (_ lhs: Self, _ rhs: Double) -> Self {
        let lhsValue: Double = lhs.value
        let newValue: Double = lhsValue * rhs

        return .init(newValue, lhs.unit)
    }

    /// Returns the product of multiplying the two specified values.
    ///
    /// - Parameters:
    ///   - lhs: The multiplicand.
    ///   - rhs: The multiplier.
    /// - Returns: The product.
    public static func * (_ lhs: Double, _ rhs: Self) -> Self {
        let rhsValue: Double = rhs.value
        let newValue: Double = lhs * rhsValue

        return .init(newValue, rhs.unit)
    }

    /// Multiplies the two specified values and stores the product in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: The multiplicand.
    ///   - rhs: The multiplier.
    public static func *= (_ lhs: inout Self, _ rhs: Double) {
        lhs = lhs * rhs
    }

    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - Parameter multiplier: The multiplier.
    /// - Returns: The product.
    public func multiplying(by multiplier: Double) -> Self {
        return self * multiplier
    }

    /// Multiplies this value by the specified value and produces the product.
    ///
    /// - Parameter multiplier: The multiplier.
    public mutating func multiply(by multiplier: Double) {
        self *= multiplier
    }
}

// MARK: - Sendable

extension Measure: Sendable
where UnitType: Sendable {}

// MARK: - Subtractable

extension Measure: Subtractable
where UnitType: Equatable {
    public static func - (_ lhs: Self, _ rhs: Self) -> Self {
        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value
        let newValue: Double = lhsValue - rhsValue

        return .init(newValue, lhs.unit)
    }
}
