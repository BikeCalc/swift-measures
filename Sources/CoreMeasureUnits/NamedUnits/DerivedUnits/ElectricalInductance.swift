// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for electrical inductance.
@MetricUnits(name: "henry", symbol: "H")
public struct ElectricalInductance {
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
        time: -2,
        electricCurrent: -2
    )

    /// Creates a unit of electrical inductance from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the magnetic flux unit by the electric current unit.
    ///
    /// - Parameters:
    ///   - magneticFlux: The magnetic flux unit.
    ///   - electricCurrent: The electric current unit.
    internal init(
        magneticFlux: MagneticFlux,
        electricCurrent: ElectricCurrent
    ) {
        self.init(
            coefficient: magneticFlux.coefficient * (1 / electricCurrent.coefficient),
            symbol: magneticFlux.symbol + "/" + electricCurrent.symbol
        )
    }

    // MARK: Composed Units

    /// The weber per ampere unit of electrical inductance.
    public static let weberPerAmpere: Self = .init(
        magneticFlux: .weber,
        electricCurrent: .ampere
    )
}

// MARK: - Codable

extension ElectricalInductance: Codable {}

// MARK: - Comparable

extension ElectricalInductance: Comparable {}

// MARK: - Equatable

extension ElectricalInductance: Equatable {}

// MARK: - Hashable

extension ElectricalInductance: Hashable {}

// MARK: - NamedUnit

extension ElectricalInductance: NamedUnit {
    public static let base: Self = .henry
}

// MARK: - Sendable

extension ElectricalInductance: Sendable {}
