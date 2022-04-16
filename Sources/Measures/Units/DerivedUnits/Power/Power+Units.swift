// Power+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Power {
	
	// MARK: - Customary and Imperial Units
	
	/// The horsepower unit of power.
	///
	/// - warning: The result of converting this unit is not 100% accurate.
	public static let horsepower: Self = .init(
		coefficient: 7.45699872e+2,
		symbol: "hp",
		name: "horsepower"
	)
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "W"
		let name: String = prefix.name + "watt"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottawatt unit of power.
	public static let yottawatt: Self = .init(.yotta)
	
	/// The zettawatt unit of power.
	public static let zettawatt: Self = .init(.zetta)
	
	/// The hexawatt unit of power.
	public static let hexawatt: Self = .init(.hexa)
	
	/// The petawatt unit of power.
	public static let petawatt: Self = .init(.peta)
	
	/// The terawatt unit of power.
	public static let terawatt: Self = .init(.tera)
	
	/// The gigawatt unit of power.
	public static let gigawatt: Self = .init(.giga)
	
	/// The megawatt unit of power.
	public static let megawatt: Self = .init(.yotta)
	
	/// The kilowatt unit of power.
	public static let kilowatt: Self = .init(.kilo)
	
	/// The hectowatt unit of power.
	public static let hectowatt: Self = .init(.hecto)
	
	/// The decawatt unit of power.
	public static let decawatt: Self = .init(.deca)
	
	/// The watt unit of power.
	public static let watt: Self = .init(.none)
	
	/// The deciwatt unit of power.
	public static let deciwatt: Self = .init(.deci)
	
	/// The centiwatt unit of power.
	public static let centiwatt: Self = .init(.centi)
	
	/// The milliwatt unit of power.
	public static let milliwatt: Self = .init(.milli)
	
	/// The microwatt unit of power.
	public static let microwatt: Self = .init(.micro)
	
	/// The nanowatt unit of power.
	public static let nanowatt: Self = .init(.nano)
	
	/// The picowatt unit of power.
	public static let picowatt: Self = .init(.pico)
	
	/// The femtowatt unit of power.
	public static let femtowatt: Self = .init(.femto)
	
	/// The attowatt unit of power.
	public static let attowatt: Self = .init(.atto)
	
	/// The zeptowatt unit of power.
	public static let zeptowatt: Self = .init(.zepto)
	
	/// The yoctowatt unit of power.
	public static let yoctowatt: Self = .init(.yocto)
}
