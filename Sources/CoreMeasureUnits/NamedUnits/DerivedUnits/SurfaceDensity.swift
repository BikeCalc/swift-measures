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

/// A unit of measure for surface density.
@CaseIterableUnits
public struct SurfaceDensity {
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
        length: -2,
        mass: 1
    )

    /// Creates a unit of surface density from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the mass unit by the area unit.
    ///
    /// - Parameters:
    ///   - mass: The mass unit.
    ///   - area: The area unit.
    internal init(
        mass: Mass,
        area: Area
    ) {
        self.init(
            coefficient: mass.coefficient * (1 / area.coefficient),
            symbol: mass.symbol + "/" + area.symbol
        )
    }

    // MARK: Composed Units

    /// The pounds per square foot unit of surface density.
    public static let poundsPerSquareFoot: Self = .init(
        mass: .pound,
        area: .squareFoot
    )

    /// The kilograms per square meter unit of surface density.
    public static let kilogramsPerSquareMeter: Self = .init(
        mass: .kilogram,
        area: .squareMeter
    )

    /// The grams per square meter unit of surface density.
    public static let gramsPerSquareMeter: Self = .init(
        mass: .gram,
        area: .squareMeter
    )
}

// MARK: - CanonicallyEquatable

extension SurfaceDensity: CanonicallyEquatable {}

// MARK: - Codable

extension SurfaceDensity: Codable {}

// MARK: - Comparable

extension SurfaceDensity: Comparable {}

// MARK: - ComposableUnit

extension SurfaceDensity: ComposableUnit {}

// MARK: - DefinedUnit

extension SurfaceDensity: DefinedUnit {
    public static let base: Self = .kilogramsPerSquareMeter
}

// MARK: - Equatable

extension SurfaceDensity: Equatable {}

// MARK: - Hashable

extension SurfaceDensity: Hashable {}

// MARK: - Sendable

extension SurfaceDensity: Sendable {}
