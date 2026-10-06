// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes

/// Simplifies and formats ordered unit-symbol factors without parsing expressions.
///
/// Signed superscript exponents preserve factor order, with multiplication dots separating factors.
/// The dimension initializer supplies coherent SI base-unit symbols; the factor initializer preserves supplied labels.
///
/// For example:
///
/// ```swift
/// let dimension = Dimension(length: 1, time: -2)
/// let builder = UnitSymbolFormatter(dimension: dimension)
///
/// print(builder.format())
/// // Prints "m·s⁻²"
/// ```
internal struct UnitSymbolFormatter {
    /// Options controlling how factors are prepared for formatting.
    internal struct Configuration {
        /// Whether matching factors are combined and cancelling factors are removed before rendering.
        internal var simplifies: Bool

        /// Creates a formatting configuration.
        ///
        /// - Parameter simplifies: Whether to simplify factors. Defaults to `true`.
        internal init(simplifies: Bool = true) {
            self.simplifies = simplifies
        }
    }

    /// Operators used in unit-symbol expressions.
    private enum OperatorToken: String, RawRepresentable {
        /// The multiplication operator, written as a centered dot.
        case multiplication = "·"

    }

    /// Signs used in superscript exponents.
    private enum SuperscriptSignToken: String, RawRepresentable {
        /// The negative sign, written in superscript form.
        case negative = "⁻"
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
            var digits: Array<SuperscriptToken> = []

            repeat {
                digits.append(SuperscriptToken(digit: remainingValue % 10))
                remainingValue /= 10
            } while remainingValue != 0

            let sign: String = self.value < 0 ? SuperscriptSignToken.negative.rawValue : ""

            return sign + digits
                .reversed()
                .map { $0.rawValue }
                .joined()
        }
    }

    /// The supplied labels and signed exponents in their original order.
    private let factors: Array<UnitSymbolFactor>

    /// The options used when formatting the stored factors.
    private let configuration: Configuration

    /// Creates a formatter for ordered factors.
    ///
    /// - Parameters:
    ///   - factors: Labels and signed exponents, retained until formatting.
    ///   - configuration: Options controlling simplification before rendering.
    internal init(
        factors: Array<UnitSymbolFactor>,
        configuration: Configuration = .init()
    ) {
        self.factors = factors
        self.configuration = configuration
    }

    /// Creates a formatter for a coherent SI symbol.
    ///
    /// - Parameters:
    ///   - dimension: The physical dimension, independent of any unit's coefficient or constant.
    ///   - configuration: Options controlling simplification before rendering.
    internal init(
        dimension: Dimension,
        configuration: Configuration = .init()
    ) {
        self.configuration = configuration
        self.factors = [
            (Length.meter.symbol, dimension.length),
            (Mass.kilogram.symbol, dimension.mass),
            (Time.second.symbol, dimension.time),
            (ElectricCurrent.ampere.symbol, dimension.electricCurrent),
            (ThermodynamicTemperature.kelvin.symbol, dimension.thermodynamicTemperature),
            (SubstanceAmount.mole.symbol, dimension.substanceAmount),
            (LuminousIntensity.candela.symbol, dimension.luminousIntensity)
        ]
    }

    /// Formats the stored factors using signed superscript powers and multiplication dots.
    ///
    /// Matching factors are simplified when configured; otherwise duplicates and opposing exponents remain.
    /// Zero exponents are always omitted and positive one is implicit. Labels are expected to be normalized atomic
    /// symbols; this formatter does not validate, normalize, or add parentheses around individual labels.
    ///
    /// - Returns: The formatted unit expression, or `1` when no nonzero factors remain.
    internal func format() -> String {
        /// Returns a unit label, omitting zero exponents and leaving positive one implicit.
        ///
        /// - Parameters:
        ///   - symbol: The factor label.
        ///   - exponent: The signed exponent, including `Int.min`.
        /// - Returns: `nil` for zero, the symbol for one, or the symbol followed by a signed superscript.
        func label(
            _ symbol: String,
            exponent: Int
        ) -> String? {
            guard exponent != 0 else {
                return nil
            }

            guard exponent != 1 else {
                return symbol
            }

            return symbol + Superscript(exponent).description
        }

        let factors: Array<UnitSymbolFactor> = self.configuration.simplifies ? self.factors.simplified() : self.factors
        let labels: Array<String> = factors.compactMap { factor in
            return label(
                factor.symbol,
                exponent: factor.exponent
            )
        }

        return labels.isEmpty ? "1" : labels.joined(separator: OperatorToken.multiplication.rawValue)
    }
}
