// SubstanceAmount+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension SubstanceAmount {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "mol"
		let name: String = prefix.name + "mole"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottamole unit of substance amount.
	public static let yottamole: Self = .init(.yotta)
	
	/// The zettamole unit of substance amount.
	public static let zettamole: Self = .init(.zetta)
	
	/// The hexamole unit of substance amount.
	public static let hexamole: Self = .init(.hexa)
	
	/// The petamole unit of substance amount.
	public static let petamole: Self = .init(.peta)
	
	/// The teramole unit of substance amount.
	public static let teramole: Self = .init(.tera)
	
	/// The gigamole unit of substance amount.
	public static let gigamole: Self = .init(.giga)
	
	/// The megamole unit of substance amount.
	public static let megamole: Self = .init(.yotta)
	
	/// The kilomole unit of substance amount.
	public static let kilomole: Self = .init(.kilo)
	
	/// The hectomole unit of substance amount.
	public static let hectomole: Self = .init(.hecto)
	
	/// The decamole unit of substance amount.
	public static let decamole: Self = .init(.deca)
	
	/// The mole unit of substance amount.
	public static let mole: Self = .init(.none)
	
	/// The decimole unit of substance amount.
	public static let decimole: Self = .init(.deci)
	
	/// The centimole unit of substance amount.
	public static let centimole: Self = .init(.centi)
	
	/// The millimole unit of substance amount.
	public static let millimole: Self = .init(.milli)
	
	/// The micromole unit of substance amount.
	public static let micromole: Self = .init(.micro)
	
	/// The nanomole unit of substance amount.
	public static let nanomole: Self = .init(.nano)
	
	/// The picomole unit of substance amount.
	public static let picomole: Self = .init(.pico)
	
	/// The femtomole unit of substance amount.
	public static let femtomole: Self = .init(.femto)
	
	/// The attomole unit of substance amount.
	public static let attomole: Self = .init(.atto)
	
	/// The zeptomole unit of substance amount.
	public static let zeptomole: Self = .init(.zepto)
	
	/// The yoctomole unit of substance amount.
	public static let yoctomole: Self = .init(.yocto)
}
