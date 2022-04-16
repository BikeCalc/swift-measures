// ThermodynamicTemperature+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension ThermodynamicTemperature {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	private init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "K"
		let name: String = prefix.rawValue + "kelvin"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottakelvin unit of thermodynamic temperature.
	public static let yottakelvin: Self = .init(.yotta)
	
	/// The zettakelvin unit of thermodynamic temperature.
	public static let zettakelvin: Self = .init(.zetta)
	
	/// The hexakelvin unit of thermodynamic temperature.
	public static let hexakelvin: Self = .init(.hexa)
	
	/// The petakelvin unit of thermodynamic temperature.
	public static let petakelvin: Self = .init(.peta)
	
	/// The terakelvin unit of thermodynamic temperature.
	public static let terakelvin: Self = .init(.tera)
	
	/// The gigakelvin unit of thermodynamic temperature.
	public static let gigakelvin: Self = .init(.giga)
	
	/// The megakelvin unit of thermodynamic temperature.
	public static let megakelvin: Self = .init(.yotta)
	
	/// The kilokelvin unit of thermodynamic temperature.
	public static let kilokelvin: Self = .init(.kilo)
	
	/// The hectokelvin unit of thermodynamic temperature.
	public static let hectokelvin: Self = .init(.hecto)
	
	/// The decakelvin unit of thermodynamic temperature.
	public static let decakelvin: Self = .init(.deca)
	
	/// The kelvin unit of thermodynamic temperature.
	public static let kelvin: Self = .init(.none)
	
	/// The decikelvin unit of thermodynamic temperature.
	public static let decikelvin: Self = .init(.deci)
	
	/// The centikelvin unit of thermodynamic temperature.
	public static let centikelvin: Self = .init(.centi)
	
	/// The millikelvin unit of thermodynamic temperature.
	public static let millikelvin: Self = .init(.milli)
	
	/// The microkelvin unit of thermodynamic temperature.
	public static let microkelvin: Self = .init(.micro)
	
	/// The nanokelvin unit of thermodynamic temperature.
	public static let nanokelvin: Self = .init(.nano)
	
	/// The picokelvin unit of thermodynamic temperature.
	public static let picokelvin: Self = .init(.pico)
	
	/// The femtokelvin unit of thermodynamic temperature.
	public static let femtokelvin: Self = .init(.femto)
	
	/// The attokelvin unit of thermodynamic temperature.
	public static let attokelvin: Self = .init(.atto)
	
	/// The zeptokelvin unit of thermodynamic temperature.
	public static let zeptokelvin: Self = .init(.zepto)
	
	/// The yoctokelvin unit of thermodynamic temperature.
	public static let yoctokelvin: Self = .init(.yocto)
	
	// MARK: - Other Units
	
	/// The celsius unit of thermodynamic temperature.
	public static let celsius: Self = .init(
		coefficient: 1,
		constant: 273.15,
		symbol: "°C",
		name: "celsius"
	)
}
