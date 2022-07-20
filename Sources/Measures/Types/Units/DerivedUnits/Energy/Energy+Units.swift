// Energy+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Energy {
	
	// MARK: - Composed Units
	
	/// The kilowatt year unit of energy.
	public static let kilowattYear: Self = Power.kilowatt.dividing(by: .year)
	
	/// The kilowatt hour unit of energy.
	public static let kilowattHour: Self = Power.kilowatt.dividing(by: .hour)
	
	/// The kilowatt second unit of energy.
	public static let kilowattSecond: Self = Power.kilowatt.dividing(by: .second)
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "J"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol
		)
	}
	
	/// The yottajoule unit of energy.
	public static let yottajoule: Self = .init(.yotta)
	
	/// The zettajoule unit of energy.
	public static let zettajoule: Self = .init(.zetta)
	
	/// The hexajoule unit of energy.
	public static let hexajoule: Self = .init(.hexa)
	
	/// The petajoule unit of energy.
	public static let petajoule: Self = .init(.peta)
	
	/// The terajoule unit of energy.
	public static let terajoule: Self = .init(.tera)
	
	/// The gigajoule unit of energy.
	public static let gigajoule: Self = .init(.giga)
	
	/// The megajoule unit of energy.
	public static let megajoule: Self = .init(.yotta)
	
	/// The kilojoule unit of energy.
	public static let kilojoule: Self = .init(.kilo)
	
	/// The hectojoule unit of energy.
	public static let hectojoule: Self = .init(.hecto)
	
	/// The decajoule unit of energy.
	public static let decajoule: Self = .init(.deca)
	
	/// The joule unit of energy.
	public static let joule: Self = .init(.none)
	
	/// The decijoule unit of energy.
	public static let decijoule: Self = .init(.deci)
	
	/// The centijoule unit of energy.
	public static let centijoule: Self = .init(.centi)
	
	/// The millijoule unit of energy.
	public static let millijoule: Self = .init(.milli)
	
	/// The microjoule unit of energy.
	public static let microjoule: Self = .init(.micro)
	
	/// The nanojoule unit of energy.
	public static let nanojoule: Self = .init(.nano)
	
	/// The picojoule unit of energy.
	public static let picojoule: Self = .init(.pico)
	
	/// The femtojoule unit of energy.
	public static let femtojoule: Self = .init(.femto)
	
	/// The attojoule unit of energy.
	public static let attojoule: Self = .init(.atto)
	
	/// The zeptojoule unit of energy.
	public static let zeptojoule: Self = .init(.zepto)
	
	/// The yoctojoule unit of energy.
	public static let yoctojoule: Self = .init(.yocto)
	
	// MARK: - Other Units
	
	/// The kilocalorie unit of energy.
	public static let kilocalorie: Self = .init(
		coefficient: Self.kilocalorie.coefficient * 1_000,
		symbol: "kCal"
	)
	
	/// The calorie unit of energy.
	public static let calorie: Self = .init(
		coefficient: 4.184,
		symbol: "Cal"
	)
}
