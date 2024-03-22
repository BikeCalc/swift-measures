//
// Area.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for area.
public struct Area {
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
    
    // MARK: Customary Units
    
    /// The township unit of area.
    public static let township: Self = .init(
        coefficient: Length.mile.squared().coefficient * 36,
        symbol: "twp"
    )
    
    // MARK: Customary and Imperial Units
    
    /// The acre unit of area.
    public static let acre: Self = .init(
        coefficient: Length.chain.squared().coefficient * 10,
        symbol: "ac"
    )
    
    /// The rood unit of area.
    public static let rood: Self = .init(
        coefficient: Self.perch.coefficient * 40,
        symbol: "roo"
    )
    
    /// The perch unit of area.
    public static let perch: Self = Length.rod.squared()
    
    // MARK: Other Metric Units
    
    /// The hectare unit of area.
    public static let hectare: Self = .init(
        coefficient: 1e+4,
        symbol: "ha"
    )
    
    /// The decare unit of area.
    public static let decare: Self = .init(
        coefficient: 1e+3,
        symbol: "daa"
    )
    
    /// The are unit of area.
    public static let are: Self = .init(
        coefficient: 1e+2,
        symbol: "a"
    )
    
    /// The centiare unit of area.
    public static let centiare: Self = .init(
        coefficient: 1,
        symbol: "ca"
    )
}

// MARK: - Codable

extension Area: Codable {}

// MARK: - Comparable

extension Area: Comparable {}

// MARK: - Equatable

extension Area: Equatable {}

// MARK: - Hashable

extension Area: Hashable {}

// MARK: - Measurable

extension Area: Measurable {
    public static let base: Self = Length.meter.squared()
}

// MARK: - Sendable

extension Area: Sendable {}
