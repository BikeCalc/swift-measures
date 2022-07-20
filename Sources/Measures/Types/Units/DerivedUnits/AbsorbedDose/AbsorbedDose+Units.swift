// AbsorbedDose+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension AbsorbedDose {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "Gy"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol
		)
	}
	
	/// The yottagray unit of absorbed dose.
	public static let yottagray: Self = .init(.yotta)
	
	/// The zettagray unit of absorbed dose.
	public static let zettagray: Self = .init(.zetta)
	
	/// The hexagray unit of absorbed dose.
	public static let hexagray: Self = .init(.hexa)
	
	/// The petagray unit of absorbed dose.
	public static let petagray: Self = .init(.peta)
	
	/// The teragray unit of absorbed dose.
	public static let teragray: Self = .init(.tera)
	
	/// The gigagray unit of absorbed dose.
	public static let gigagray: Self = .init(.giga)
	
	/// The megagray unit of absorbed dose.
	public static let megagray: Self = .init(.yotta)
	
	/// The kilogray unit of absorbed dose.
	public static let kilogray: Self = .init(.kilo)
	
	/// The hectogray unit of absorbed dose.
	public static let hectogray: Self = .init(.hecto)
	
	/// The decagray unit of absorbed dose.
	public static let decagray: Self = .init(.deca)
	
	/// The gray unit of absorbed dose.
	public static let gray: Self = .init(.none)
	
	/// The decigray unit of absorbed dose.
	public static let decigray: Self = .init(.deci)
	
	/// The centigray unit of absorbed dose.
	public static let centigray: Self = .init(.centi)
	
	/// The milligray unit of absorbed dose.
	public static let milligray: Self = .init(.milli)
	
	/// The microgray unit of absorbed dose.
	public static let microgray: Self = .init(.micro)
	
	/// The nanogray unit of absorbed dose.
	public static let nanogray: Self = .init(.nano)
	
	/// The picogray unit of absorbed dose.
	public static let picogray: Self = .init(.pico)
	
	/// The femtogray unit of absorbed dose.
	public static let femtogray: Self = .init(.femto)
	
	/// The attogray unit of absorbed dose.
	public static let attogray: Self = .init(.atto)
	
	/// The zeptogray unit of absorbed dose.
	public static let zeptogray: Self = .init(.zepto)
	
	/// The yoctogray unit of absorbed dose.
	public static let yoctogray: Self = .init(.yocto)
}
