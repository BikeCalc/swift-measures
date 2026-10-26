// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures

/// Evaluates measurement expressions, converts results, and solves linear equations.
package struct Calculator {
    /// The registered unit definitions accepted by the lexer.
    private let units: UnitRegistry

    /// Creates a calculator using the supported Measures unit definitions.
    package init() {
        self.units = .init()
    }

    /// The case-sensitive unit symbols accepted by this calculator.
    package var supportedUnits: Array<String> {
        return self.units.symbols
    }

    /// Evaluates an arithmetic expression with units and integer powers.
    ///
    /// Multiplication by juxtaposition binds more tightly than explicit multiplication and division.
    /// Powers bind to the preceding number, unit, or parenthesized expression.
    /// Results use coherent SI units unless an output unit is requested. Juxtaposing a number and a unit constructs
    /// a measurement, including its offset. Non-finite results are rejected; physical valid ranges are not enforced.
    ///
    /// - Parameters:
    ///   - source: The expression to evaluate.
    ///   - outputUnit: An optional unit expression, such as `m/s` or `m^2`.
    /// - Returns: The calculated quantity and its display representation.
    /// - Throws: A calculation error for invalid syntax, dimensions, or arithmetic.
    package func evaluate(
        _ source: String,
        to outputUnit: String? = nil
    ) throws(CalculationError) -> CalculationResult {
        let expression: Expression = try self.parse(source)
        let quantity: Measure<ComposedUnit> = try ExpressionEvaluator().evaluate(expression)
        return try self.result(
            quantity,
            to: outputUnit
        )
    }

    /// Solves a linear equation containing exactly one equals sign.
    ///
    /// The unknown may appear on either side and more than once. Its dimensions
    /// are inferred from the equation. Products of unknowns and unknown denominators
    /// are rejected rather than approximated. Equations with offset units are unsupported; use kelvin instead.
    ///
    /// - Parameters:
    ///   - source: The equation to solve.
    ///   - variable: The unknown's name, which must not be a registered unit.
    ///   - outputUnit: An optional compatible unit expression for the solution.
    /// - Returns: The unique solution and its display representation.
    /// - Throws: A calculation error for unsupported, invalid, or non-unique equations.
    package func solve(
        _ source: String,
        for variable: String = "x",
        to outputUnit: String? = nil
    ) throws(CalculationError) -> CalculationResult {
        let lexer: Lexer = .init(
            units: self.units,
            variable: variable
        )
        let tokens: Array<Token> = try lexer.tokenize(source)
        let separators: Array<Int> = tokens.indices
            .filter { tokens[$0].kind == .punctuation(.equals) }

        guard separators.count == 1, let separator: Int = separators.first else {
            throw CalculationError.expectedEquation()
        }

        let parser: ExpressionParser = .init()
        let lhs: Expression = try parser.parse(Array(tokens[..<separator]))
        let rhs: Expression = try parser.parse(Array(tokens[(separator + 1)...]))
        let solver: LinearEquationSolver = .init(units: self.units)
        let quantity: Measure<ComposedUnit> = try solver.solve(
            lhs: lhs,
            rhs: rhs,
            variable: variable
        )
        return try self.result(
            quantity,
            to: outputUnit
        )
    }

    /// Tokenizes and parses one arithmetic expression.
    ///
    /// - Parameter source: The input expression.
    /// - Returns: The parsed expression tree.
    /// - Throws: A calculation error for invalid tokens or syntax.
    private func parse(_ source: String) throws(CalculationError) -> Expression {
        let parser: ExpressionParser = .init()
        let lexer: Lexer = .init(units: self.units)
        let tokens: Array<Token> = try lexer.tokenize(source)
        return try parser.parse(tokens)
    }

    /// Converts an evaluated measurement and prepares its display representation.
    ///
    /// - Parameters:
    ///   - quantity: The evaluated measurement.
    ///   - outputUnit: The destination expression, or `nil` for canonicalized coherent output.
    /// - Returns: The converted measurement and display values.
    /// - Throws: A calculation error for an invalid or incompatible destination or a non-finite result.
    private func result(
        _ quantity: Measure<ComposedUnit>,
        to outputUnit: String?
    ) throws(CalculationError) -> CalculationResult {
        let measure: Measure<ComposedUnit>

        if let outputUnit {
            let evaluator: ExpressionEvaluator = .init()
            let expression: Expression = try self.parse(outputUnit)
            let unit: ComposedUnit = try evaluator.outputUnit(expression)

            guard quantity.unit.isCompatible(with: unit) == true else {
                throw CalculationError.incompatibleOutputDimension()
            }

            measure = try quantity.converted(to: unit).validated()
        } else {
            _ = try quantity.validated()
            @Converted(to: .coherent) var coherent: Measure<ComposedUnit> = quantity
            _ = try coherent.validated()
            measure = .init(coherent.value, coherent.unit.canonicalized())
        }

        return .init(
            measure: measure,
            value: measure.value,
            unit: measure.unit.symbol
        )
    }
}

// MARK: - Sendable

extension Calculator: Sendable {}
