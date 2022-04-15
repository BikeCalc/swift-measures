// Volume+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Volume {
	
	// MARK: - Customary and Imperial Units

	// TODO: add units
	/// The bushel unit of volume.
//	public static let bushel .init(coefficient: 3.6368719713-2, symbol: "bus")
	
	/// The quart unit of volume.
//	public static let quart .init(coefficient: 1.13652249e-3, symbol: "qt")
	
	/// The gallon unit of volume.
//	public static let gallon .init(coefficient: 4.54608996e-3, symbol: "gal")
	
	/// The peck unit of volume.
//	public static let peck .init(coefficient: 9.09217992e-3, symbol: "pec")
	
	/// The gill unit of volume.
//	public static let gill .init(coefficient: 1.4206531e-4, symbol: "gi")
	
	/// The pint unit of volume.
//	public static let pint .init(coefficient: 1.4206531e-4, symbol: "pt")
	
	/// The fluidOunce unit of volume.
//	public static let fluidOunce .init(coefficient: 2.841306e-5, symbol: "floz")
	
	/// The fluidScruple unit of volume.
//	public static let fluidOunce .init(coefficient: 1.18387e-6, symbol: "fls")
	
	/// The cup unit of volume.
//	public static let cup .init(coefficient: 1 / (240 / 1e-6), symbol: "fldr")
	
	/// The tablespoon unit of volume.
//	public static let tablespoon .init(coefficient: 1 / (15 / 1e-6), symbol: "fldr")
	
	/// The desertspoon unit of volume.
//	public static let desertspoon .init(coefficient: 1 / (10 / 1e-6), symbol: "fldr")
	
	/// The teaspoon unit of volume.
//	public static let teaspoon .init(coefficient: 1 / (5 / 1e-6), symbol: "fldr")
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	private init(_ prefix: MetricPrefix) {
		let coefficient: Double = prefix.coefficient * 1e+3
		let symbol: String = prefix.symbol + "L"
		let name: String = prefix.rawValue + "litre"
		
		self.init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottalitre unit of volume.
	public static let yottalitre: Self = .init(.yotta)
	
	/// The zettalitre unit of volume.
	public static let zettalitre: Self = .init(.zetta)
	
	/// The hexalitre unit of volume.
	public static let hexalitre: Self = .init(.hexa)
	
	/// The petalitre unit of volume.
	public static let petalitre: Self = .init(.peta)
	
	/// The teralitre unit of volume.
	public static let teralitre: Self = .init(.tera)
	
	/// The gigalitre unit of volume.
	public static let gigalitre: Self = .init(.giga)
	
	/// The megalitre unit of volume.
	public static let megalitre: Self = .init(.yotta)
	
	/// The kilolitre unit of volume.
	public static let kilolitre: Self = .init(.kilo)
	
	/// The hectolitre unit of volume.
	public static let hectolitre: Self = .init(.hecto)
	
	/// The decalitre unit of volume.
	public static let decalitre: Self = .init(.deca)
	
	/// The litre unit of volume.
	public static let litre: Self = .init(.none)
	
	/// The decilitre unit of volume.
	public static let decilitre: Self = .init(.deci)
	
	/// The centilitre unit of volume.
	public static let centilitre: Self = .init(.centi)
	
	/// The millilitre unit of volume.
	public static let millilitre: Self = .init(.milli)
	
	/// The microlitre unit of volume.
	public static let microlitre: Self = .init(.micro)
	
	/// The nanolitre unit of volume.
	public static let nanolitre: Self = .init(.nano)
	
	/// The picolitre unit of volume.
	public static let picolitre: Self = .init(.pico)
	
	/// The femtolitre unit of volume.
	public static let femtolitre: Self = .init(.femto)
	
	/// The attolitre unit of volume.
	public static let attolitre: Self = .init(.atto)
	
	/// The zeptolitre unit of volume.
	public static let zeptolitre: Self = .init(.zepto)
	
	/// The yoctolitre unit of volume.
	public static let yoctolitre: Self = .init(.yocto)
	
	// MARK: - Raised Units
	
	/// Creates a new instance with the specified cubed length.
	///
	/// - parameter length: The length.
	public init(cubic length: Length) {
		let coefficient: Double = length.coefficient.raising(to: 3)
		let symbol: String = length.symbol + "³"
		let name: String = "cubic" + " " + length.name
		
		self.init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
}
