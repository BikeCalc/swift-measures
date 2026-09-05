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

    // MARK: Composed Units

    /// The coulomb per second unit of electric current.
    public static let coulombPerSecond: Self = ElectricCharge.coulomb.dividing(by: .second)
}

// MARK: - Codable

extension ElectricCurrent: Codable {}

// MARK: - Comparable

extension ElectricCurrent: Comparable {}

// MARK: - Multipliable

extension ElectricCurrent {
    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - Parameter time: A unit of time.
    /// - Returns: A unit of electric charge.
    public func multiplying(by time: Time) -> ElectricCharge {
        let coefficient: Double = self.coefficient * time.coefficient
        let symbol: String = self.symbol + "⋅" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }

    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - Parameter electricPotential: A unit of electric potential.
    /// - Returns: A unit of power.
    public func multiplying(by electricPotential: ElectricPotential) -> Power {
        let coefficient: Double = self.coefficient * electricPotential.coefficient
        let symbol: String = self.symbol + "⋅" + electricPotential.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Divisible

extension ElectricCurrent {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - Parameter electricPotential: A unit of electric potential.
    /// - Returns: A unit of electric conductance.
    public func dividing(by electricPotential: ElectricPotential) -> ElectricConductance {
        let coefficient: Double = self.coefficient * (1 / electricPotential.coefficient)
        let symbol: String = self.symbol + "/" + electricPotential.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

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
