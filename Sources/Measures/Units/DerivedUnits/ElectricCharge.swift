// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

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

    // MARK: Composed Units

    /// The ampere hour unit of electric charge.
    public static let ampereHour: Self = ElectricCurrent.ampere.multiplying(by: .hour)

    /// The milliampere-hour unit of electric charge.
    public static let milliampereHour: Self = ElectricCurrent.milliampere.multiplying(by: .hour)

    /// The ampere second unit of electric charge.
    public static let ampereSecond: Self = ElectricCurrent.ampere.multiplying(by: .second)
}

// MARK: - Codable

extension ElectricCharge: Codable {}

// MARK: - Comparable

extension ElectricCharge: Comparable {}

// MARK: - Divisible

extension ElectricCharge {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter electricPotential: A unit of electric potential.
    /// - returns: A unit of electrical capacitance.
    public func dividing(by electricPotential: ElectricPotential) -> ElectricalCapacitance {
        let coefficient: Double = self.coefficient * (1 / electricPotential.coefficient)
        let symbol: String = self.symbol + "/" + electricPotential.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }

    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter time: A unit of time.
    /// - returns: A unit of electric current.
    public func dividing(by time: Time) -> ElectricCurrent {
        let coefficient: Double = self.coefficient * (1 / time.coefficient)
        let symbol: String = self.symbol + "/" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension ElectricCharge: Equatable {}

// MARK: - Hashable

extension ElectricCharge: Hashable {}

// MARK: - Measurable

extension ElectricCharge: Measurable {
    public static let base: Self = .coulomb
}

// MARK: - Sendable

extension ElectricCharge: Sendable {}
