// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures

/// A calculated measurement and its selected display representation.
package struct CalculationResult {
    /// The measurement expressed in the selected display unit.
    internal let measure: Measure<ComposedUnit>

    /// The numeric value in the display unit.
    internal let value: Double

    /// The display unit, or an empty string for a dimensionless result.
    internal let unit: String

    /// Creates a display result for an evaluated measurement.
    ///
    /// - Parameters:
    ///   - measure: The measurement in the selected unit.
    ///   - value: The numeric value to display.
    ///   - unit: The unit symbol to display, or an empty string for a scalar.
    internal init(
        measure: Measure<ComposedUnit>,
        value: Double,
        unit: String
    ) {
        self.measure = measure
        self.value = value
        self.unit = unit
    }
}

// MARK: - CustomStringConvertible

extension CalculationResult: CustomStringConvertible {
    package var description: String {
        let number: String = .init(self.value == 0 ? 0 : self.value)
        return self.unit.isEmpty == true ? number : "\(number) \(self.unit)"
    }
}

// MARK: - Equatable

extension CalculationResult: Equatable {}

// MARK: - Sendable

extension CalculationResult: Sendable {}
