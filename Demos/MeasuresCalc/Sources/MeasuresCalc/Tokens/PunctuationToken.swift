// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// Punctuation used for grouping expressions, separating equations, and writing numbers.
internal enum PunctuationToken {
    /// The opening parenthesis of a grouped expression.
    case leftParenthesis

    /// The closing parenthesis of a grouped expression.
    case rightParenthesis

    /// The separator between the two sides of an equation.
    case equals

    /// The period separating the integer and fractional parts of a number.
    case decimalPoint

    /// A comma separating groups of three integer digits.
    case comma

    /// An underscore separating groups of three integer digits.
    case underscore

    /// A boolean value indicating whether this punctuation separates groups of integer digits.
    internal var isGroupingSeparator: Bool {
        return self == .comma || self == .underscore
    }
}

// MARK: - Equatable

extension PunctuationToken: Equatable {}

// MARK: - RawRepresentable

extension PunctuationToken: RawRepresentable {
    internal init?(rawValue: Character) {
        switch rawValue {
        case "(": self = .leftParenthesis
        case ")": self = .rightParenthesis
        case "=": self = .equals
        case ".": self = .decimalPoint
        case ",": self = .comma
        case "_": self = .underscore
        default: return nil
        }
    }

    internal var rawValue: Character {
        switch self {
        case .leftParenthesis: return "("
        case .rightParenthesis: return ")"
        case .equals: return "="
        case .decimalPoint: return "."
        case .comma: return ","
        case .underscore: return "_"
        }
    }
}

// MARK: - Sendable

extension PunctuationToken: Sendable {}
