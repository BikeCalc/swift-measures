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

/// A unit of measure for magnetic flux.
@MetricUnits(name: "weber", symbol: "Wb")
public struct MagneticFlux {
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
        electricCurrent: -1
    )

    /// Creates a unit of magnetic flux from the specified units.
    ///
    /// The coefficient and symbol are formed by multiplying the electric potential unit by the time unit.
    ///
    /// - Parameters:
    ///   - electricPotential: The electric potential unit.
    ///   - time: The time unit.
    internal init(
        electricPotential: ElectricPotential,
        time: Time
    ) {
        self.init(
            coefficient: electricPotential.coefficient * time.coefficient,
            symbol: electricPotential.symbol + "·" + time.symbol
        )
    }

    /// Returns a unit of magnetic flux density by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The magnetic flux unit.
    ///   - rhs: The area unit.
    /// - Returns: A unit of magnetic flux density.
    public static func / (
        lhs: Self,
        rhs: Area
    ) -> MagneticFluxDensity {
        return .init(
            magneticFlux: lhs,
            area: rhs
        )
    }

    /// Returns a unit of electrical inductance by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The magnetic flux unit.
    ///   - rhs: The electric current unit.
    /// - Returns: A unit of electrical inductance.
    public static func / (
        lhs: Self,
        rhs: ElectricCurrent
    ) -> ElectricalInductance {
        return .init(
            magneticFlux: lhs,
            electricCurrent: rhs
        )
    }

    // MARK: Composed Units

    /// The volt-second unit of magnetic flux.
    public static let voltSecond: Self = .init(
        electricPotential: .volt,
        time: .second
    )
}

// MARK: - CanonicallyEquatable

extension MagneticFlux: CanonicallyEquatable {}

// MARK: - Codable

extension MagneticFlux: Codable {}

// MARK: - Comparable

extension MagneticFlux: Comparable {}

// MARK: - ComposableUnit

extension MagneticFlux: ComposableUnit {}

// MARK: - DefinedUnit

extension MagneticFlux: DefinedUnit {
    public static let base: Self = .weber
}

// MARK: - Equatable

extension MagneticFlux: Equatable {}

// MARK: - Hashable

extension MagneticFlux: Hashable {}

// MARK: - Sendable

extension MagneticFlux: Sendable {}
