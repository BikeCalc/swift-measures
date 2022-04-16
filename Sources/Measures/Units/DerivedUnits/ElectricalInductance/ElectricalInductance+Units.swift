// ElectricalInductance+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension ElectricalInductance {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "H"
		let name: String = prefix.name + "henry"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottahenry unit of electrical inductance.
	public static let yottahenry: Self = .init(.yotta)
	
	/// The zettahenry unit of electrical inductance.
	public static let zettahenry: Self = .init(.zetta)
	
	/// The hexahenry unit of electrical inductance.
	public static let hexahenry: Self = .init(.hexa)
	
	/// The petahenry unit of electrical inductance.
	public static let petahenry: Self = .init(.peta)
	
	/// The terahenry unit of electrical inductance.
	public static let terahenry: Self = .init(.tera)
	
	/// The gigahenry unit of electrical inductance.
	public static let gigahenry: Self = .init(.giga)
	
	/// The megahenry unit of electrical inductance.
	public static let megahenry: Self = .init(.yotta)
	
	/// The kilohenry unit of electrical inductance.
	public static let kilohenry: Self = .init(.kilo)
	
	/// The hectohenry unit of electrical inductance.
	public static let hectohenry: Self = .init(.hecto)
	
	/// The decahenry unit of electrical inductance.
	public static let decahenry: Self = .init(.deca)
	
	/// The henry unit of electrical inductance.
	public static let henry: Self = .init(.none)
	
	/// The decihenry unit of electrical inductance.
	public static let decihenry: Self = .init(.deci)
	
	/// The centihenry unit of electrical inductance.
	public static let centihenry: Self = .init(.centi)
	
	/// The millihenry unit of electrical inductance.
	public static let millihenry: Self = .init(.milli)
	
	/// The microhenry unit of electrical inductance.
	public static let microhenry: Self = .init(.micro)
	
	/// The nanohenry unit of electrical inductance.
	public static let nanohenry: Self = .init(.nano)
	
	/// The picohenry unit of electrical inductance.
	public static let picohenry: Self = .init(.pico)
	
	/// The femtohenry unit of electrical inductance.
	public static let femtohenry: Self = .init(.femto)
	
	/// The attohenry unit of electrical inductance.
	public static let attohenry: Self = .init(.atto)
	
	/// The zeptohenry unit of electrical inductance.
	public static let zeptohenry: Self = .init(.zepto)
	
	/// The yoctohenry unit of electrical inductance.
	public static let yoctohenry: Self = .init(.yocto)
}
