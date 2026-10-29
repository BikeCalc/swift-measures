// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// Builds an expression tree using Dijkstra's shunting-yard algorithm.
internal struct ExpressionParser {
    /// Creates a shunting-yard expression parser.
    internal init() {}

    /// Builds an expression tree using operator and operand stacks.
    ///
    /// - Parameter tokens: The tokens for one side of an equation or a standalone expression.
    /// - Returns: The root of the parsed expression tree.
    /// - Throws: A calculation error for invalid syntax or a tree deeper than 128 nodes.
    internal func parse(_ tokens: Array<Token>) throws(CalculationError) -> Expression {
        var values: Array<Expression> = []
        var operators: Array<Token> = []
        var expectsOperand: Bool = true
        var previousWasNumber: Bool = false

        for token in tokens {
            switch token.kind {
            case .number, .unit, .variable, .punctuation(.leftParenthesis):
                if expectsOperand == false {
                    // Juxtaposition is multiplication: 2 m^2 is 2 * (m^2),
                    // while 2^2 m is (2^2) * m. Adjacent numbers remain an error.
                    if case .number = token.kind, previousWasNumber == true {
                        throw CalculationError.expectedOperator(span: token.span)
                    }

                    try self.push(
                        Token(
                            kind: .operation(.juxtapose),
                            span: token.span
                        ),
                        operators: &operators,
                        values: &values
                    )
                }

                switch token.kind {
                case .number(let value):
                    let expression: Expression = .init(
                        kind: .number(value),
                        span: token.span
                    )
                    values.append(expression)
                    expectsOperand = false
                case .unit(let unit):
                    let expression: Expression = .init(
                        kind: .unit(unit),
                        span: token.span
                    )
                    values.append(expression)
                    expectsOperand = false
                case .variable(let name):
                    let expression: Expression = .init(
                        kind: .variable(name),
                        span: token.span
                    )
                    values.append(expression)
                    expectsOperand = false
                case .punctuation(.leftParenthesis):
                    operators.append(token)
                    expectsOperand = true
                default:
                    break
                }
            case .punctuation(.rightParenthesis):
                guard expectsOperand == false else {
                    throw CalculationError.expectedExpressionBeforeClosingParenthesis(span: token.span)
                }

                while let last: Token = operators.last, last.kind != .punctuation(.leftParenthesis) {
                    _ = operators.popLast()
                    try self.apply(
                        last,
                        to: &values
                    )
                }

                guard
                    let opening: Token = operators.popLast(),
                    let lastExpression: Expression = values.popLast()
                else {
                    throw CalculationError.unmatchedClosingParenthesis(span: token.span)
                }

                let expression: Expression = .init(
                    kind: lastExpression.kind,
                    span: SourceSpan(
                        start: opening.span.start,
                        end: token.span.end
                    ),
                    depth: lastExpression.depth
                )
                values.append(expression)
                expectsOperand = false
            case .operation(let operation):
                if expectsOperand == true {
                    guard operation == .add || operation == .subtract else {
                        throw CalculationError.expectedOperand(span: token.span)
                    }

                    // Prefix signs must not pop a pending power: 2^-2 is valid.
                    operators.append(
                        Token(
                            kind: .operation(operation == .add ? .positive : .negative),
                            span: token.span
                        )
                    )
                } else {
                    try self.push(
                        token,
                        operators: &operators,
                        values: &values
                    )
                    expectsOperand = true
                }
            case .punctuation(.equals):
                throw CalculationError.equationRequiresSolver(span: token.span)
            case .punctuation:
                throw CalculationError.unexpectedNumericPunctuation(span: token.span)
            }

            if case .number = token.kind {
                previousWasNumber = true
            } else {
                previousWasNumber = false
            }
        }

        guard expectsOperand == false else {
            if tokens.isEmpty == true {
                throw CalculationError.emptyExpression(span: tokens.last?.span)
            } else {
                throw CalculationError.missingExpressionOperand(span: tokens.last?.span)
            }
        }

        while let token: Token = operators.popLast() {
            guard token.kind != .punctuation(.leftParenthesis) else {
                throw CalculationError.unmatchedOpeningParenthesis(span: token.span)
            }

            try self.apply(
                token,
                to: &values
            )
        }

        guard values.count == 1, let result: Expression = values.first else {
            throw CalculationError.expectedSingleExpression()
        }

        return result
    }

    /// Reduces pending operators according to precedence before pushing the incoming operator.
    ///
    /// - Parameters:
    ///   - token: The incoming operator token.
    ///   - operators: The stack of pending operators, updated in place.
    ///   - values: The stack of expression nodes, updated by reductions.
    /// - Throws: A calculation error if a pending operator cannot be applied.
    private func push(
        _ token: Token,
        operators: inout Array<Token>,
        values: inout Array<Expression>
    ) throws(CalculationError) {
        guard case .operation(let incoming) = token.kind else {
            return
        }

        while let last: Token = operators.last, case .operation(let pending) = last.kind {
            let shouldApply: Bool =
                pending.precedence > incoming.precedence
                || (pending.precedence == incoming.precedence && incoming.isRightAssociative == false)

            guard shouldApply == true else {
                break
            }

            _ = operators.popLast()
            try self.apply(
                last,
                to: &values
            )
        }

        operators.append(token)
    }

    /// Combines stack operands into a unary or binary expression node.
    ///
    /// - Parameters:
    ///   - token: The operator to apply.
    ///   - values: The expression stack from which operands are removed and to which the result is appended.
    /// - Throws: A calculation error for missing operands or excessive nesting.
    private func apply(
        _ token: Token,
        to values: inout Array<Expression>
    ) throws(CalculationError) {
        guard case .operation(let operation) = token.kind, let rhs: Expression = values.popLast() else {
            throw CalculationError.missingOperand(span: token.span)
        }

        let expression: Expression

        if operation.isUnary == true {
            expression = .init(
                kind: .unary(operation, rhs),
                span: SourceSpan(
                    start: token.span.start,
                    end: rhs.span.end
                ),
                depth: rhs.depth + 1
            )
        } else {
            guard let lhs: Expression = values.popLast() else {
                throw CalculationError.missingLeftOperand(span: token.span)
            }

            expression = .init(
                kind: .binary(operation, lhs, rhs),
                span: SourceSpan(
                    start: lhs.span.start,
                    end: rhs.span.end
                ),
                depth: max(lhs.depth, rhs.depth) + 1
            )
        }

        guard expression.depth <= 128 else {
            throw CalculationError.expressionDepthLimitExceeded(span: expression.span)
        }

        values.append(expression)
    }
}
