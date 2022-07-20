// LuminousIntensity.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for luminous intensity.
public struct LuminousIntensity: Measurable {
	
	// MARK: - Creating Units
	
	public init(
		coefficient: Double,
		constant: Double = 0,
		symbol: String
	) {
		self.coefficient = coefficient
		self.constant = constant
		self.symbol = symbol
	}
	
	// MARK: - Unit Properties
	
	public let coefficient: Double
	
	public let constant: Double
	
	public let symbol: String
	
	// MARK: - Base Unit
	
	public static let base: Self = .candela
}
