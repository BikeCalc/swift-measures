// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro
import NumericsExtended

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

// MARK: - CanonicallyEquatable

extension ElectricalResistance: CanonicallyEquatable {}

// MARK: - CaseIterable

extension ElectricalResistance: CaseIterable {
    /// The predefined units, excluding the duplicate base alias and custom units.
    ///
    /// Metric units appear from largest to smallest prefix, followed by other units in source declaration order.
    public static let allCases: Array<Self> = [
        .quettaohm,
        .ronnaohm,
        .yottaohm,
        .zettaohm,
        .exaohm,
        .petaohm,
        .teraohm,
        .gigaohm,
        .megaohm,
        .kiloohm,
        .hectoohm,
        .decaohm,
        .ohm,
        .deciohm,
        .centiohm,
        .milliohm,
        .microohm,
        .nanoohm,
        .picoohm,
        .femtoohm,
        .attoohm,
        .zeptoohm,
        .yoctoohm,
        .rontoohm,
        .quectoohm
    ]
}

// MARK: - Codable

extension ElectricalResistance: Codable {}

// MARK: - Comparable

extension ElectricalResistance: Comparable {}

// MARK: - ComposableUnit

extension ElectricalResistance: ComposableUnit {}

// MARK: - DefinedUnit

extension ElectricalResistance: DefinedUnit {
    public static let base: Self = .ohm
}

// MARK: - Equatable

extension ElectricalResistance: Equatable {}

// MARK: - Hashable

extension ElectricalResistance: Hashable {}

// MARK: - Sendable

extension ElectricalResistance: Sendable {}
