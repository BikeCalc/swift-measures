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

    public let dimension: Dimension = .init(
        mass: 1,
        time: -2,
        electricCurrent: -1
    )

    /// Creates a unit of magnetic flux density from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the magnetic flux unit by the area unit.
    ///
    /// - Parameters:
    ///   - magneticFlux: The magnetic flux unit.
    ///   - area: The area unit.
    internal init(
        magneticFlux: MagneticFlux,
        area: Area
    ) {
        self.init(
            coefficient: magneticFlux.coefficient * (1 / area.coefficient),
            symbol: magneticFlux.symbol + "/" + area.symbol
        )
    }

    // MARK: Composed Units

    /// The weber per square meter unit of magnetic flux density.
    public static let weberPerSquareMeter: Self = .init(
        magneticFlux: .weber,
        area: .squareMeter
    )
}

// MARK: - Codable

extension MagneticFluxDensity: Codable {}

// MARK: - Comparable

extension MagneticFluxDensity: Comparable {}

// MARK: - ComposableUnit

extension MagneticFluxDensity: ComposableUnit {}

// MARK: - DefinedUnit

extension MagneticFluxDensity: DefinedUnit {
    public static let base: Self = .tesla
}

// MARK: - Equatable

extension MagneticFluxDensity: Equatable {}

// MARK: - Hashable

extension MagneticFluxDensity: Hashable {}

// MARK: - Sendable

extension MagneticFluxDensity: Sendable {}
