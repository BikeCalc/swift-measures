//
// Concentration.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for concentration.
public struct Concentration {
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
    
    /// The grams per liter unit of concentration.
    public static let gramsPerLiter: Self = Mass.gram.dividing(by: .liter)
}

// MARK: - Codable

extension Concentration: Codable {}

// MARK: - Comparable

extension Concentration: Comparable {}

// MARK: - Equatable

extension Concentration: Equatable {}

// MARK: - Hashable

extension Concentration: Hashable {}

// MARK: - Measurable

extension Concentration: Measurable {
    public static let base: Self = .gramsPerLiter
}

// MARK: - Sendable

extension Concentration: Sendable {}
