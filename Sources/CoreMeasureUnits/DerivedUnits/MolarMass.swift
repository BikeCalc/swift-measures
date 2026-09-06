// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes

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

    // MARK: Composed Units

    /// The kilograms per mole unit of molar mass.
    public static let kilogramsPerMole: Self = Mass.kilogram.dividing(by: SubstanceAmount.mole)

    /// The grams per mole unit of molar mass.
    public static let gramsPerMole: Self = Mass.gram.dividing(by: SubstanceAmount.mole)
}

// MARK: - Codable

extension MolarMass: Codable {}

// MARK: - Comparable

extension MolarMass: Comparable {}

// MARK: - Equatable

extension MolarMass: Equatable {}

// MARK: - Hashable

extension MolarMass: Hashable {}

// MARK: - Measurable

extension MolarMass: Measurable {
    public static let base: Self = .gramsPerMole
}

// MARK: - Sendable

extension MolarMass: Sendable {}
