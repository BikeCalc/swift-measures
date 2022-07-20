// EquivalentDose+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension EquivalentDose {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "Sv"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol
		)
	}
	
	/// The yottasievert unit of equivalent dose.
	public static let yottasievert: Self = .init(.yotta)
	
	/// The zettasievert unit of equivalent dose.
	public static let zettasievert: Self = .init(.zetta)
	
	/// The hexasievert unit of equivalent dose.
	public static let hexasievert: Self = .init(.hexa)
	
	/// The petasievert unit of equivalent dose.
	public static let petasievert: Self = .init(.peta)
	
	/// The terasievert unit of equivalent dose.
	public static let terasievert: Self = .init(.tera)
	
	/// The gigasievert unit of equivalent dose.
	public static let gigasievert: Self = .init(.giga)
	
	/// The megasievert unit of equivalent dose.
	public static let megasievert: Self = .init(.yotta)
	
	/// The kilosievert unit of equivalent dose.
	public static let kilosievert: Self = .init(.kilo)
	
	/// The hectosievert unit of equivalent dose.
	public static let hectosievert: Self = .init(.hecto)
	
	/// The decasievert unit of equivalent dose.
	public static let decasievert: Self = .init(.deca)
	
	/// The sievert unit of equivalent dose.
	public static let sievert: Self = .init(.none)
	
	/// The decisievert unit of equivalent dose.
	public static let decisievert: Self = .init(.deci)
	
	/// The centisievert unit of equivalent dose.
	public static let centisievert: Self = .init(.centi)
	
	/// The millisievert unit of equivalent dose.
	public static let millisievert: Self = .init(.milli)
	
	/// The microsievert unit of equivalent dose.
	public static let microsievert: Self = .init(.micro)
	
	/// The nanosievert unit of equivalent dose.
	public static let nanosievert: Self = .init(.nano)
	
	/// The picosievert unit of equivalent dose.
	public static let picosievert: Self = .init(.pico)
	
	/// The femtosievert unit of equivalent dose.
	public static let femtosievert: Self = .init(.femto)
	
	/// The attosievert unit of equivalent dose.
	public static let attosievert: Self = .init(.atto)
	
	/// The zeptosievert unit of equivalent dose.
	public static let zeptosievert: Self = .init(.zepto)
	
	/// The yoctosievert unit of equivalent dose.
	public static let yoctosievert: Self = .init(.yocto)
}
