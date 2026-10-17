// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import NumericsExtended

/// A unit of measure for molar mass.
public struct MolarMass {
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
        mass: 1,
        substanceAmount: -1
    )

    /// Creates a unit of molar mass from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the mass unit by the substance amount unit.
    ///
    /// - Parameters:
    ///   - mass: The mass unit.
    ///   - substanceAmount: The substance amount unit.
    internal init(
        mass: Mass,
        substanceAmount: SubstanceAmount
    ) {
        self.init(
            coefficient: mass.coefficient * (1 / substanceAmount.coefficient),
            symbol: mass.symbol + "/" + substanceAmount.symbol
        )
    }

    // MARK: Composed Units

    /// The kilograms per mole unit of molar mass.
    public static let kilogramsPerMole: Self = .init(
        mass: .kilogram,
        substanceAmount: .mole
    )

    /// The grams per mole unit of molar mass.
    public static let gramsPerMole: Self = .init(
        mass: .gram,
        substanceAmount: .mole
    )
}

// MARK: - CanonicallyEquatable

extension MolarMass: CanonicallyEquatable {}

// MARK: - Codable

extension MolarMass: Codable {}

// MARK: - Comparable

extension MolarMass: Comparable {}

// MARK: - ComposableUnit

extension MolarMass: ComposableUnit {}

// MARK: - DefinedUnit

extension MolarMass: DefinedUnit {
    public static let base: Self = .kilogramsPerMole
}

// MARK: - Equatable

extension MolarMass: Equatable {}

// MARK: - Hashable

extension MolarMass: Hashable {}

// MARK: - Sendable

extension MolarMass: Sendable {}
