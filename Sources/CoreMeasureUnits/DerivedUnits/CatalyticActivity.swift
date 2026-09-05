// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for catalytic activity.
@MetricUnits(name: "katal", symbol: "kat")
public struct CatalyticActivity {
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

    /// The mole per second unit of catalytic activity.
    public static let molePerSecond: Self = SubstanceAmount.mole.dividing(by: .second)

}

// MARK: - Codable

extension CatalyticActivity: Codable {}

// MARK: - Comparable

extension CatalyticActivity: Comparable {}

// MARK: - Equatable

extension CatalyticActivity: Equatable {}

// MARK: - Hashable

extension CatalyticActivity: Hashable {}

// MARK: - Measurable

extension CatalyticActivity: Measurable {
    public static let base: Self = .katal
}

// MARK: - Sendable

extension CatalyticActivity: Sendable {}
