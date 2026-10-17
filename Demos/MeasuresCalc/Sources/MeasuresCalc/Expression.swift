// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A node in the parsed expression tree, retaining its location and nesting depth.
internal struct Expression {
    /// The literal or operation represented by an expression node.
    internal enum Kind: Sendable {
        /// A numeric literal.
        case number(Double)

        /// A resolved unit definition.
        case unit(UnitToken)

        /// An unknown identifier to substitute or solve for.
        case variable(String)

        /// A prefix operator and its operand.
        indirect case unary(OperatorToken, Expression)

        /// An operator and its left and right operands.
        indirect case binary(OperatorToken, Expression, Expression)
    }

    /// The literal or operation carried by this node.
    internal let kind: Self.Kind

    /// The character range occupied by this expression.
    internal let span: SourceSpan

    /// The number of nodes on the longest path from this node to a leaf.
    internal let depth: Int

    /// Creates an expression node with its source location and depth.
    ///
    /// - Parameters:
    ///   - kind: The literal or operation represented by the node.
    ///   - span: The character range covered by the expression.
    ///   - depth: The longest path to a leaf, counting this node.
    internal init(
        kind: Self.Kind,
        span: SourceSpan,
        depth: Int = 1
    ) {
        self.kind = kind
        self.span = span
        self.depth = depth
    }

    /// A boolean value indicating whether this expression contains a unit with a nonzero conversion constant.
    internal var containsOffsetUnit: Bool {
        switch self.kind {
        case .unit(let token): return token.unit.constant != 0
        case .unary(
            _,
            let operand
        ): return operand.containsOffsetUnit
        case .binary(
            _,
            let lhs,
            let rhs
        ): return lhs.containsOffsetUnit || rhs.containsOffsetUnit
        case .number, .variable: return false
        }
    }

    /// A boolean value indicating whether this expression contains an unknown variable.
    internal var containsVariable: Bool {
        switch self.kind {
        case .variable: return true
        case .unary(
            _,
            let operand
        ): return operand.containsVariable
        case .binary(
            _,
            let lhs,
            let rhs
        ): return lhs.containsVariable || rhs.containsVariable
        case .number, .unit: return false
        }
    }
}
