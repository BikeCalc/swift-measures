// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for electric current.
@MetricUnits(name: "ampere", symbol: "A")
public struct ElectricCurrent {
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

    /// Creates a unit of electric current from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the electric charge unit by the time unit.
    ///
    /// - Parameters:
    ///   - electricCharge: The electric charge unit.
    ///   - time: The time unit.
    internal init(
        electricCharge: ElectricCharge,
        time: Time
    ) {
        self.init(
            coefficient: electricCharge.coefficient * (1 / time.coefficient),
            symbol: electricCharge.symbol + "/" + time.symbol
        )
    }

    /// Returns a unit of electric charge by multiplying the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The electric current unit.
    ///   - rhs: The time unit.
    /// - Returns: A unit of electric charge.
    public static func * (
        lhs: Self,
        rhs: Time
    ) -> ElectricCharge {
        return .init(
            electricCurrent: lhs,
            time: rhs
        )
    }

    /// Returns a unit of electric conductance by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The electric current unit.
    ///   - rhs: The electric potential unit.
    /// - Returns: A unit of electric conductance.
    public static func / (
        lhs: Self,
        rhs: ElectricPotential
    ) -> ElectricConductance {
        return .init(
            electricCurrent: lhs,
            electricPotential: rhs
        )
    }

    // MARK: Composed Units

    /// The coulomb per second unit of electric current.
    public static let coulombPerSecond: Self = .init(
        electricCharge: .coulomb,
        time: .second
    )
}

// MARK: - Codable

extension ElectricCurrent: Codable {}

// MARK: - Comparable

extension ElectricCurrent: Comparable {}

// MARK: - Equatable

extension ElectricCurrent: Equatable {}

// MARK: - Hashable

extension ElectricCurrent: Hashable {}

// MARK: - Measurable

extension ElectricCurrent: Measurable {
    public static let base: Self = .ampere
}

// MARK: - Sendable

extension ElectricCurrent: Sendable {}
