// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A decimal digit recognized in ordinary or superscript notation.
internal enum DigitToken {
    /// The decimal digit 0.
    case zero

    /// The decimal digit 1.
    case one

    /// The decimal digit 2.
    case two

    /// The decimal digit 3.
    case three

    /// The decimal digit 4.
    case four

    /// The decimal digit 5.
    case five

    /// The decimal digit 6.
    case six

    /// The decimal digit 7.
    case seven

    /// The decimal digit 8.
    case eight

    /// The decimal digit 9.
    case nine

    /// Creates a digit from a superscript character, returning `nil` for other characters.
    ///
    /// - Parameter superscript: The superscript digit to resolve.
    internal init?(superscript: Character) {
        switch superscript {
        case "⁰": self = .zero
        case "¹": self = .one
        case "²": self = .two
        case "³": self = .three
        case "⁴": self = .four
        case "⁵": self = .five
        case "⁶": self = .six
        case "⁷": self = .seven
        case "⁸": self = .eight
        case "⁹": self = .nine
        default: return nil
        }
    }

    /// The integer value of the digit, from zero through nine.
    internal var value: Int {
        switch self {
        case .zero: return 0
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .seven: return 7
        case .eight: return 8
        case .nine: return 9
        }
    }
}

// MARK: - CaseIterable

extension DigitToken: CaseIterable {}

// MARK: - RawRepresentable

extension DigitToken: RawRepresentable {
    internal init?(rawValue: Character) {
        switch rawValue {
        case "0": self = .zero
        case "1": self = .one
        case "2": self = .two
        case "3": self = .three
        case "4": self = .four
        case "5": self = .five
        case "6": self = .six
        case "7": self = .seven
        case "8": self = .eight
        case "9": self = .nine
        default: return nil
        }
    }

    internal var rawValue: Character {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        }
    }
}

// MARK: - Sendable

extension DigitToken: Sendable {}
