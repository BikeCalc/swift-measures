// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import NumericsExtended

/// Checks factor scales, offsets, and the representability of their combined values.
///
/// Validation preserves factor order and does not simplify, normalize, or inspect display symbols.
internal struct ComposedUnitFactorValidator {
    /// The factors to evaluate in their stored order.
    private let factors: Array<ComposedUnit.Factor>

    /// Creates a validator for a composed unit's factors.
    ///
    /// - Parameter factors: The factors to check; an empty collection represents the identity.
    internal init(factors: Array<ComposedUnit.Factor>) {
        self.factors = factors
    }

    /// Checks unit conversions, offset combinations, and derived scales and dimension exponents.
    ///
    /// Nonzero offsets require a single active factor with exponent one. Zero exponents are inactive,
    /// but their unit definitions must still have finite positive coefficients and finite constants.
    ///
    /// - Returns: Whether the factors can form a valid unit without dimension arithmetic overflowing.
    internal func validate() -> Bool {
        /// Checks that every factor's unit has a valid conversion, including inactive factors.
        ///
        /// - Returns: Whether every unit's coefficient is finite and positive and its constant is finite.
        func hasValidConversions() -> Bool {
            for factor in self.factors
            where factor.unit.hasValidConversion == false {
                return false
            }

            return true
        }

        /// Checks that nonzero constants are used only by a standalone active factor.
        ///
        /// - Returns: Whether all active constants are zero or the sole active factor has exponent one.
        func hasValidConstants() -> Bool {
            let activeFactors: Array<ComposedUnit.Factor> = self.factors
                .filter { $0.exponent != 0 }

            for factor in activeFactors
            where factor.unit.constant != 0 {
                guard activeFactors.count == 1 else {
                    return false
                }

                return factor.exponent == 1
            }

            return true
        }

        return hasValidConversions()
            && hasValidConstants()
    }
}
