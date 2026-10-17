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
        try Self.validate(self.unit)
        guard self.value.isFinite else {
            throw CalculationError(
                code: .nonFiniteResult,
                message: "The calculation produced a non-finite value."
            )
        }
        return self
    }

    /// Converts a dimensionless measurement into a bounded integer exponent.
    ///
    /// - Returns: The integer value in the dimensionless reference unit.
    /// - Throws: A calculation error for an invalid measurement or an exponent outside the supported integer range.
    internal func exponent() throws -> Int {
        _ = try self.validated()
        guard self.unit.dimension.isDimensionless else {
            throw CalculationError(
                code: .invalidPower,
                message: "Powers must be dimensionless integers between -64 and 64."
            )
        }
        let value: Double = self.converted(to: Self.scalarUnit).value
        guard value.isFinite, value.rounded(.towardZero) == value, (-64 ... 64).contains(value) else {
            throw CalculationError(
                code: .invalidPower,
                message: "Powers must be dimensionless integers between -64 and 64."
            )
        }
        return Int(value)
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
            guard self.unit.isCompatible(with: rhs.unit) else {
                throw CalculationError(
                    code: .incompatibleDimensions,
                    message: "Cannot add or subtract incompatible units."
                )
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
            throw CalculationError(
                code: .invalidSyntax,
                message: "Expected a binary operator."
            )
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
    internal static func validate(_ unit: ComposedUnit) throws {
        guard unit.coefficient.isFinite, unit.coefficient > 0, unit.constant.isFinite else {
            throw CalculationError(
                code: .invalidUnit,
                message: "A unit requires a finite positive scale and finite offset."
            )
        }
        guard Self.exponents(unit.dimension).allSatisfy({ return (-64 ... 64).contains($0) }) else {
            throw CalculationError(
                code: .limitExceeded,
                message: "Dimension exponents must be between -64 and 64."
            )
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
        try Self.validate(lhs)
        try Self.validate(rhs)

        for (left, right) in zip(
            Self.exponents(lhs.dimension),
            Self.exponents(rhs.dimension)
        ) {
            let result: Int = operation == .divide ? left - right : left + right
            guard (-64 ... 64).contains(result) else {
                throw CalculationError(
                    code: .limitExceeded,
                    message: "The resulting dimension exceeds calculator limits."
                )
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
        try Self.validate(unit)

        guard (-64 ... 64).contains(exponent),
            Self.exponents(unit.dimension).allSatisfy({ return (-64 ... 64).contains($0 * exponent) })
        else {
            throw CalculationError(
                code: .limitExceeded,
                message: "The resulting dimension exceeds calculator limits."
            )
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
