// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// Formats ordered unit-symbol factors without simplifying or parsing expressions.
///
/// Signed superscript exponents preserve factor order, with multiplication dots separating factors.
/// Supplied unit labels are preserved.
///
/// For example:
///
/// ```swift
/// let formatter = ComposedUnitSymbolFormatter(factors: [
///     .init(unit: .init(Length.meter)),
///     .init(unit: .init(Time.second), exponent: -2)
/// ])
///
/// print(formatter.format())
/// // Prints "m·s⁻²"
/// ```
internal struct ComposedUnitSymbolFormatter {
    /// Operators used in unit-symbol expressions.
    private enum OperatorToken: String, RawRepresentable {
        /// The multiplication operator, written as a centered dot.
        case multiplication = "·"

        /// The division operator appearing in defined unit labels.
        case division = "/"

        /// The ordinary power operator appearing in custom unit labels.
        case power = "^"

        /// The negation operator, written in superscript form.
        case superscriptNegation = "⁻"
    }

    /// Delimiters grouping a compound unit label.
    private enum PunctuationToken: String, RawRepresentable {
        /// The beginning of a grouped label.
        case openingParenthesis = "("

        /// The end of a grouped label.
        case closingParenthesis = ")"
    }

    /// Decimal digits written in superscript form.
    private enum SuperscriptToken: String, RawRepresentable {
        /// The superscript digit zero.
        case zero = "⁰"

        /// The superscript digit one.
        case one = "¹"

        /// The superscript digit two.
        case two = "²"

        /// The superscript digit three.
        case three = "³"

        /// The superscript digit four.
        case four = "⁴"

        /// The superscript digit five.
        case five = "⁵"

        /// The superscript digit six.
        case six = "⁶"

        /// The superscript digit seven.
        case seven = "⁷"

        /// The superscript digit eight.
        case eight = "⁸"

        /// The superscript digit nine.
        case nine = "⁹"

        /// Creates a superscript token from an ordinary decimal digit.
        ///
        /// - Parameter digit: A value from zero through nine. Values outside this range trap.
        fileprivate init(digit: UInt) {
            switch digit {
            case 0: self = .zero
            case 1: self = .one
            case 2: self = .two
            case 3: self = .three
            case 4: self = .four
            case 5: self = .five
            case 6: self = .six
            case 7: self = .seven
            case 8: self = .eight
            case 9: self = .nine
            default: preconditionFailure("A decimal digit must be between zero and nine.")
            }
        }
    }

    /// An integer represented as signed superscript digits.
    private struct Superscript: CustomStringConvertible {
        /// The signed integer represented by this value.
        private let value: Int

        /// Creates a superscript value from a signed integer.
        ///
        /// - Parameter value: The signed exponent.
        fileprivate init(_ value: Int) {
            self.value = value
        }

        fileprivate var description: String {
            var remainingValue: UInt = self.value.magnitude
            var superscripts: Array<SuperscriptToken> = []

            repeat {
                let superscript: SuperscriptToken = .init(digit: remainingValue % 10)
                superscripts.append(superscript)
                remainingValue /= 10
            } while remainingValue != 0

            let sign: String = self.value < 0 ? OperatorToken.superscriptNegation.rawValue : ""

            let digits: Array<SuperscriptToken.RawValue> =
                superscripts
                .reversed()
                .map { $0.rawValue }

            return sign + digits.joined()
        }
    }

    /// The captured units and signed exponents in their original order.
    private let factors: Array<ComposedUnit.Factor>

    /// Creates a formatter for ordered factors.
    ///
    /// - Parameter factors: Captured units and signed exponents, retained until formatting.
    internal init(factors: Array<ComposedUnit.Factor>) {
        self.factors = factors
    }

    /// Formats the stored factors using signed superscript powers and multiplication dots.
    ///
    /// Factor order, duplicates, and opposing exponents are preserved.
    /// Zero exponents are always omitted and positive one is implicit. Compound labels are grouped when needed; no
    /// symbol is parsed.
    ///
    /// - Returns: The formatted unit expression, or an empty string when no nonzero factors remain.
    /// - Precondition: Every factor's symbol must pass `ComposedUnitSymbolValidator` validation.
    internal func format() -> String {
        /// Checks whether appending an exponent requires parentheses around the complete label.
        ///
        /// Atomic labels need none. One balanced pair already enclosing the complete label is reused. Operators
        /// and existing powers require grouping so the appended exponent applies to the whole defined unit.
        ///
        /// - Parameter symbol: A display label with balanced parentheses; this check does not validate or simplify it.
        /// - Returns: Whether an additional pair of parentheses is needed before appending an exponent.
        func needsGrouping(symbol: String) -> Bool {
            var depth: Int = 0
            var enclosesWholeLabel: Bool =
                symbol.first
                .map { PunctuationToken(rawValue: String($0)) } == .openingParenthesis

            var containsSyntax: Bool = false

            for (index, element) in zip(symbol.indices, symbol) {
                let rawValue: String = .init(element)
                let punctuation: PunctuationToken? = .init(rawValue: rawValue)

                switch punctuation {
                case .openingParenthesis:
                    depth += 1
                case .closingParenthesis:
                    depth -= 1
                    if depth == 0 && index != symbol.lastIndex {
                        enclosesWholeLabel = false
                    }
                case nil:
                    break
                }

                containsSyntax =
                    containsSyntax
                    || punctuation != nil
                    || OperatorToken(rawValue: rawValue) != nil
                    || SuperscriptToken(rawValue: rawValue) != nil
            }

            return containsSyntax && enclosesWholeLabel == false
        }

        /// Formats a factor, grouping its symbol when needed and appending its signed exponent.
        ///
        /// - Parameters:
        ///   - symbol: The factor label.
        ///   - exponent: The signed exponent, including `Int.min`.
        /// - Returns: `nil` for zero, the symbol for one, or the grouped symbol followed by a signed superscript.
        func formatFactor(
            symbol: String,
            exponent: Int
        ) -> String? {
            guard exponent != 0 else {
                return nil
            }

            guard exponent != 1 else {
                return symbol
            }

            let groupedSymbol: String =
                if needsGrouping(symbol: symbol) {
                    PunctuationToken.openingParenthesis.rawValue
                        + symbol
                        + PunctuationToken.closingParenthesis.rawValue
                } else {
                    symbol
                }

            let superscript: Superscript = .init(exponent)

            return groupedSymbol + superscript.description
        }

        for factor in self.factors {
            let validator: ComposedUnitSymbolValidator = .init(symbol: factor.unit.symbol)
            precondition(
                validator.validate(),
                "Each factor must have a valid unit symbol."
            )
        }

        let formattedFactors: Array<String> = self.factors.compactMap { factor in
            return formatFactor(
                symbol: factor.unit.symbol,
                exponent: factor.exponent
            )
        }

        return formattedFactors.joined(separator: OperatorToken.multiplication.rawValue)
    }
}
