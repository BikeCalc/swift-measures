// Concentration+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Concentration {
	
	// MARK: - Composed Units
	
	/// The grams per liter unit of concentration.
	public static let gramsPerLiter: Self = Mass.gram.dividing(by: .liter)
}
