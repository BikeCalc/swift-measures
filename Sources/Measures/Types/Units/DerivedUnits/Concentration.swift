// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

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

    // MARK: Composed Units

    /// The kilograms per cubic meter unit of concentration.
    public static let kilogramsPerCubicMeter: Self = Mass.kilogram.dividing(by: .cubicMeter)

    /// The grams per liter unit of concentration.
    public static let gramsPerLiter: Self = Mass.gram.dividing(by: .liter)

    /// The milligrams per liter unit of concentration.
    public static let milligramsPerLiter: Self = Mass.milligram.dividing(by: .liter)
}

// MARK: - Codable

extension Concentration: Codable {}

// MARK: - Comparable

extension Concentration: Comparable {}

// MARK: - Equatable

extension Concentration: Equatable {}

// MARK: - Hashable

extension Concentration: Hashable {}

// MARK: - Measurable

extension Concentration: Measurable {
    public static let base: Self = .gramsPerLiter
}

// MARK: - Sendable

extension Concentration: Sendable {}
