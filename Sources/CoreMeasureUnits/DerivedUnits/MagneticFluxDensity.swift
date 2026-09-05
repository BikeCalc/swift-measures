// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for magnetic flux density.
@MetricUnits(name: "tesla", symbol: "T")
public struct MagneticFluxDensity {
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

    /// The weber per square meter unit of magnetic flux density.
    public static let weberPerSquareMeter: Self = MagneticFlux.weber.dividing(by: .squareMeter)
}

// MARK: - Codable

extension MagneticFluxDensity: Codable {}

// MARK: - Comparable

extension MagneticFluxDensity: Comparable {}

// MARK: - Equatable

extension MagneticFluxDensity: Equatable {}

// MARK: - Hashable

extension MagneticFluxDensity: Hashable {}

// MARK: - Measurable

extension MagneticFluxDensity: Measurable {
    public static let base: Self = .tesla
}

// MARK: - Sendable

extension MagneticFluxDensity: Sendable {}
