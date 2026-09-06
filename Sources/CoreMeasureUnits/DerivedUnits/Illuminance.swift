// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for illuminance.
@MetricUnits(name: "lux", symbol: "lx")
public struct Illuminance {
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

    /// The lumen per square meter unit of illuminance.
    public static let lumenPerSquareMeter: Self = LuminousFlux.lumen.dividing(by: .squareMeter)
}

// MARK: - Codable

extension Illuminance: Codable {}

// MARK: - Comparable

extension Illuminance: Comparable {}

// MARK: - Equatable

extension Illuminance: Equatable {}

// MARK: - Hashable

extension Illuminance: Hashable {}

// MARK: - Measurable

extension Illuminance: Measurable {
    public static let base: Self = .lux
}

// MARK: - Sendable

extension Illuminance: Sendable {}
