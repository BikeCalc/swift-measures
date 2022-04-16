// ElectricCurrent+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension ElectricCurrent {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "A"
		let name: String = prefix.name + "ampere"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottaampere unit of electric current.
	public static let yottaampere: Self = .init(.yotta)
	
	/// The zettaampere unit of electric current.
	public static let zettaampere: Self = .init(.zetta)
	
	/// The hexaampere unit of electric current.
	public static let hexaampere: Self = .init(.hexa)
	
	/// The petaampere unit of electric current.
	public static let petaampere: Self = .init(.peta)
	
	/// The teraampere unit of electric current.
	public static let teraampere: Self = .init(.tera)
	
	/// The gigaampere unit of electric current.
	public static let gigaampere: Self = .init(.giga)
	
	/// The megaampere unit of electric current.
	public static let megaampere: Self = .init(.yotta)
	
	/// The kiloampere unit of electric current.
	public static let kiloampere: Self = .init(.kilo)
	
	/// The hectoampere unit of electric current.
	public static let hectoampere: Self = .init(.hecto)
	
	/// The decaampere unit of electric current.
	public static let decaampere: Self = .init(.deca)
	
	/// The ampere unit of electric current.
	public static let ampere: Self = .init(.none)
	
	/// The deciampere unit of electric current.
	public static let deciampere: Self = .init(.deci)
	
	/// The centiampere unit of electric current.
	public static let centiampere: Self = .init(.centi)
	
	/// The milliampere unit of electric current.
	public static let milliampere: Self = .init(.milli)
	
	/// The microampere unit of electric current.
	public static let microampere: Self = .init(.micro)
	
	/// The nanoampere unit of electric current.
	public static let nanoampere: Self = .init(.nano)
	
	/// The picoampere unit of electric current.
	public static let picoampere: Self = .init(.pico)
	
	/// The femtoampere unit of electric current.
	public static let femtoampere: Self = .init(.femto)
	
	/// The attoampere unit of electric current.
	public static let attoampere: Self = .init(.atto)
	
	/// The zeptoampere unit of electric current.
	public static let zeptoampere: Self = .init(.zepto)
	
	/// The yoctoampere unit of electric current.
	public static let yoctoampere: Self = .init(.yocto)
}
