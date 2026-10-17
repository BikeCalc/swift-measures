// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A lexical token paired with its location in the original input.
internal struct Token {
    /// The number, unit, identifier, operator, or punctuation recognized by the lexer.
    internal enum Kind {
        /// A parsed numeric literal.
        case number(Double)

        /// A resolved unit definition.
        case unit(UnitToken)

        /// The selected unknown identifier.
        case variable(String)

        /// An arithmetic operator.
        case operation(OperatorToken)

        /// An expression or numeric punctuation character.
        case punctuation(PunctuationToken)
    }

    /// The semantic content of the token.
    internal let kind: Self.Kind

    /// The character range occupied by the token.
    internal let span: SourceSpan

    /// Creates a token with its source location.
    ///
    /// - Parameters:
    ///   - kind: The semantic token content.
    ///   - span: The character range in the original input.
    internal init(
        kind: Self.Kind,
        span: SourceSpan
    ) {
        self.kind = kind
        self.span = span
    }
}

// MARK: - Equatable

extension Token: Equatable {}

// MARK: - Sendable

extension Token: Sendable {}

// MARK: - Equatable

extension Token.Kind: Equatable {}

// MARK: - Sendable

extension Token.Kind: Sendable {}
