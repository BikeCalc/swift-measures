// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro
import NumericsExtended

/// A unit of measure for luminous flux.
@MetricUnits(name: "lumen", symbol: "lm")
public struct LuminousFlux {
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

    public let dimension: Dimension = .init(luminousIntensity: 1)

    /// Returns a unit of illuminance by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The luminous flux unit.
    ///   - rhs: The area unit.
    /// - Returns: A unit of illuminance.
    public static func / (
        lhs: Self,
        rhs: Area
    ) -> Illuminance {
        return .init(
            luminousFlux: lhs,
            area: rhs
        )
    }
}

// MARK: - CanonicallyEquatable

extension LuminousFlux: CanonicallyEquatable {}

// MARK: - CaseIterable

extension LuminousFlux: CaseIterable {
    /// The predefined units, excluding the duplicate base alias and custom units.
    ///
    /// Metric units appear from largest to smallest prefix, followed by other units in source declaration order.
    public static let allCases: Array<Self> = [
        .quettalumen,
        .ronnalumen,
        .yottalumen,
        .zettalumen,
        .exalumen,
        .petalumen,
        .teralumen,
        .gigalumen,
        .megalumen,
        .kilolumen,
        .hectolumen,
        .decalumen,
        .lumen,
        .decilumen,
        .centilumen,
        .millilumen,
        .microlumen,
        .nanolumen,
        .picolumen,
        .femtolumen,
        .attolumen,
        .zeptolumen,
        .yoctolumen,
        .rontolumen,
        .quectolumen
    ]
}

// MARK: - Codable

extension LuminousFlux: Codable {}

// MARK: - Comparable

extension LuminousFlux: Comparable {}

// MARK: - ComposableUnit

extension LuminousFlux: ComposableUnit {}

// MARK: - DefinedUnit

extension LuminousFlux: DefinedUnit {
    public static let base: Self = .lumen
}

// MARK: - Equatable

extension LuminousFlux: Equatable {}

// MARK: - Hashable

extension LuminousFlux: Hashable {}

// MARK: - Sendable

extension LuminousFlux: Sendable {}
