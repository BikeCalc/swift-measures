// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for power.
@MetricUnits(name: "watt", symbol: "W")
public struct Power {
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
        time: -3
    )

    /// Creates a unit of power from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the energy unit by the time unit.
    ///
    /// - Parameters:
    ///   - energy: The energy unit.
    ///   - time: The time unit.
    internal init(
        energy: Energy,
        time: Time
    ) {
        self.init(
            coefficient: energy.coefficient * (1 / time.coefficient),
            symbol: energy.symbol + "/" + time.symbol
        )
    }

    /// Returns a unit of energy by multiplying the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The power unit.
    ///   - rhs: The time unit.
    /// - Returns: A unit of energy.
    public static func * (
        lhs: Self,
        rhs: Time
    ) -> Energy {
        return .init(
            power: lhs,
            time: rhs
        )
    }

    /// Returns a unit of electric potential by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The power unit.
    ///   - rhs: The electric current unit.
    /// - Returns: A unit of electric potential.
    public static func / (
        lhs: Self,
        rhs: ElectricCurrent
    ) -> ElectricPotential {
        return .init(
            power: lhs,
            electricCurrent: rhs
        )
    }

    // MARK: Composed Units

    /// The joule per second unit of power.
    public static let joulePerSecond: Self = .init(
        energy: .joule,
        time: .second
    )

    // MARK: U.S. Customary and Imperial Units

    /// The mechanical horsepower unit of power.
    public static let mechanicalHorsepower: Self = .init(
        coefficient: Energy.footPoundForce.coefficient * 550,
        symbol: "hp"
    )
}

// MARK: - Codable

extension Power: Codable {}

// MARK: - Comparable

extension Power: Comparable {}

// MARK: - Equatable

extension Power: Equatable {}

// MARK: - Hashable

extension Power: Hashable {}

// MARK: - NamedUnit

extension Power: NamedUnit {
    public static let base: Self = .watt
}

// MARK: - Sendable

extension Power: Sendable {}
