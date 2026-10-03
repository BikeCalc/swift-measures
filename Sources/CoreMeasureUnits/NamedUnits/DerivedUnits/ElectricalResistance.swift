// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for electrical resistance.
@MetricUnits(name: "ohm", symbol: "Ω")
public struct ElectricalResistance {
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

    public let dimension: Dimension = .init(
        length: 2,
        mass: 1,
        time: -3,
        electricCurrent: -2
    )

    /// Creates a unit of electrical resistance from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the electric potential unit by the electric current unit.
    ///
    /// - Parameters:
    ///   - electricPotential: The electric potential unit.
    ///   - electricCurrent: The electric current unit.
    internal init(
        electricPotential: ElectricPotential,
        electricCurrent: ElectricCurrent
    ) {
        self.init(
            coefficient: electricPotential.coefficient * (1 / electricCurrent.coefficient),
            symbol: electricPotential.symbol + "/" + electricCurrent.symbol
        )
    }
}

// MARK: - Codable

extension ElectricalResistance: Codable {}

// MARK: - Comparable

extension ElectricalResistance: Comparable {}

// MARK: - Equatable

extension ElectricalResistance: Equatable {}

// MARK: - Hashable

extension ElectricalResistance: Hashable {}

// MARK: - NamedUnit

extension ElectricalResistance: NamedUnit {
    public static let base: Self = .ohm
}

// MARK: - Sendable

extension ElectricalResistance: Sendable {}
