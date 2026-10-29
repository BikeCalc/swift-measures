// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures

/// Represents a * x + b; an absent term is a symbolic zero without a dimension.
internal struct LinearExpression {
    /// The measurement multiplying the unknown, or `nil` for an absent variable term.
    internal let coefficient: Measure<ComposedUnit>?

    /// The additive measurement, or `nil` for an absent constant term.
    internal let constant: Measure<ComposedUnit>?

    /// Creates a linear expression from its optional terms.
    ///
    /// - Parameters:
    ///   - coefficient: The term multiplying the unknown, or `nil` when absent.
    ///   - constant: The additive term, or `nil` when absent.
    internal init(
        coefficient: Measure<ComposedUnit>? = nil,
        constant: Measure<ComposedUnit>? = nil
    ) {
        self.coefficient = coefficient
        self.constant = constant
    }

    /// Adds corresponding variable and constant terms.
    ///
    /// - Parameter rhs: The expression to add.
    /// - Returns: The combined linear expression.
    /// - Throws: A calculation error when corresponding terms are incompatible or arithmetic is invalid.
    internal func adding(_ rhs: Self) throws(CalculationError) -> Self {
        return try Self(
            coefficient: Self.add(
                self.coefficient,
                rhs.coefficient
            ),
            constant: Self.add(
                self.constant,
                rhs.constant
            )
        )
    }

    /// Negates the values of the present terms without changing their units.
    ///
    /// - Returns: The negated linear expression.
    /// - Throws: A calculation error if a term is invalid or its value is non-finite.
    internal func negated() throws(CalculationError) -> Self {
        return try Self(
            coefficient: self.coefficient?.negated(),
            constant: self.constant?.negated()
        )
    }

    /// Applies a multiplication or division to each present term.
    ///
    /// - Parameters:
    ///   - value: The measurement used to scale the terms.
    ///   - operation: The multiplication or division operation to apply.
    /// - Returns: The scaled linear expression.
    /// - Throws: A calculation error if scaling violates dimension limits or produces a non-finite result.
    internal func scaled(
        by value: Measure<ComposedUnit>,
        operation: OperatorToken
    ) throws(CalculationError) -> Self {
        return try Self(
            coefficient: self.coefficient?.applying(
                operation,
                to: value
            ),
            constant: self.constant?.applying(
                operation,
                to: value
            )
        )
    }

    /// Adds optional measurement terms, treating absent terms as symbolic zero.
    ///
    /// - Parameters:
    ///   - lhs: The first term, or `nil` when absent.
    ///   - rhs: The second term, or `nil` when absent.
    /// - Returns: The combined term, or `nil` when both terms are absent.
    /// - Throws: A calculation error if two present terms cannot be added.
    private static func add(
        _ lhs: Measure<ComposedUnit>?,
        _ rhs: Measure<ComposedUnit>?
    ) throws(CalculationError) -> Measure<ComposedUnit>? {
        guard let lhs else {
            return rhs
        }

        guard let rhs else {
            return lhs
        }

        return try lhs.applying(
            .add,
            to: rhs
        )
    }
}
