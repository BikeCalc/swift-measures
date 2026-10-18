// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import CoreNumericOperators
import NumericsExtended

// MARK: - CanonicallyEquatable

extension Measure
where UnitType: ComposableUnit {
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
    /// let oneHundredCentimeters: Measure<ComposedUnit> = .init(100, ComposedUnit(Length.centimeter))
    ///
    /// print(oneMeter.isCanonicallyEqual(to: oneHundredCentimeters))
    /// // Prints "true"
    /// ```
    ///
    /// - Parameter other: The measure to compare with this measure.
    /// - Returns: `true` if the units are compatible and the converted values are exactly equal, and `false` otherwise.
    public func isCanonicallyEqual<Other>(to other: Measure<Other>) -> Bool
    where Other: ComposableUnit {
        guard self.unit.isCompatible(with: other.unit) else {
            return false
        }

        let lhsValue: Double = self.value * self.unit.coefficient + self.unit.constant
        let rhsValue: Double = other.value * other.unit.coefficient + other.unit.constant

        return lhsValue == rhsValue
    }
}

// MARK: - Convertible

extension Measure
where UnitType: ComposableUnit {
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
    /// let distance: Measure<ComposedUnit> = .init(1, ComposedUnit(Length.meter))
    ///
    /// print(distance.converted(to: Length.centimeter))
    /// // Prints "100.0 cm"
    /// ```
    ///
    /// - Parameter unit: The unit to convert to.
    /// - Returns: A measure expressed in the destination unit.
    /// - Precondition: The source and destination units are compatible, both coefficients are finite and positive, and
    ///   both constants are finite.
    public func converted<Destination>(to unit: Destination) -> Measure<Destination>
    where Destination: ComposableUnit {
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

    /// Returns this measure expressed in its coherent SI unit, applying its scale and offset.
    private func convertedToCoherentUnit() -> Measure<ComposedUnit> {
        precondition(
            self.unit.coefficient.isFinite && self.unit.coefficient > 0,
            "Coherent conversion requires a finite positive source coefficient."
        )

        precondition(
            self.unit.constant.isFinite,
            "Coherent conversion requires a finite source constant."
        )

        let unit: ComposedUnit = .init(dimension: self.unit.dimension)
        let value: Double = self.value * self.unit.coefficient + self.unit.constant

        return .init(value, unit)
    }
}

// MARK: - Divisible

extension Measure
where UnitType: ComposableUnit {
    /// Returns the quotient of two measures in a composed coherent SI unit.
    ///
    /// Each value is converted to its coherent SI unit before division, applying its coefficient and constant.
    /// Constants apply to absolute values, rather than differences. Valid ranges are not enforced. Values follow
    /// ordinary `Double` division, including infinity and NaN for division by zero.
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

        let value: Double = left.value / right.value

        return .init(value, (left.unit / right.unit))
    }

    /// Returns the quotient of this measure and another measure in coherent SI units.
    ///
    /// - Parameter divisor: The measure to divide by, applying its scale and constant first.
    /// - Returns: The quotient with a composed unit.
    /// - Throws: No errors in the current implementation; invalid unit definitions still fail preconditions.
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
    /// - Throws: No errors in the current implementation; invalid unit definitions still fail preconditions.
    public mutating func divide<Other>(by divisor: Measure<Other>) throws
    where Other: ComposableUnit {
        self = try self.dividing(by: divisor)
    }
}

// MARK: - Multipliable

extension Measure
where UnitType: ComposableUnit {
    /// Returns the product of two measures in a composed coherent SI unit.
    ///
    /// Each value is converted to its coherent SI unit before multiplication. Constants therefore apply to absolute
    /// values, rather than differences. Values follow ordinary `Double` multiplication, including infinity and NaN.
    /// Valid ranges are not enforced.
    ///
    /// For example:
    ///
    /// ```swift
    /// let area: Measure<ComposedUnit> = Measure<Length>(2, .meter) * Measure<Length>(3, .meter)
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

    /// Returns a boolean value indicating whether this measure is an integer power of a possibly different measure
    /// type.
    ///
    /// Dimensions determine the integer exponent whenever the base has a physical dimension. Both values are converted
    /// to coherent SI values, including offsets, and compared exactly. When both dimensions are dimensionless, the
    /// numeric `isPower(of:)` implementation determines the result.
    ///
    /// Invalid conversions, nonfinite coherent values, and zero bases with negative exponents return `false`. Physical
    /// valid ranges are not enforced. Evaluating a composed dimension uses ordinary integer arithmetic.
    ///
    /// For example:
    ///
    /// ```swift
    /// let area: Measure<Area> = .init(4, .squareMeter)
    /// let length: Measure<Length> = .init(2, .meter)
    ///
    /// print(area.isPower(of: length))
    /// // Prints "true"
    /// ```
    ///
    /// - Parameter other: The base measure, whose unit may have a different concrete type or dimension.
    /// - Returns: `true` if an integer power of the base represents this quantity; otherwise, `false`.
    public func isPower<Other>(of other: Measure<Other>) -> Bool
    where Other: ComposableUnit {
        guard self.isNaT == false, other.isNaT == false else {
            return false
        }

        let value: Double = self.value * self.unit.coefficient + self.unit.constant
        let base: Double = other.value * other.unit.coefficient + other.unit.constant

        guard value.isFinite, base.isFinite else {
            return false
        }

        var exponent: Self.Exponent?

        for (valueExponent, baseExponent) in zip(self.unit.dimension.exponents, other.unit.dimension.exponents) {
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
    /// The value is converted to its coherent SI unit before exponentiation, applying its coefficient and constant. The
    /// constant applies to an absolute value, rather than a difference. Valid ranges are not enforced. The numeric
    /// result follows Numerics Extended's `Double` exponentiation, including infinity and NaN. An exponent of zero
    /// returns a dimensionless measure with value one.
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

        let value: Double = coherent.value ** rhs

        return .init(value, (coherent.unit ** rhs))
    }

    /// Returns this measure raised to the specified integer exponent in coherent SI units.
    ///
    /// - Parameter exponent: The integer exponent.
    /// - Returns: The power with a composed unit.
    /// - Throws: No errors in the current implementation; invalid unit definitions still fail preconditions.
    public func raising(to exponent: Self.Exponent) throws -> Self.Power {
        return self ** exponent
    }
}
