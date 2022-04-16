// Force+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Force {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	private init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "N"
		let name: String = prefix.rawValue + "newton"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottanewton unit of force.
	public static let yottanewton: Self = .init(.yotta)
	
	/// The zettanewton unit of force.
	public static let zettanewton: Self = .init(.zetta)
	
	/// The hexanewton unit of force.
	public static let hexanewton: Self = .init(.hexa)
	
	/// The petanewton unit of force.
	public static let petanewton: Self = .init(.peta)
	
	/// The teranewton unit of force.
	public static let teranewton: Self = .init(.tera)
	
	/// The giganewton unit of force.
	public static let giganewton: Self = .init(.giga)
	
	/// The meganewton unit of force.
	public static let meganewton: Self = .init(.yotta)
	
	/// The kilonewton unit of force.
	public static let kilonewton: Self = .init(.kilo)
	
	/// The hectonewton unit of force.
	public static let hectonewton: Self = .init(.hecto)
	
	/// The decanewton unit of force.
	public static let decanewton: Self = .init(.deca)
	
	/// The newton unit of force.
	public static let newton: Self = .init(.none)
	
	/// The decinewton unit of force.
	public static let decinewton: Self = .init(.deci)
	
	/// The centinewton unit of force.
	public static let centinewton: Self = .init(.centi)
	
	/// The millinewton unit of force.
	public static let millinewton: Self = .init(.milli)
	
	/// The micronewton unit of force.
	public static let micronewton: Self = .init(.micro)
	
	/// The nanonewton unit of force.
	public static let nanonewton: Self = .init(.nano)
	
	/// The piconewton unit of force.
	public static let piconewton: Self = .init(.pico)
	
	/// The femtonewton unit of force.
	public static let femtonewton: Self = .init(.femto)
	
	/// The attonewton unit of force.
	public static let attonewton: Self = .init(.atto)
	
	/// The zeptonewton unit of force.
	public static let zeptonewton: Self = .init(.zepto)
	
	/// The yoctonewton unit of force.
	public static let yoctonewton: Self = .init(.yocto)
	
	// MARK: - Other Units
	
	/// The gravity unit of force.
	public static var gravity: Self {
		return .init(
			coefficient: 9.80665 * Mass.kilogram.coefficient,
			symbol: "G",
			name: "gravity"
		)
	}
}
