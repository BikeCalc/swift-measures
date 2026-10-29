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

    /// Expressions are limited to 4,096 characters.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func expressionLengthLimitExceeded(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .limitExceeded,
            message: "Expressions are limited to 4,096 characters.",
            span: span
        )
    }

    /// Expected a finite number; commas and underscores must separate groups of three digits.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func invalidNumberGrouping(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Expected a finite number; commas and underscores must separate groups of three digits.",
            span: span
        )
    }

    /// Expected a finite number; commas and underscores must separate groups of digits.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func invalidNumber(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Expected a finite number; commas and underscores must separate groups of digits.",
            span: span
        )
    }

    /// Choose a variable name made of letters that is not a registered unit.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func invalidVariableName(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .unsupportedEquation,
            message: "Choose a variable name made of letters that is not a registered unit.",
            span: span
        )
    }

    /// Equations containing offset units are not supported; express temperatures in kelvin first.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func offsetEquation(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .unsupportedEquation,
            message: "Equations containing offset units are not supported; express temperatures in kelvin first.",
            span: span
        )
    }

    /// The equation's sides have different dimensions.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func incompatibleEquationDimensions(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .incompatibleDimensions,
            message: "The equation's sides have different dimensions.",
            span: span
        )
    }

    /// An equation must contain exactly one equals sign.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func expectedEquation(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "An equation requires exactly one '='.",
            span: span
        )
    }

    /// The output unit has an incompatible dimension.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func incompatibleOutputDimension(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .incompatibleDimensions,
            message: "The output unit has an incompatible dimension.",
            span: span
        )
    }

    /// The calculation produced a non-finite value.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func nonFiniteResult(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .nonFiniteResult,
            message: "The calculation produced a non-finite value.",
            span: span
        )
    }

    /// Powers must be dimensionless integers between -64 and 64.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func invalidPower(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidPower,
            message: "Powers must be dimensionless integers between -64 and 64.",
            span: span
        )
    }

    /// Cannot add or subtract incompatible units.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func incompatibleArithmeticDimensions(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .incompatibleDimensions,
            message: "Cannot add or subtract incompatible units.",
            span: span
        )
    }

    /// Expected a binary operator.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func expectedBinaryOperator(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Expected a binary operator.",
            span: span
        )
    }

    /// A unit requires a finite positive scale and finite offset.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func invalidUnitConversion(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidUnit,
            message: "A unit requires a finite positive scale and finite offset.",
            span: span
        )
    }

    /// Dimension exponents must be between -64 and 64.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func dimensionLimitExceeded(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .limitExceeded,
            message: "Dimension exponents must be between -64 and 64.",
            span: span
        )
    }

    /// The resulting dimension exceeds calculator limits.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func resultingDimensionLimitExceeded(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .limitExceeded,
            message: "The resulting dimension exceeds calculator limits.",
            span: span
        )
    }

    /// Expected an operator between numbers.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func expectedOperator(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Expected an operator between numbers.",
            span: span
        )
    }

    /// Expected an expression before ')'.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func expectedExpressionBeforeClosingParenthesis(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Expected an expression before ')'.",
            span: span
        )
    }

    /// Unmatched closing parenthesis.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func unmatchedClosingParenthesis(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Unmatched closing parenthesis.",
            span: span
        )
    }

    /// A number, unit, or opening parenthesis was expected.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func expectedOperand(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Expected a number, unit, or '('.",
            span: span
        )
    }

    /// Expressions containing an equals sign require equation solving.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func equationRequiresSolver(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Use equation solving for expressions containing '='.",
            span: span
        )
    }

    /// Unexpected numeric punctuation.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func unexpectedNumericPunctuation(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Unexpected numeric punctuation.",
            span: span
        )
    }

    /// Unmatched opening parenthesis.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func unmatchedOpeningParenthesis(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Unmatched opening parenthesis.",
            span: span
        )
    }

    /// Expected a single expression.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func expectedSingleExpression(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Expected a single expression.",
            span: span
        )
    }

    /// Missing operand.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func missingOperand(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Missing operand.",
            span: span
        )
    }

    /// Missing left operand.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func missingLeftOperand(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Missing left operand.",
            span: span
        )
    }

    /// Expressions are limited to 128 levels of operations.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func expressionDepthLimitExceeded(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .limitExceeded,
            message: "Expressions are limited to 128 levels of operations.",
            span: span
        )
    }

    /// The expression is empty.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func emptyExpression(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "The expression is empty.",
            span: span
        )
    }

    /// The expression is missing an operand.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func missingExpressionOperand(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "The expression is missing an operand.",
            span: span
        )
    }

    /// The equation has infinitely many solutions.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func infiniteSolutions(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .infiniteSolutions,
            message: "The equation has infinitely many solutions.",
            span: span
        )
    }

    /// The equation has no solution.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func noSolution(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .noSolution,
            message: "The equation has no solution.",
            span: span
        )
    }

    /// Offset units must be composed through measurements.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func offsetUnitComposition(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidUnit,
            message: "Offset units cannot be composed alone. Use measurements, such as (10 °C) * (2 s).",
            span: span
        )
    }

    /// An output unit must contain units, products, quotients, and integer powers only.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func invalidOutputUnit(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .invalidOutputUnit,
            message: "An output unit must contain units, products, quotients, and integer powers only.",
            span: span
        )
    }

    /// Only linear equations are supported; the unknown cannot occur in a denominator, product of unknowns, or nontrivial power.
    ///
    /// - Parameter span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func unsupportedEquation(span: SourceSpan? = nil) -> Self {
        return .init(
            code: .unsupportedEquation,
            message:
                "Only linear equations are supported; the unknown cannot occur in a denominator, product of unknowns, "
                + "or nontrivial power.",
            span: span
        )
    }

    /// Creates a diagnostic for the supplied name.
    ///
    /// - Parameters:
    ///   - name: The unrecognized unit or variable name.
    ///   - span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func unknownIdentifier(
        _ name: String,
        span: SourceSpan? = nil
    ) -> Self {
        return .init(
            code: .unknownIdentifier,
            message: "Unknown unit or variable '\(name)'.",
            span: span
        )
    }

    /// Creates a diagnostic for the supplied symbol.
    ///
    /// - Parameters:
    ///   - symbol: The unit symbol with multiple registered definitions.
    ///   - span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func ambiguousUnit(
        _ symbol: String,
        span: SourceSpan? = nil
    ) -> Self {
        return .init(
            code: .ambiguousUnit,
            message: "The unit symbol '\(symbol)' has multiple definitions and cannot be resolved unambiguously.",
            span: span
        )
    }

    /// Creates a diagnostic for the supplied character.
    ///
    /// - Parameters:
    ///   - character: The character that is not supported by the expression grammar.
    ///   - span: The affected character range, or `nil` when no location is available.
    /// - Returns: A calculation diagnostic describing the failure at the supplied location.
    internal static func unexpectedCharacter(
        _ character: Character,
        span: SourceSpan? = nil
    ) -> Self {
        return .init(
            code: .invalidSyntax,
            message: "Unexpected character '\(character)'.",
            span: span
        )
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
