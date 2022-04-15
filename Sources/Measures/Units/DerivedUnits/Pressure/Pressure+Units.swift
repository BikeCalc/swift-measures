// Pressure+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Pressure {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	private init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "Pa"
		let name: String = prefix.rawValue + "pascal"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottapascal unit of pressure.
	public static let yottapascal: Self = .init(.yotta)
	
	/// The zettapascal unit of pressure.
	public static let zettapascal: Self = .init(.zetta)
	
	/// The hexapascal unit of pressure.
	public static let hexapascal: Self = .init(.hexa)
	
	/// The petapascal unit of pressure.
	public static let petapascal: Self = .init(.peta)
	
	/// The terapascal unit of pressure.
	public static let terapascal: Self = .init(.tera)
	
	/// The gigapascal unit of pressure.
	public static let gigapascal: Self = .init(.giga)
	
	/// The megapascal unit of pressure.
	public static let megapascal: Self = .init(.yotta)
	
	/// The kilopascal unit of pressure.
	public static let kilopascal: Self = .init(.kilo)
	
	/// The hectopascal unit of pressure.
	public static let hectopascal: Self = .init(.hecto)
	
	/// The decapascal unit of pressure.
	public static let decapascal: Self = .init(.deca)
	
	/// The pascal unit of pressure.
	public static let pascal: Self = .init(.none)
	
	/// The decipascal unit of pressure.
	public static let decipascal: Self = .init(.deci)
	
	/// The centipascal unit of pressure.
	public static let centipascal: Self = .init(.centi)
	
	/// The millipascal unit of pressure.
	public static let millipascal: Self = .init(.milli)
	
	/// The micropascal unit of pressure.
	public static let micropascal: Self = .init(.micro)
	
	/// The nanopascal unit of pressure.
	public static let nanopascal: Self = .init(.nano)
	
	/// The picopascal unit of pressure.
	public static let picopascal: Self = .init(.pico)
	
	/// The femtopascal unit of pressure.
	public static let femtopascal: Self = .init(.femto)
	
	/// The attopascal unit of pressure.
	public static let attopascal: Self = .init(.atto)
	
	/// The zeptopascal unit of pressure.
	public static let zeptopascal: Self = .init(.zepto)
	
	/// The yoctopascal unit of pressure.
	public static let yoctopascal: Self = .init(.yocto)
	
	// MARK: - Other Metric Units
	
	/// The bar unit of energy.
	public static let bar: Self = .init(
		coefficient: 1e+5,
		symbol: "bar",
		name: "bar"
	)
	
	/// The millibar unit of energy.
	public static let millibar: Self = .init(
		coefficient: 1e+2,
		symbol: "mbar",
		name: "millibar"
	)
	
	// MARK: - Other Units
	
	/// The atmosphere unit of energy.
	public static let atmosphere: Self = .init(
		coefficient: 1.01325e+5,
		symbol: "atm",
		name: "atmosphere"
	)
	
	/// The bar unit of energy.
	public static let torr: Self = .init(
		coefficient: Self.atmosphere.coefficient / 760,
		symbol: "Torr",
		name: "torr"
	)
	
	/// The millitorr unit of energy.
	public static let millitorr: Self = .init(
		coefficient: Self.torr.coefficient * 1e-3,
		symbol: "mTorr",
		name: "millitorr"
	)
}
