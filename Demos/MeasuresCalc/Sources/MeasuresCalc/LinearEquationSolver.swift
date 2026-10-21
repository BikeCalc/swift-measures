// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures

/// Solves a single linear equation by collecting coefficients and substituting the resulting measurement.
internal struct LinearEquationSolver {
    /// The registered units whose symbols cannot be used as the unknown name.
    private let units: UnitRegistry

    /// The evaluator used for constant subexpressions and solution substitution.
    private let evaluator: ExpressionEvaluator

    /// Creates a solver using the specified unit registry.
    ///
    /// - Parameter units: The registered symbols reserved for units.
    internal init(units: UnitRegistry) {
        self.units = units
        self.evaluator = .init()
    }

    /// Solves a linear equation and checks the dimensions after substituting its solution.
    ///
    /// - Parameters:
    ///   - lhs: The parsed left side of the equation.
    ///   - rhs: The parsed right side of the equation.
    ///   - variable: The unknown identifier to solve for.
    /// - Returns: The unique solution as a composed measurement.
    /// - Throws: A calculation error for unsupported equations, incompatible dimensions, invalid arithmetic, or no
    ///   unique solution.
    internal func solve(
        lhs: Expression,
        rhs: Expression,
        variable: String
    ) throws -> Measure<ComposedUnit> {
        guard self.units.symbols.contains(variable) == false,
            variable.isEmpty == false,
            variable.allSatisfy({ $0.isLetter }) == true
        else {
            throw CalculationError.invalidVariableName()
        }

        guard lhs.containsOffsetUnit == false, rhs.containsOffsetUnit == false else {
            throw CalculationError.offsetEquation()
        }

        let left: LinearExpression = try self.linearize(
            lhs,
            variable: variable
        )
        let right: LinearExpression = try self.linearize(
            rhs,
            variable: variable
        )
        let difference: LinearExpression = try left.adding(right.negated())

        guard let coefficient: Measure<ComposedUnit> = difference.coefficient, coefficient.value != 0 else {
            let isIdentity: Bool = difference.constant == nil || difference.constant?.value == 0

            if isIdentity == true {
                throw CalculationError.infiniteSolutions()
            } else {
                throw CalculationError.noSolution()
            }
        }

        let constant: Measure<ComposedUnit> =
            difference.constant
            ?? Measure<ComposedUnit>(0, Measure<ComposedUnit>.scalarUnit)
        let solution: Measure<ComposedUnit> = try constant.negated().applying(
            .divide,
            to: coefficient
        )
        // Substitution validates the dimensions of the original equation, including canceled terms.
        let resolvedLeft: Measure<ComposedUnit> = try self.evaluator.evaluate(
            lhs,
            variables: [variable: solution]
        )
        let resolvedRight: Measure<ComposedUnit> = try self.evaluator.evaluate(
            rhs,
            variables: [variable: solution]
        )

        guard resolvedLeft.unit.dimension == resolvedRight.unit.dimension else {
            throw CalculationError.incompatibleEquationDimensions()
        }

        return solution
    }

    /// Collects the coefficient and constant terms of a linear expression.
    ///
    /// - Parameters:
    ///   - expression: The expression to collect.
    ///   - variable: The unknown identifier whose coefficient is collected.
    /// - Returns: The linear expression with optional coefficient and constant terms.
    /// - Throws: A calculation error for nonlinear operations, unknown denominators, or invalid constant arithmetic.
    private func linearize(
        _ expression: Expression,
        variable: String
    ) throws -> LinearExpression {
        do {
            if expression.containsVariable == false {
                return try .init(constant: self.evaluator.evaluate(expression))
            }

            switch expression.kind {
            case .variable(let name)
            where name == variable:
                let measure: Measure<ComposedUnit> = .init(1, Measure<ComposedUnit>.scalarUnit)
                return .init(coefficient: measure)
            case .number, .unit, .variable:
                let measure: Measure<ComposedUnit> = try self.evaluator.evaluate(expression)
                return .init(constant: measure)
            case .unary(let operation, let operand):
                let value: LinearExpression = try self.linearize(
                    operand,
                    variable: variable
                )
                return try operation == .negative ? value.negated() : value
            case .binary(let operation, let lhs, let rhs):
                let left: LinearExpression = try self.linearize(
                    lhs,
                    variable: variable
                )
                let right: LinearExpression = try self.linearize(
                    rhs,
                    variable: variable
                )

                switch operation {
                case .add:
                    return try left.adding(right)
                case .subtract:
                    return try left.adding(right.negated())
                case .multiply, .juxtapose:
                    if left.coefficient != nil && right.coefficient != nil {
                        throw CalculationError.unsupportedEquation()
                    }

                    if let constant: Measure<ComposedUnit> = right.constant, right.coefficient == nil {
                        return try left.scaled(
                            by: constant,
                            operation: .multiply
                        )
                    }

                    if let constant: Measure<ComposedUnit> = left.constant, left.coefficient == nil {
                        return try right.scaled(
                            by: constant,
                            operation: .multiply
                        )
                    }

                    throw CalculationError.unsupportedEquation()
                case .divide:
                    guard right.coefficient == nil, let divisor: Measure<ComposedUnit> = right.constant else {
                        throw CalculationError.unsupportedEquation()
                    }

                    return try left.scaled(
                        by: divisor,
                        operation: .divide
                    )
                case .power:
                    guard right.coefficient == nil, let exponent: Measure<ComposedUnit> = right.constant else {
                        throw CalculationError.unsupportedEquation()
                    }

                    if left.coefficient != nil {
                        guard exponent.unit.dimension.isDimensionless == true && exponent.value == 1 else {
                            throw CalculationError.unsupportedEquation()
                        }

                        return left
                    }

                    guard let base: Measure<ComposedUnit> = left.constant else {
                        throw CalculationError.unsupportedEquation()
                    }

                    let measure: Measure<ComposedUnit> = try base.applying(
                        .power,
                        to: exponent
                    )
                    return .init(constant: measure)
                case .positive, .negative:
                    throw CalculationError.unsupportedEquation()
                }
            }
        } catch let error as CalculationError {
            throw CalculationError(
                code: error.code,
                message: error.message,
                span: error.span ?? expression.span
            )
        }
    }
}
