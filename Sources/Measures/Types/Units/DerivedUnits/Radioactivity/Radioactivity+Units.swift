// Radioactivity+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Radioactivity {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "Bq"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol
		)
	}
	
	/// The yottabecquerel unit of radioactivity.
	public static let yottabecquerel: Self = .init(.yotta)
	
	/// The zettabecquerel unit of radioactivity.
	public static let zettabecquerel: Self = .init(.zetta)
	
	/// The hexabecquerel unit of radioactivity.
	public static let hexabecquerel: Self = .init(.hexa)
	
	/// The petabecquerel unit of radioactivity.
	public static let petabecquerel: Self = .init(.peta)
	
	/// The terabecquerel unit of radioactivity.
	public static let terabecquerel: Self = .init(.tera)
	
	/// The gigabecquerel unit of radioactivity.
	public static let gigabecquerel: Self = .init(.giga)
	
	/// The megabecquerel unit of radioactivity.
	public static let megabecquerel: Self = .init(.yotta)
	
	/// The kilobecquerel unit of radioactivity.
	public static let kilobecquerel: Self = .init(.kilo)
	
	/// The hectobecquerel unit of radioactivity.
	public static let hectobecquerel: Self = .init(.hecto)
	
	/// The decabecquerel unit of radioactivity.
	public static let decabecquerel: Self = .init(.deca)
	
	/// The becquerel unit of radioactivity.
	public static let becquerel: Self = .init(.none)
	
	/// The decibecquerel unit of radioactivity.
	public static let decibecquerel: Self = .init(.deci)
	
	/// The centibecquerel unit of radioactivity.
	public static let centibecquerel: Self = .init(.centi)
	
	/// The millibecquerel unit of radioactivity.
	public static let millibecquerel: Self = .init(.milli)
	
	/// The microbecquerel unit of radioactivity.
	public static let microbecquerel: Self = .init(.micro)
	
	/// The nanobecquerel unit of radioactivity.
	public static let nanobecquerel: Self = .init(.nano)
	
	/// The picobecquerel unit of radioactivity.
	public static let picobecquerel: Self = .init(.pico)
	
	/// The femtobecquerel unit of radioactivity.
	public static let femtobecquerel: Self = .init(.femto)
	
	/// The attobecquerel unit of radioactivity.
	public static let attobecquerel: Self = .init(.atto)
	
	/// The zeptobecquerel unit of radioactivity.
	public static let zeptobecquerel: Self = .init(.zepto)
	
	/// The yoctobecquerel unit of radioactivity.
	public static let yoctobecquerel: Self = .init(.yocto)
}
