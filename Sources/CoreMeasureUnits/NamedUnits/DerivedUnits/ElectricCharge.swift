// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for electric charge.
@MetricUnits(name: "coulomb", symbol: "C")
public struct ElectricCharge {
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
        time: 1,
        electricCurrent: 1
    )

    /// Creates a unit of electric charge from the specified units.
    ///
    /// The coefficient and symbol are formed by multiplying the electric current unit by the time unit.
    ///
    /// - Parameters:
    ///   - electricCurrent: The electric current unit.
    ///   - time: The time unit.
    internal init(
        electricCurrent: ElectricCurrent,
        time: Time
    ) {
        self.init(
            coefficient: electricCurrent.coefficient * time.coefficient,
            symbol: electricCurrent.symbol + "·" + time.symbol
        )
    }

    /// Returns a unit of electrical capacitance by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The electric charge unit.
    ///   - rhs: The electric potential unit.
    /// - Returns: A unit of electrical capacitance.
    public static func / (
        lhs: Self,
        rhs: ElectricPotential
    ) -> ElectricalCapacitance {
        return .init(
            electricCharge: lhs,
            electricPotential: rhs
        )
    }

    /// Returns a unit of electric current by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The electric charge unit.
    ///   - rhs: The time unit.
    /// - Returns: A unit of electric current.
    public static func / (
        lhs: Self,
        rhs: Time
    ) -> ElectricCurrent {
        return .init(
            electricCharge: lhs,
            time: rhs
        )
    }

    // MARK: Composed Units

    /// The ampere hour unit of electric charge.
    public static let ampereHour: Self = .init(
        electricCurrent: .ampere,
        time: .hour
    )

    /// The milliampere-hour unit of electric charge.
    public static let milliampereHour: Self = .init(
        electricCurrent: .milliampere,
        time: .hour
    )

    /// The ampere second unit of electric charge.
    public static let ampereSecond: Self = .init(
        electricCurrent: .ampere,
        time: .second
    )
}

// MARK: - Codable

extension ElectricCharge: Codable {}

// MARK: - Comparable

extension ElectricCharge: Comparable {}

// MARK: - ComposableUnit

extension ElectricCharge: ComposableUnit {}

// MARK: - DefinedUnit

extension ElectricCharge: DefinedUnit {
    public static let base: Self = .coulomb
}

// MARK: - Equatable

extension ElectricCharge: Equatable {}

// MARK: - Hashable

extension ElectricCharge: Hashable {}

// MARK: - Sendable

extension ElectricCharge: Sendable {}
