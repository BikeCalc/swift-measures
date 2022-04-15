// ElectricalResistance+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension ElectricalResistance {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	private init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "Ω"
		let name: String = prefix.rawValue + "ohm"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottaohm unit of electrical resistance.
	public static let yottaohm: Self = .init(.yotta)
	
	/// The zettaohm unit of electrical resistance.
	public static let zettaohm: Self = .init(.zetta)
	
	/// The hexaohm unit of electrical resistance.
	public static let hexaohm: Self = .init(.hexa)
	
	/// The petaohm unit of electrical resistance.
	public static let petaohm: Self = .init(.peta)
	
	/// The teraohm unit of electrical resistance.
	public static let teraohm: Self = .init(.tera)
	
	/// The gigaohm unit of electrical resistance.
	public static let gigaohm: Self = .init(.giga)
	
	/// The megaohm unit of electrical resistance.
	public static let megaohm: Self = .init(.yotta)
	
	/// The kiloohm unit of electrical resistance.
	public static let kiloohm: Self = .init(.kilo)
	
	/// The hectoohm unit of electrical resistance.
	public static let hectoohm: Self = .init(.hecto)
	
	/// The decaohm unit of electrical resistance.
	public static let decaohm: Self = .init(.deca)
	
	/// The ohm unit of electrical resistance.
	public static let ohm: Self = .init(.none)
	
	/// The deciohm unit of electrical resistance.
	public static let deciohm: Self = .init(.deci)
	
	/// The centiohm unit of electrical resistance.
	public static let centiohm: Self = .init(.centi)
	
	/// The milliohm unit of electrical resistance.
	public static let milliohm: Self = .init(.milli)
	
	/// The microohm unit of electrical resistance.
	public static let microohm: Self = .init(.micro)
	
	/// The nanoohm unit of electrical resistance.
	public static let nanoohm: Self = .init(.nano)
	
	/// The picoohm unit of electrical resistance.
	public static let picoohm: Self = .init(.pico)
	
	/// The femtoohm unit of electrical resistance.
	public static let femtoohm: Self = .init(.femto)
	
	/// The attoohm unit of electrical resistance.
	public static let attoohm: Self = .init(.atto)
	
	/// The zeptoohm unit of electrical resistance.
	public static let zeptoohm: Self = .init(.zepto)
	
	/// The yoctoohm unit of electrical resistance.
	public static let yoctoohm: Self = .init(.yocto)
}
