// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for surface density.
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

    // MARK: Composed Units

    /// The pounds per square foot unit of surface density.
    public static let poundsPerSquareFoot: Self = Mass.pound.dividing(by: .squareFoot)

    /// The kilograms per square meter unit of surface density.
    public static let kilogramsPerSquareMeter: Self = Mass.kilogram.dividing(by: .squareMeter)

    /// The grams per square meter unit of surface density.
    public static let gramsPerSquareMeter: Self = Mass.gram.dividing(by: .squareMeter)
}

// MARK: - Codable

extension SurfaceDensity: Codable {}

// MARK: - Comparable

extension SurfaceDensity: Comparable {}

// MARK: - Equatable

extension SurfaceDensity: Equatable {}

// MARK: - Hashable

extension SurfaceDensity: Hashable {}

// MARK: - Measurable

extension SurfaceDensity: Measurable {
    public static let base: Self = .gramsPerSquareMeter
}

// MARK: - Sendable

extension SurfaceDensity: Sendable {}
