// Time+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Time {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "s"
		let name: String = prefix.name + "second"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottasecond unit of time.
	public static let yottasecond: Self = .init(.yotta)
	
	/// The zettasecond unit of time.
	public static let zettasecond: Self = .init(.zetta)
	
	/// The hexasecond unit of time.
	public static let hexasecond: Self = .init(.hexa)
	
	/// The petasecond unit of time.
	public static let petasecond: Self = .init(.peta)
	
	/// The terasecond unit of time.
	public static let terasecond: Self = .init(.tera)
	
	/// The gigasecond unit of time.
	public static let gigasecond: Self = .init(.giga)
	
	/// The megasecond unit of time.
	public static let megasecond: Self = .init(.yotta)
	
	/// The kilosecond unit of time.
	public static let kilosecond: Self = .init(.kilo)
	
	/// The hectosecond unit of time.
	public static let hectosecond: Self = .init(.hecto)
	
	/// The decasecond unit of time.
	public static let decasecond: Self = .init(.deca)
	
	/// The second unit of time.
	public static let second: Self = .init(.none)
	
	/// The decisecond unit of time.
	public static let decisecond: Self = .init(.deci)
	
	/// The centisecond unit of time.
	public static let centisecond: Self = .init(.centi)
	
	/// The millisecond unit of time.
	public static let millisecond: Self = .init(.milli)
	
	/// The microsecond unit of time.
	public static let microsecond: Self = .init(.micro)
	
	/// The nanosecond unit of time.
	public static let nanosecond: Self = .init(.nano)
	
	/// The picosecond unit of time.
	public static let picosecond: Self = .init(.pico)
	
	/// The femtosecond unit of time.
	public static let femtosecond: Self = .init(.femto)
	
	/// The attosecond unit of time.
	public static let attosecond: Self = .init(.atto)
	
	/// The zeptosecond unit of time.
	public static let zeptosecond: Self = .init(.zepto)
	
	/// The yoctosecond unit of time.
	public static let yoctosecond: Self = .init(.yocto)
	
	// MARK: - Other Units
	
	/// The millenium unit of time.
	public static let millenium: Self = .init(
		coefficient: 3.1556952e+10,
		symbol: "mil",
		name: "millenium"
	)
	
	/// The century unit of time.
	public static let century: Self = .init(
		coefficient: 3.1556952e+9,
		symbol: "cent",
		name: "century"
	)
	
	/// The decade unit of time.
	public static let decade: Self = .init(
		coefficient: 3.1556952e+8,
		symbol: "dec",
		name: "decade"
	)
	
	/// The year unit of time.
	public static let year: Self = .init(
		coefficient: 3.1556952e+7,
		symbol: "yr",
		name: "year"
	)
	
	/// The quarter unit of time.
	public static let quarter: Self = .init(
		coefficient: 7.889238e+6,
		symbol: "qr",
		name: "quarter"
	)
	
	/// The month unit of time.
	public static let month: Self = .init(
		coefficient: 2.629746e+6,
		symbol: "mo",
		name: "month"
	)
	
	/// The week unit of time.
	public static let week: Self = .init(
		coefficient: 6.04800e+5,
		symbol: "wk",
		name: "week"
	)
	
	/// The day unit of time.
	public static let day: Self = .init(
		coefficient: 8.64e+4,
		symbol: "day",
		name: "day"
	)
	
	/// The hour unit of time.
	public static let hour: Self = .init(
		coefficient: 3.6e+3,
		symbol: "h",
		name: "hour"
	)
	
	/// The minute unit of time.
	public static let minute: Self = .init(
		coefficient: 6e+1,
		symbol: "min",
		name: "minute"
	)
}
