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
            if self.isUnitExpression(expression) == true {
                return try Measure(1, self.outputUnit(expression)).validated()
            }

            switch expression.kind {
            case .number(let value):
                let unit: ComposedUnit = Measure<ComposedUnit>.scalarUnit
                let measure: Measure<ComposedUnit> = .init(value, unit)
                return try measure.validated()
            case .unit(let unit):
                let measure: Measure<ComposedUnit> = .init(1, unit.unit)
                return try measure.validated()
            case .variable(let name):
                guard let measure: Measure<ComposedUnit> = variables[name] else {
                    throw CalculationError.unknownIdentifier(name)
                }

                return measure
            case .unary(let operation, let operand):
                let measure: Measure<ComposedUnit> = try self.evaluate(
                    operand,
                    variables: variables
                )

                if operation == .negative {
                    return try measure.negated()
                }

                return measure
            case .binary(let operation, let lhs, let rhs):
                let left: Measure<ComposedUnit> = try self.evaluate(
                    lhs,
                    variables: variables
                )

                // Juxtaposition attaches a unit to a numeric value, including its offset.
                if operation == .juxtapose, left.unit.dimension.isDimensionless == true,
                    self.isUnitExpression(rhs) == true
                {
                    let value: Double = left.converted(to: Measure<ComposedUnit>.scalarUnit).value
                    let unit: ComposedUnit = try self.outputUnit(rhs)
                    let measure: Measure<ComposedUnit> = .init(value, unit)
                    return try measure.validated()
                }

                let measure: Measure<ComposedUnit> = try self.evaluate(
                    rhs,
                    variables: variables
                )
                return try left.applying(
                    operation,
                    to: measure
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
        case .binary(let operation, let lhs, let rhs):
            let left: ComposedUnit = try self.outputUnit(lhs)

            switch operation {
            case .multiply, .juxtapose, .divide:
                let right: ComposedUnit = try self.outputUnit(rhs)

                guard left.constant == 0, right.constant == 0 else {
                    throw CalculationError.offsetUnitComposition()
                }

                try Measure<ComposedUnit>.validateComposition(
                    left,
                    right,
                    operation: operation
                )
                unit = operation == .divide ? left / right : left * right
            case .power:
                guard self.isNumericExpression(rhs) == true else {
                    throw CalculationError.invalidOutputUnit()
                }

                let measure: Measure<ComposedUnit> = try self.evaluate(rhs)
                let exponent: Int = try measure.exponent()

                guard left.constant == 0 || exponent == 0 || exponent == 1 else {
                    throw CalculationError.offsetUnitComposition()
                }

                try Measure<ComposedUnit>.validatePower(
                    left,
                    exponent: exponent
                )
                unit = (left ** exponent)
            default:
                throw CalculationError.invalidOutputUnit()
            }
        default:
            throw CalculationError.invalidOutputUnit()
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
        case .binary(let operation, let lhs, let rhs):
            switch operation {
            case .multiply, .juxtapose, .divide:
                return self.isUnitExpression(lhs) == true && self.isUnitExpression(rhs) == true
            case .power:
                return self.isUnitExpression(lhs) == true && self.isNumericExpression(rhs) == true
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
        case .unary(_, let operand):
            return self.isNumericExpression(operand)
        case .binary(_, let lhs, let rhs):
            return self.isNumericExpression(lhs) == true && self.isNumericExpression(rhs) == true
        case .unit, .variable:
            return false
        }
    }
}
