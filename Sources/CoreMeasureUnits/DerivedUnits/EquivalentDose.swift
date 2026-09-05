// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for equivalent dose.
@MetricUnits(name: "sievert", symbol: "Sv")
public struct EquivalentDose {
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

extension EquivalentDose: Codable {}

// MARK: - Comparable

extension EquivalentDose: Comparable {}

// MARK: - Equatable

extension EquivalentDose: Equatable {}

// MARK: - Hashable

extension EquivalentDose: Hashable {}

// MARK: - Measurable

extension EquivalentDose: Measurable {
    public static let base: Self = .sievert
}

// MARK: - Sendable

extension EquivalentDose: Sendable {}
