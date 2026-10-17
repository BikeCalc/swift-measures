// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures

/// Evaluates parsed expressions through Measures and checks calculator-specific limits.
internal struct ExpressionEvaluator {
    /// Creates an expression evaluator.
    internal init() {}

    /// Evaluates an expression, preserving source locations on calculation errors.
    ///
    /// - Parameters:
    ///   - expression: The parsed expression to evaluate.
    ///   - variables: The measurements substituted for unknown identifiers.
    /// - Returns: The resulting composed measurement.
    /// - Throws: A calculation error for unresolved identifiers, incompatible units, or invalid arithmetic.
    internal func evaluate(
        _ expression: Expression,
        variables: Dictionary<String, Measure<ComposedUnit>> = [:]
    ) throws -> Measure<ComposedUnit> {
        do {
            if self.isUnitExpression(expression) {
                return try Measure(1, self.outputUnit(expression)).validated()
            }
            switch expression.kind {
            case .number(let value):
                return try Measure<ComposedUnit>(value, Measure<ComposedUnit>.scalarUnit).validated()
            case .unit(let unit):
                return try Measure<ComposedUnit>(1, unit.unit).validated()
            case .variable(let name):
                guard let measure: Measure<ComposedUnit> = variables[name] else {
                    throw CalculationError(
                        code: .unknownIdentifier,
                        message: "Unknown unit or variable '\(name)'."
                    )
                }
                return measure
            case .unary(
                let operation,
                let operand
            ):
                let measure: Measure<ComposedUnit> = try self.evaluate(
                    operand,
                    variables: variables
                )
                return try operation == .negative ? measure.negated() : measure
            case .binary(
                let operation,
                let lhs,
                let rhs
            ):
                let left: Measure<ComposedUnit> = try self.evaluate(
                    lhs,
                    variables: variables
                )
                // Juxtaposition attaches a unit to a numeric value, including its offset.
                if operation == .juxtapose, left.unit.dimension.isDimensionless, self.isUnitExpression(rhs) {
                    let value: Double = left.converted(to: Measure<ComposedUnit>.scalarUnit).value
                    return try Measure(value, self.outputUnit(rhs)).validated()
                }
                return try left.applying(
                    operation,
                    to: self.evaluate(
                        rhs,
                        variables: variables
                    )
                )
            }
        } catch let error as CalculationError {
            throw CalculationError(
                code: error.code,
                message: error.message,
                span: error.span ?? expression.span
            )
        }
    }

    /// Evaluates a unit expression without treating an offset as a multiplicative scale.
    ///
    /// - Parameter expression: An expression containing units, products, quotients, and integer powers.
    /// - Returns: The composed destination unit.
    /// - Throws: A calculation error for invalid unit syntax, unsupported offset composition, or invalid conversion
    ///   values.
    internal func outputUnit(_ expression: Expression) throws -> ComposedUnit {
        let unit: ComposedUnit
        switch expression.kind {
        case .unit(let token):
            unit = token.unit
        case .binary(
            let operation,
            let lhs,
            let rhs
        ):
            let left: ComposedUnit = try self.outputUnit(lhs)
            switch operation {
            case .multiply, .juxtapose, .divide:
                let right: ComposedUnit = try self.outputUnit(rhs)
                guard left.constant == 0, right.constant == 0 else {
                    throw self.offsetUnitError()
                }
                try Measure<ComposedUnit>.validateComposition(
                    left,
                    right,
                    operation: operation
                )
                unit = operation == .divide ? left / right : left * right
            case .power:
                guard self.isNumericExpression(rhs) else {
                    throw self.invalidOutput()
                }
                let exponent: Int = try self.evaluate(rhs).exponent()
                guard left.constant == 0 || exponent == 0 || exponent == 1 else {
                    throw self.offsetUnitError()
                }
                try Measure<ComposedUnit>.validatePower(
                    left,
                    exponent: exponent
                )
                unit = (left ** exponent)
            default:
                throw self.invalidOutput()
            }
        default:
            throw self.invalidOutput()
        }
        try Measure<ComposedUnit>.validate(unit)
        return unit
    }

    /// Returns a boolean value indicating whether an expression contains only supported unit operations.
    ///
    /// - Parameter expression: The expression to inspect.
    /// - Returns: Whether the expression consists of units combined with products, quotients, or numeric powers.
    private func isUnitExpression(_ expression: Expression) -> Bool {
        switch expression.kind {
        case .unit:
            return true
        case .binary(
            let operation,
            let lhs,
            let rhs
        ):
            switch operation {
            case .multiply, .juxtapose, .divide:
                return self.isUnitExpression(lhs) && self.isUnitExpression(rhs)
            case .power:
                return self.isUnitExpression(lhs) && self.isNumericExpression(rhs)
            default:
                return false
            }
        default:
            return false
        }
    }

    /// Returns a boolean value indicating whether an expression contains only numbers and arithmetic.
    ///
    /// - Parameter expression: The expression to inspect.
    /// - Returns: Whether the expression contains no units or unknown identifiers.
    private func isNumericExpression(_ expression: Expression) -> Bool {
        switch expression.kind {
        case .number:
            return true
        case .unary(
            _,
            let operand
        ):
            return self.isNumericExpression(operand)
        case .binary(
            _,
            let lhs,
            let rhs
        ):
            return self.isNumericExpression(lhs) && self.isNumericExpression(rhs)
        case .unit, .variable:
            return false
        }
    }

    /// Creates a diagnostic explaining unsupported composition of offset units.
    ///
    /// - Returns: An invalid-unit diagnostic directing the caller to compose measurements instead.
    private func offsetUnitError() -> CalculationError {
        return .init(
            code: .invalidUnit,
            message: "Offset units cannot be composed alone. Use measurements, such as (10 °C) * (2 s)."
        )
    }

    /// Creates a diagnostic for an unsupported output-unit expression.
    ///
    /// - Returns: An invalid-output-unit diagnostic.
    private func invalidOutput() -> CalculationError {
        return .init(
            code: .invalidOutputUnit,
            message: "An output unit must contain units, products, quotients, and integer powers only."
        )
    }
}
