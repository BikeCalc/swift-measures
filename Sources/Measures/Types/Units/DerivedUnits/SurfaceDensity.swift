//
// SurfaceDensity.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

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
    
    /// The kilograms per square meter unit of surface density.
    public static let kilogramsPerSquareMeter: Self = Mass.kilogram.dividing(by: Length.meter.squared())
    
    /// The grams per square meter unit of surface density.
    public static let gramsPerSquareMeter: Self = Mass.gram.dividing(by: Length.meter.squared())
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
