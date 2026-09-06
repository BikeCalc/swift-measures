// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for electrical inductance.
@MetricUnits(name: "henry", symbol: "H")
public struct ElectricalInductance {
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

    /// The weber per ampere unit of electrical inductance.
    public static let weberPerAmpere: Self = MagneticFlux.weber.dividing(by: .ampere)
}

// MARK: - Codable

extension ElectricalInductance: Codable {}

// MARK: - Comparable

extension ElectricalInductance: Comparable {}

// MARK: - Equatable

extension ElectricalInductance: Equatable {}

// MARK: - Hashable

extension ElectricalInductance: Hashable {}

// MARK: - Measurable

extension ElectricalInductance: Measurable {
    public static let base: Self = .henry
}

// MARK: - Sendable

extension ElectricalInductance: Sendable {}
