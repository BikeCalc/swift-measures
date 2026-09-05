// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for thermodynamic temperature.
@MetricUnits(name: "kelvin", symbol: "K")
public struct ThermodynamicTemperature {
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

    // MARK: Customary and Imperial Units

    /// The Fahrenheit unit of thermodynamic temperature.
    public static let fahrenheit: Self = .init(
        coefficient: 5 / 9,
        constant: 459.67 * 5 / 9,
        symbol: "°F"
    )

    // MARK: Other Metric Units

    /// The celsius unit of thermodynamic temperature.
    public static let celsius: Self = .init(
        coefficient: 1,
        constant: 273.15,
        symbol: "°C"
    )
}

// MARK: - Codable

extension ThermodynamicTemperature: Codable {}

// MARK: - Comparable

extension ThermodynamicTemperature: Comparable {}

// MARK: - Equatable

extension ThermodynamicTemperature: Equatable {}

// MARK: - Hashable

extension ThermodynamicTemperature: Hashable {}

// MARK: - Measurable

extension ThermodynamicTemperature: Measurable {
    public static let base: Self = .kelvin

    public static let validRange: ClosedRange<Double> = .zero ... .infinity
}

// MARK: - Sendable

extension ThermodynamicTemperature: Sendable {}
