// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// Checks the structure and surrounding whitespace of a unit symbol.
///
/// Internal spaces in labels such as `imp ton` are accepted. Empty labels and groups are rejected.
/// This validator does not resolve units or validate exponent values.
internal struct UnitSymbolValidator {
    /// Binary operators requiring operands on both sides.
    private enum OperatorToken: Character, RawRepresentable {
        /// The multiplication operator, written as a centered dot.
        case multiplication = "·"

        /// The division operator.
        case division = "/"

        /// The ordinary power operator.
        case power = "^"
    }

    /// Delimiters whose balance is checked.
    private enum PunctuationToken: Character, RawRepresentable {
        /// The beginning of a grouped label.
        case openingParenthesis = "("

        /// The end of a grouped label.
        case closingParenthesis = ")"
    }

    /// The unit label to validate.
    private let symbol: String

    /// Creates a validator for a unit label.
    ///
    /// - Parameter symbol: The label whose structure will be checked.
    internal init(symbol: String) {
        self.symbol = symbol
    }

    /// Checks the label's whitespace, parentheses, groups, and binary operands.
    ///
    /// - Returns: Whether the nonempty label satisfies every structural rule.
    internal func validate() -> Bool {
        /// Checks that the label is nonempty and has no surrounding whitespace.
        ///
        /// - Returns: Whether both boundary characters are present and are not whitespace.
        func hasValidBoundaries() -> Bool {
            guard let first = self.symbol.first, let last = self.symbol.last else {
                return false
            }
            return first.isWhitespace == false
                && last.isWhitespace == false
        }

        /// Checks that parentheses are balanced and correctly nested.
        ///
        /// - Returns: Whether every closing parenthesis matches an earlier opening parenthesis.
        func hasBalancedParentheses() -> Bool {
            var depth: Int = 0

            for character in self.symbol {
                switch PunctuationToken(rawValue: character) {
                case .openingParenthesis:
                    depth += 1
                case .closingParenthesis:
                    guard depth > 0 else {
                        return false
                    }
                    depth -= 1
                case nil:
                    break
                }
            }

            return depth == 0
        }

        /// Checks that groups contain operands and binary operators have operands on both sides.
        ///
        /// Parentheses must already be balanced. Whitespace alone does not count as an operand.
        ///
        /// - Returns: Whether no group is empty and no binary operand is missing.
        func hasRequiredOperands() -> Bool {
            var expectsOperand: Bool = true

            for character in self.symbol
            where character.isWhitespace == false {
                switch PunctuationToken(rawValue: character) {
                case .openingParenthesis:
                    expectsOperand = true
                case .closingParenthesis:
                    if expectsOperand {
                        return false
                    }
                case nil:
                    if OperatorToken(rawValue: character) != nil {
                        guard expectsOperand == false else {
                            return false
                        }
                        expectsOperand = true
                    } else {
                        expectsOperand = false
                    }
                }
            }

            return expectsOperand == false
        }

        return hasValidBoundaries()
            && hasBalancedParentheses()
            && hasRequiredOperands()
    }
}
