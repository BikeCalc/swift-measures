// Speed+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Speed {
	
	// MARK: - Customary and Imperial Units

	/// The miles per hour unit of speed.
	public static let milesPerHour: Self = Length.mile.dividing(by: .hour)
	
	// MARK: - Metric Units

	/// The kilometers per hour unit of speed.
	public static let kilometersPerHour: Self = Length.kilometer.dividing(by: .hour)

	/// The meter per second unit of speed.
	public static let metersPerSecond: Self = Length.meter.dividing(by: .second)
	
	// MARK: - Other Units
	
	/// The knot unit of speed.
	public static let knot: Self = Length.nauticalMile.dividing(by: .hour)
}
