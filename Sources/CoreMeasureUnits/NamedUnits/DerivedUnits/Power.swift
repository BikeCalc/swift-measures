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

    // MARK: Composed Units

    /// The joule per second unit of power.
    public static let joulePerSecond: Self = Energy.joule.dividing(by: .second)

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

// MARK: - ComposableUnit

extension Power: ComposableUnit {}

// MARK: - DefinedUnit

extension Power: DefinedUnit {
    public static let base: Self = .watt
}

// MARK: - Equatable

extension Power: Equatable {}

// MARK: - Hashable

extension Power: Hashable {}

// MARK: - Multipliable

extension Power {
    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - Parameter time: A unit of time.
    /// - Returns: A unit of energy.
    public func multiplying(by time: Time) -> Energy {
        let coefficient: Double = self.coefficient * time.coefficient
        let symbol: String = self.symbol + "·" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Sendable

extension Power: Sendable {}
