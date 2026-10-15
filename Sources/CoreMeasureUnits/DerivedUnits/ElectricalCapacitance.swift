// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for electrical capacitance.
@MetricUnits(name: "farad", symbol: "F")
public struct ElectricalCapacitance {
    public let coefficient: Double

    public let constant: Double

    public let symbol: String

    public init(
        coefficient: Double,
        constant: Double = 0,
        symbol: String
    ) {
        self.coefficient = coefficient
        self.constant = constant
        self.symbol = symbol
    }

    /// Creates a unit of electrical capacitance from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the electric charge unit by the electric potential unit.
    ///
    /// - Parameters:
    ///   - electricCharge: The electric charge unit.
    ///   - electricPotential: The electric potential unit.
    internal init(
        electricCharge: ElectricCharge,
        electricPotential: ElectricPotential
    ) {
        self.init(
            coefficient: electricCharge.coefficient * (1 / electricPotential.coefficient),
            symbol: electricCharge.symbol + "/" + electricPotential.symbol
        )
    }
}

// MARK: - Codable

extension ElectricalCapacitance: Codable {}

// MARK: - Comparable

extension ElectricalCapacitance: Comparable {}

// MARK: - Equatable

extension ElectricalCapacitance: Equatable {}

// MARK: - Hashable

extension ElectricalCapacitance: Hashable {}

// MARK: - Measurable

extension ElectricalCapacitance: Measurable {
    public static let base: Self = .farad
}

// MARK: - Sendable

extension ElectricalCapacitance: Sendable {}
