// MolarMass+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension MolarMass {
	
	// MARK: - Composed Units
	
	/// The kilograms per mole unit of molar mass.
	public static let kilogramsPerMole: Self = Mass.kilogram.dividing(by: SubstanceAmount.mole)
	
	/// The grams per mole unit of molar mass.
	public static let gramsPerMole: Self = Mass.gram.dividing(by: SubstanceAmount.mole)
}
