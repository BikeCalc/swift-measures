// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// Converts an input string into tokens while retaining character offsets for diagnostics.
internal struct Lexer {
    /// The unit definitions available for symbol matching.
    private let units: UnitRegistry

    /// The optional unknown identifier accepted when tokenizing an equation.
    private let variable: String?

    /// Creates a lexer for the registered symbols and an optional unknown.
    ///
    /// - Parameters:
    ///   - units: The registered unit definitions.
    ///   - variable: The optional unknown identifier allowed in an equation.
    internal init(
        units: UnitRegistry,
        variable: String? = nil
    ) {
        self.units = units
        self.variable = variable
    }

    /// Tokenizes an expression while preserving character locations.
    ///
    /// - Parameter source: The expression or equation to tokenize.
    /// - Returns: The ordered tokens, including resolved units and numeric exponents.
    /// - Throws: A calculation error for unrecognized input, malformed numbers, or more than 4,096 characters.
    internal func tokenize(_ source: String) throws -> Array<Token> {
        guard source.count <= 4_096 else {
            throw CalculationError.expressionLengthLimitExceeded()
        }

        let characters: Array<Character> = .init(source)
        var tokens: Array<Token> = []
        var index: Int = 0

        while index < characters.count {
            let character: Character = characters[index]

            if character.isWhitespace == true {
                index += 1
                continue
            }

            let start: Int = index
            let kind: Token.Kind

            if DigitToken(rawValue: character) != nil || PunctuationToken(rawValue: character) == .decimalPoint {
                let number: Double = try self.number(
                    in: characters,
                    index: &index
                )
                kind = .number(number)
            } else if let match: UnitRegistry.Match = try self.units.match(
                in: characters,
                at: index
            ) {
                kind = .unit(match.token)
                index += match.count
            } else if DigitToken(superscript: character) != nil || character == "⁻" || character == "⁺" {
                var text: String = ""

                if character == "⁻" || character == "⁺" {
                    text = character == "⁻" ? "-" : "+"
                    index += 1
                }

                let digitStart: Int = index

                while index < characters.count, let digit: DigitToken = .init(superscript: characters[index]) {
                    text.append(digit.rawValue)
                    index += 1
                }

                guard index > digitStart, let exponent: Double = .init(text), exponent.isFinite == true else {
                    throw CalculationError.invalidNumberGrouping(
                        span: SourceSpan(
                            start: start,
                            end: index
                        )
                    )
                }

                tokens.append(
                    .init(
                        kind: .operation(.power),
                        span: .init(
                            start: start,
                            end: index
                        )
                    )
                )
                kind = .number(exponent)
            } else if character.isLetter == true {
                index += 1

                while index < characters.count && characters[index].isLetter == true {
                    index += 1
                }

                let symbol: String = .init(characters[start ..< index])

                if let unit: UnitToken = try self.units.unit(for: symbol) {
                    kind = .unit(unit)
                } else if symbol == self.variable {
                    kind = .variable(symbol)
                } else {
                    throw CalculationError.unknownIdentifier(
                        symbol,
                        span: SourceSpan(
                            start: start,
                            end: index
                        )
                    )
                }
            } else {
                index += 1

                if let operation: OperatorToken = .init(rawValue: character) {
                    kind = .operation(operation)
                } else if let punctuation: PunctuationToken = .init(rawValue: character),
                    punctuation.isGroupingSeparator == false
                {
                    kind = .punctuation(punctuation)
                } else {
                    throw CalculationError.unexpectedCharacter(
                        character,
                        span: SourceSpan(
                            start: start,
                            end: index
                        )
                    )
                }
            }

            tokens.append(
                Token(
                    kind: kind,
                    span: SourceSpan(
                        start: start,
                        end: index
                    )
                )
            )
        }

        return tokens
    }

    /// Parses a finite decimal number, including optional grouping and a scientific exponent.
    ///
    /// - Parameters:
    ///   - characters: The complete input characters.
    ///   - index: The current offset, advanced past the parsed number.
    /// - Returns: The finite numeric value.
    /// - Throws: A calculation error for malformed grouping, an invalid exponent, or a non-finite value.
    private func number(
        in characters: Array<Character>,
        index: inout Int
    ) throws -> Double {
        let start: Int = index
        var text: String = ""
        var groupSize: Int = 0
        var hasGrouping: Bool = false
        var hasDigit: Bool = false

        // Commas and underscores are equivalent thousands separators in the integer part.
        while index < characters.count {
            let character: Character = characters[index]

            if let digit: DigitToken = .init(rawValue: character) {
                text.append(digit.rawValue)
                groupSize += 1
                hasDigit = true
                index += 1
            } else if let punctuation: PunctuationToken = .init(rawValue: character),
                punctuation.isGroupingSeparator == true
            {
                guard hasGrouping == true ? groupSize == 3 : (1 ... 3).contains(groupSize) else {
                    throw CalculationError.invalidNumber(
                        span: SourceSpan(
                            start: start,
                            end: index + 1
                        )
                    )
                }

                hasGrouping = true
                groupSize = 0
                index += 1
            } else {
                break
            }
        }

        guard hasGrouping == false || groupSize == 3 else {
            throw CalculationError.invalidNumber(
                span: SourceSpan(
                    start: start,
                    end: index
                )
            )
        }

        if index < characters.count && PunctuationToken(rawValue: characters[index]) == .decimalPoint {
            text.append(PunctuationToken.decimalPoint.rawValue)
            index += 1

            while index < characters.count, let digit: DigitToken = .init(rawValue: characters[index]) {
                text.append(digit.rawValue)
                hasDigit = true
                index += 1
            }
        }

        if index < characters.count && (characters[index] == "e" || characters[index] == "E") {
            text.append("e")
            index += 1

            if index < characters.count, let operation: OperatorToken = .init(rawValue: characters[index]),
                operation == .add || operation == .subtract
            {
                text.append(operation.rawValue)
                index += 1
            }

            let exponentStart: Int = index

            while index < characters.count, let digit: DigitToken = .init(rawValue: characters[index]) {
                text.append(digit.rawValue)
                index += 1
            }

            guard index > exponentStart else {
                throw CalculationError.invalidNumber(
                    span: SourceSpan(
                        start: start,
                        end: index
                    )
                )
            }
        }

        if index < characters.count,
            let punctuation: PunctuationToken = .init(rawValue: characters[index]),
            punctuation.isGroupingSeparator == true || punctuation == .decimalPoint
        {
            throw CalculationError.invalidNumber(
                span: SourceSpan(
                    start: start,
                    end: index + 1
                )
            )
        }

        guard hasDigit == true, let value: Double = .init(text), value.isFinite == true else {
            throw CalculationError.invalidNumber(
                span: SourceSpan(
                    start: start,
                    end: index
                )
            )
        }

        return value
    }
}
