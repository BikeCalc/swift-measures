// SurfaceDensity+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension SurfaceDensity {
	
	// MARK: - Composed Units
	
	/// The kilograms per square meter unit of surface density.
	public static let kilogramsPerSquareMeter: Self = Mass.kilogram.dividing(by: Length.meter.squared())
	
	/// The grams per square meter unit of surface density.
	public static let gramsPerSquareMeter: Self = Mass.gram.dividing(by: Length.meter.squared())
}
