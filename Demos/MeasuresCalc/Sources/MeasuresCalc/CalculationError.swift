// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// An expression diagnostic suitable for a terminal or another client.
package struct CalculationError {
    /// The category of the failure.
    internal enum Code: String, Sendable {
        /// The expression does not follow the supported grammar.
        case invalidSyntax

        /// An identifier is neither a registered unit nor the selected unknown.
        case unknownIdentifier

        /// A symbol identifies more than one registered unit.
        case ambiguousUnit

        /// The operation requires matching physical dimensions.
        case incompatibleDimensions

        /// A diagnostic category for division by zero; current evaluation reports non-finite results instead.
        case divisionByZero

        /// An exponent is not a supported dimensionless integer.
        case invalidPower

        /// A calculation produced infinity or NaN.
        case nonFiniteResult

        /// A unit has an invalid conversion definition or an unsupported offset composition.
        case invalidUnit

        /// The requested destination is not a supported unit expression.
        case invalidOutputUnit

        /// The equation lies outside the linear solver’s supported grammar.
        case unsupportedEquation

        /// The linear equation has no solution.
        case noSolution

        /// The linear equation does not determine a unique solution.
        case infiniteSolutions

        /// The expression length, nesting depth, or dimension exponents exceed calculator limits.
        case limitExceeded
    }

    /// The category of the failure.
    internal let code: Self.Code

    /// A human-readable explanation.
    internal let message: String

    /// The affected characters, when a position is available.
    internal let span: SourceSpan?

    /// Creates a diagnostic.
    ///
    /// - Parameters:
    ///   - code: The category of the diagnostic.
    ///   - message: The explanation presented to the caller.
    ///   - span: The affected character range, or `nil` when no location is available.
    internal init(
        code: Self.Code,
        message: String,
        span: SourceSpan? = nil
    ) {
        self.code = code
        self.message = message
        self.span = span
    }
}

// MARK: - CustomStringConvertible

extension CalculationError: CustomStringConvertible {
    package var description: String {
        guard let span: SourceSpan = self.span else {
            return self.message
        }
        return "\(self.message) (character \(span.start + 1))"
    }
}

// MARK: - Equatable

extension CalculationError: Equatable {}

// MARK: - Error

extension CalculationError: Error {}

// MARK: - Sendable

extension CalculationError: Sendable {}
