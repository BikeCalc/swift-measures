// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

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

    // MARK: Composed Units

    /// The volt-second unit of magnetic flux.
    public static let voltSecond: Self = ElectricPotential.volt.multiplying(by: .second)
}

// MARK: - Codable

extension MagneticFlux: Codable {}

// MARK: - Comparable

extension MagneticFlux: Comparable {}

// MARK: - Divisible

extension MagneticFlux {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter area: A unit of area.
    /// - returns: A unit of magnetic flux density.
    public func dividing(by area: Area) -> MagneticFluxDensity {
        let coefficient: Double = self.coefficient * (1 / area.coefficient)
        let symbol: String = self.symbol + "/" + area.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }

    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter electricCurrent: A unit of electric current.
    /// - returns: A unit of electrical inductance.
    public func dividing(by electricCurrent: ElectricCurrent) -> ElectricalInductance {
        let coefficient: Double = self.coefficient * (1 / electricCurrent.coefficient)
        let symbol: String = self.symbol + "/" + electricCurrent.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension MagneticFlux: Equatable {}

// MARK: - Hashable

extension MagneticFlux: Hashable {}

// MARK: - Measurable

extension MagneticFlux: Measurable {
    public static let base: Self = .weber
}

// MARK: - Sendable

extension MagneticFlux: Sendable {}
