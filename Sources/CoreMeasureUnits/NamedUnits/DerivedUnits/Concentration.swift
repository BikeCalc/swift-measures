// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes

/// A unit of measure for concentration.
public struct Concentration {
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
        length: -3,
        mass: 1
    )

    /// Creates a unit of concentration from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the mass unit by the volume unit.
    ///
    /// - Parameters:
    ///   - mass: The mass unit.
    ///   - volume: The volume unit.
    internal init(
        mass: Mass,
        volume: Volume
    ) {
        self.init(
            coefficient: mass.coefficient * (1 / volume.coefficient),
            symbol: mass.symbol + "/" + volume.symbol
        )
    }

    // MARK: Composed Units

    /// The kilograms per cubic meter unit of concentration.
    public static let kilogramsPerCubicMeter: Self = .init(
        mass: .kilogram,
        volume: .cubicMeter
    )

    /// The grams per liter unit of concentration.
    public static let gramsPerLiter: Self = .init(
        mass: .gram,
        volume: .liter
    )

    /// The milligrams per liter unit of concentration.
    public static let milligramsPerLiter: Self = .init(
        mass: .milligram,
        volume: .liter
    )
}

// MARK: - Codable

extension Concentration: Codable {}

// MARK: - Comparable

extension Concentration: Comparable {}

// MARK: - Equatable

extension Concentration: Equatable {}

// MARK: - Hashable

extension Concentration: Hashable {}

// MARK: - NamedUnit

extension Concentration: NamedUnit {
    public static let base: Self = .gramsPerLiter
}

// MARK: - Sendable

extension Concentration: Sendable {}
