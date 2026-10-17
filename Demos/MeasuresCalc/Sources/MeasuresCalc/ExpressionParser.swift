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
    internal func parse(_ tokens: Array<Token>) throws -> Expression {
        var values: Array<Expression> = []
        var operators: Array<Token> = []
        var expectsOperand: Bool = true
        var previousWasNumber: Bool = false

        for token in tokens {
            switch token.kind {
            case .number, .unit, .variable, .punctuation(.leftParenthesis):
                if !expectsOperand {
                    // Juxtaposition is multiplication: 2 m^2 is 2 * (m^2),
                    // while 2^2 m is (2^2) * m. Adjacent numbers remain an error.
                    if case .number = token.kind, previousWasNumber {
                        throw self.syntax(
                            "Expected an operator between numbers.",
                            at: token.span
                        )
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
                    values.append(
                        Expression(
                            kind: .number(value),
                            span: token.span
                        )
                    )
                    expectsOperand = false
                case .unit(let unit):
                    values.append(
                        Expression(
                            kind: .unit(unit),
                            span: token.span
                        )
                    )
                    expectsOperand = false
                case .variable(let name):
                    values.append(
                        Expression(
                            kind: .variable(name),
                            span: token.span
                        )
                    )
                    expectsOperand = false
                case .punctuation(.leftParenthesis):
                    operators.append(token)
                    expectsOperand = true
                default:
                    break
                }
            case .punctuation(.rightParenthesis):
                guard !expectsOperand else {
                    throw self.syntax(
                        "Expected an expression before ')'.",
                        at: token.span
                    )
                }
                while let last: Token = operators.last, last.kind != .punctuation(.leftParenthesis) {
                    _ = operators.popLast()
                    try self.apply(
                        last,
                        to: &values
                    )
                }
                guard let opening: Token = operators.popLast(), var expression: Expression = values.popLast() else {
                    throw self.syntax(
                        "Unmatched closing parenthesis.",
                        at: token.span
                    )
                }
                expression = Expression(
                    kind: expression.kind,
                    span: SourceSpan(
                        start: opening.span.start,
                        end: token.span.end
                    ),
                    depth: expression.depth
                )
                values.append(expression)
                expectsOperand = false
            case .operation(let operation):
                if expectsOperand {
                    guard operation == .add || operation == .subtract else {
                        throw self.syntax(
                            "Expected a number, unit, or '('.",
                            at: token.span
                        )
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
                throw self.syntax(
                    "Use equation solving for expressions containing '='.",
                    at: token.span
                )
            case .punctuation:
                throw self.syntax(
                    "Unexpected numeric punctuation.",
                    at: token.span
                )
            }
            if case .number = token.kind {
                previousWasNumber = true
            } else {
                previousWasNumber = false
            }
        }
        guard !expectsOperand else {
            throw CalculationError(
                code: .invalidSyntax,
                message: tokens.isEmpty ? "The expression is empty." : "The expression is missing an operand.",
                span: tokens.last?.span
            )
        }
        while let token: Token = operators.popLast() {
            guard token.kind != .punctuation(.leftParenthesis) else {
                throw self.syntax(
                    "Unmatched opening parenthesis.",
                    at: token.span
                )
            }
            try self.apply(
                token,
                to: &values
            )
        }
        guard values.count == 1, let result: Expression = values.first else {
            throw CalculationError(
                code: .invalidSyntax,
                message: "Expected a single expression."
            )
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
    ) throws {
        guard case .operation(let incoming) = token.kind else {
            return
        }
        while let last: Token = operators.last, case .operation(let pending) = last.kind {
            let shouldApply: Bool =
                pending.precedence > incoming.precedence
                || (pending.precedence == incoming.precedence && !incoming.isRightAssociative)
            guard shouldApply else {
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
    ) throws {
        guard case .operation(let operation) = token.kind, let rhs: Expression = values.popLast() else {
            throw self.syntax(
                "Missing operand.",
                at: token.span
            )
        }
        let expression: Expression
        if operation.isUnary {
            expression = Expression(
                kind: .unary(
                    operation,
                    rhs
                ),
                span: SourceSpan(
                    start: token.span.start,
                    end: rhs.span.end
                ),
                depth: rhs.depth + 1
            )
        } else {
            guard let lhs: Expression = values.popLast() else {
                throw self.syntax(
                    "Missing left operand.",
                    at: token.span
                )
            }
            expression = Expression(
                kind: .binary(
                    operation,
                    lhs,
                    rhs
                ),
                span: SourceSpan(
                    start: lhs.span.start,
                    end: rhs.span.end
                ),
                depth: max(
                    lhs.depth,
                    rhs.depth
                ) + 1
            )
        }
        guard expression.depth <= 128 else {
            throw CalculationError(
                code: .limitExceeded,
                message: "Expressions are limited to 128 levels of operations.",
                span: expression.span
            )
        }
        values.append(expression)
    }

    /// Creates a syntax diagnostic at the supplied source location.
    ///
    /// - Parameters:
    ///   - message: The explanation of the invalid syntax.
    ///   - span: The affected character range.
    /// - Returns: The syntax diagnostic.
    private func syntax(
        _ message: String,
        at span: SourceSpan
    ) -> CalculationError {
        return CalculationError(
            code: .invalidSyntax,
            message: message,
            span: span
        )
    }
}
