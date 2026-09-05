// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

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

// MARK: - Divisible

extension ElectricPotential {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter electricCurrent: A unit of electric current.
    /// - returns: A unit of electrical resistance.
    public func dividing(by electricCurrent: ElectricCurrent) -> ElectricalResistance {
        let coefficient: Double = self.coefficient * (1 / electricCurrent.coefficient)
        let symbol: String = self.symbol + "/" + electricCurrent.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Multipliable

extension ElectricPotential {
    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - parameter electricCharge: A unit of electric charge.
    /// - returns: A unit of energy.
    public func multiplying(by electricCharge: ElectricCharge) -> Energy {
        let coefficient: Double = self.coefficient * electricCharge.coefficient
        let symbol: String = self.symbol + "⋅" + electricCharge.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }

    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - parameter time: A unit of time.
    /// - returns: A unit of magnetic flux.
    public func multiplying(by time: Time) -> MagneticFlux {
        let coefficient: Double = self.coefficient * time.coefficient
        let symbol: String = self.symbol + "⋅" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Sendable

extension ElectricPotential: Sendable {}
