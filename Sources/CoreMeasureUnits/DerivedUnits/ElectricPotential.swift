// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for electric potential.
@MetricUnits(name: "volt", symbol: "V")
public struct ElectricPotential {
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

    /// Creates a unit of electric potential from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the power unit by the electric current unit.
    ///
    /// - Parameters:
    ///   - power: The power unit.
    ///   - electricCurrent: The electric current unit.
    internal init(
        power: Power,
        electricCurrent: ElectricCurrent
    ) {
        self.init(
            coefficient: power.coefficient * (1 / electricCurrent.coefficient),
            symbol: power.symbol + "/" + electricCurrent.symbol
        )
    }

    /// Returns a unit of magnetic flux by multiplying the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The electric potential unit.
    ///   - rhs: The time unit.
    /// - Returns: A unit of magnetic flux.
    public static func * (
        lhs: Self,
        rhs: Time
    ) -> MagneticFlux {
        return .init(
            electricPotential: lhs,
            time: rhs
        )
    }

    /// Returns a unit of electrical resistance by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The electric potential unit.
    ///   - rhs: The electric current unit.
    /// - Returns: A unit of electrical resistance.
    public static func / (
        lhs: Self,
        rhs: ElectricCurrent
    ) -> ElectricalResistance {
        return .init(
            electricPotential: lhs,
            electricCurrent: rhs
        )
    }
}

// MARK: - Codable

extension ElectricPotential: Codable {}

// MARK: - Comparable

extension ElectricPotential: Comparable {}

// MARK: - Equatable

extension ElectricPotential: Equatable {}

// MARK: - Hashable

extension ElectricPotential: Hashable {}

// MARK: - Measurable

extension ElectricPotential: Measurable {
    public static let base: Self = .volt
}

// MARK: - Sendable

extension ElectricPotential: Sendable {}
