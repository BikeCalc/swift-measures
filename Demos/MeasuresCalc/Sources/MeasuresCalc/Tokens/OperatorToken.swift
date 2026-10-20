// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// An arithmetic operation recognized or inserted by the expression parser.
internal enum OperatorToken {
    /// Binary addition.
    case add

    /// Binary subtraction.
    case subtract

    /// Explicit multiplication.
    case multiply

    /// Explicit division.
    case divide

    /// Implicit multiplication or unit attachment between adjacent operands.
    case juxtapose

    /// Exponentiation by an integer expression.
    case power

    /// The unary positive sign.
    case positive

    /// The unary negative sign.
    case negative

    /// The binding priority; larger values bind more tightly.
    internal var precedence: Int {
        switch self {
        case .add, .subtract:
            return 1
        case .multiply, .divide:
            return 2
        case .juxtapose:
            return 3
        case .positive, .negative:
            return 4
        case .power:
            return 5
        }
    }

    /// A boolean value indicating whether this operator accepts a single operand.
    internal var isUnary: Bool {
        return self == .positive || self == .negative
    }

    /// A boolean value indicating whether equal-precedence operators group from right to left.
    internal var isRightAssociative: Bool {
        return self == .power || self.isUnary == true
    }
}

// MARK: - Equatable

extension OperatorToken: Equatable {
    internal static func == (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        switch (lhs, rhs) {
        case (.add, .add),
            (.subtract, .subtract),
            (.multiply, .multiply),
            (.divide, .divide),
            (.juxtapose, .juxtapose),
            (.power, .power),
            (.positive, .positive),
            (.negative, .negative):
            return true
        default:
            return false
        }
    }
}

// MARK: - RawRepresentable

extension OperatorToken: RawRepresentable {
    internal init?(rawValue: Character) {
        switch rawValue {
        case "+": self = .add
        case "-", "−": self = .subtract
        case "*", "×", "·": self = .multiply
        case "/", "÷": self = .divide
        case "^": self = .power
        default: return nil
        }
    }

    internal var rawValue: Character {
        switch self {
        case .add, .positive: return "+"
        case .subtract, .negative: return "-"
        case .multiply: return "*"
        case .divide: return "/"
        case .power: return "^"
        case .juxtapose: return "*" // canonicalize implied multiplication to '*'
        }
    }
}

// MARK: - Sendable

extension OperatorToken: Sendable {}
