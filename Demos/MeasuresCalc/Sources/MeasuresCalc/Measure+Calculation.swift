// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures

extension Measure
where UnitType == ComposedUnit {
    /// The dimensionless unit used for ordinary numbers and equation coefficients.
    internal static var scalarUnit: ComposedUnit {
        return .init(Length.meter) ** 0
    }

    /// Checks conversion values, dimension limits, and a finite measurement value.
    ///
    /// - Returns: This measurement unchanged after validation.
    /// - Throws: A calculation error for invalid conversion values, excessive dimensions, or a non-finite value.
    internal func validated() throws -> Self {
        guard self.value.isFinite == true else {
            throw CalculationError.nonFiniteResult()
        }

        try Self.validateUnit(self.unit)
        return self
    }

    /// Converts a dimensionless measurement into a bounded integer exponent.
    ///
    /// - Returns: The integer value in the dimensionless reference unit.
    /// - Throws: A calculation error for an invalid measurement or an exponent outside the supported integer range.
    internal func exponent() throws -> Int {
        _ = try self.validated()

        guard self.unit.dimension.isDimensionless == true else {
            throw CalculationError.invalidPower()
        }

        let value: Double = self.converted(to: Self.scalarUnit).value

        guard value.isFinite == true, value.rounded(.towardZero) == value, (-64 ... 64).contains(value) == true else {
            throw CalculationError.invalidPower()
        }

        return .init(value)
    }

    /// Applies binary arithmetic using Measures after checking calculator limits.
    ///
    /// - Parameters:
    ///   - operation: The binary operation to perform.
    ///   - rhs: The right-hand operand.
    /// - Returns: The resulting composed measurement.
    /// - Throws: A calculation error for incompatible units, unsupported powers, invalid operands, or non-finite
    ///   results.
    internal func applying(
        _ operation: OperatorToken,
        to rhs: Self
    ) throws -> Self {
        _ = try self.validated()
        _ = try rhs.validated()
        let result: Self

        switch operation {
        case .add, .subtract:
            guard self.unit.isCompatible(with: rhs.unit) == true else {
                throw CalculationError.incompatibleArithmeticDimensions()
            }

            result = try operation == .add ? self.adding(rhs) : self.subtracting(rhs)
        case .multiply, .juxtapose, .divide:
            try Self.validateComposition(
                self.unit,
                rhs.unit,
                operation: operation
            )
            result = try operation == .divide ? self.dividing(by: rhs) : self.multiplying(by: rhs)
        case .power:
            let exponent: Int = try rhs.exponent()
            try Self.validatePower(
                self.unit,
                exponent: exponent
            )
            result = try self.raising(to: exponent)
        case .positive, .negative:
            throw CalculationError.expectedBinaryOperator()
        }

        return try result.validated()
    }

    /// Negates the stored value without changing its unit.
    ///
    /// - Returns: The negated measurement.
    /// - Throws: A calculation error for an invalid unit or non-finite value.
    internal func negated() throws -> Self {
        return try Self(-self.value, self.unit).validated()
    }

    /// Checks a calculator-produced unit’s conversion values and dimension limits.
    ///
    /// - Parameter unit: The unit to validate; its stored dimension arithmetic must already be representable.
    /// - Throws: A calculation error for a nonpositive or non-finite scale, non-finite offset, or excessive dimension
    ///   exponent.
    internal static func validateUnit(_ unit: ComposedUnit) throws {
        guard unit.coefficient.isFinite == true, unit.coefficient > 0, unit.constant.isFinite == true else {
            throw CalculationError.invalidUnitConversion()
        }

        guard Self.exponents(unit.dimension).allSatisfy({ (-64 ... 64).contains($0) }) == true else {
            throw CalculationError.dimensionLimitExceeded()
        }
    }

    /// Checks the result dimension before composing calculator-produced units.
    ///
    /// - Parameters:
    ///   - lhs: The first unit.
    ///   - rhs: The second unit.
    ///   - operation: Division subtracts exponents; multiplication and juxtaposition add them.
    /// - Throws: A calculation error for invalid input units or a resulting exponent outside -64 through 64.
    internal static func validateComposition(
        _ lhs: ComposedUnit,
        _ rhs: ComposedUnit,
        operation: OperatorToken
    ) throws {
        try Self.validateUnit(lhs)
        try Self.validateUnit(rhs)

        for (left, right) in zip(Self.exponents(lhs.dimension), Self.exponents(rhs.dimension)) {
            let result: Int = operation == .divide ? left - right : left + right

            guard (-64 ... 64).contains(result) == true else {
                throw CalculationError.resultingDimensionLimitExceeded()
            }
        }
    }

    /// Checks dimension limits before raising a calculator-produced unit to a power.
    ///
    /// - Parameters:
    ///   - unit: The unit whose dimension is raised.
    ///   - exponent: The integer exponent to apply.
    /// - Throws: A calculation error for an invalid unit or an input or resulting exponent outside -64 through 64.
    internal static func validatePower(
        _ unit: ComposedUnit,
        exponent: Int
    ) throws {
        try Self.validateUnit(unit)

        guard (-64 ... 64).contains(exponent) == true,
            Self.exponents(unit.dimension).allSatisfy({ (-64 ... 64).contains($0 * exponent) }) == true
        else {
            throw CalculationError.resultingDimensionLimitExceeded()
        }
    }

    /// Collects the seven SI dimension exponents in the library’s dimension order.
    ///
    /// - Parameter dimension: The dimension to inspect.
    /// - Returns: The length, mass, time, current, temperature, substance amount, and luminous intensity exponents.
    private static func exponents(_ dimension: Dimension) -> Array<Int> {
        return [
            dimension.length,
            dimension.mass,
            dimension.time,
            dimension.electricCurrent,
            dimension.thermodynamicTemperature,
            dimension.substanceAmount,
            dimension.luminousIntensity
        ]
    }
}
