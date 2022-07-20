// Mass+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Mass {
	
	// MARK: - Astronomical Units
	
	/// The solar unit of mass.
	public static let solar: Self = .init(
		coefficient: 1.98892e+30,
		symbol: "Mo"
	)
	
	/// The jupiter unit of mass.
	public static let jupiter: Self = .init(
		coefficient: 1.898e+27,
		symbol: "Mj"
	)
	
	/// The jupiter unit of mass.
	public static let earth: Self = .init(
		coefficient: Self.pound.coefficient *  5.9742e+24,
		symbol: "Me"
	)
	
	// MARK: - Customary Units
	
	/// The short ton unit of mass.
	public static let shortTon: Self = .init(
		coefficient: Self.pound.coefficient * 2e+3,
		symbol: "sht"
	)
	
	/// The centalweight unit of mass.
	public static let centalweight: Self = .init(
		coefficient: Self.pound.coefficient * 1e+2,
		symbol: "cwt"
	)
	
	// MARK: - Customary and Imperial Units
	
	/// The long ton unit of mass.
	public static let longTon: Self = .init(
		coefficient: Self.pound.coefficient * 2.24e+3,
		symbol: "lt"
	)
	
	/// The hundredweight unit of mass.
	public static let hundredweight: Self = .init(
		coefficient: Self.pound.coefficient * 112,
		symbol: "hwt"
	)
	
	/// The slug unit of mass.
	public static let slug: Self = .init(
		coefficient: 1.45939e+1,
		symbol: "slg"
	)
	
	/// The stone unit of mass.
	public static let stone: Self = .init(
		coefficient: Self.pound.coefficient * 14,
		symbol: "st"
	)
	
	/// The blob unit of mass.
	public static let blob: Self = .init(
		coefficient: Self.slug.coefficient / 12,
		symbol: "blb"
	)
	
	/// The pound unit of mass.
	public static let pound: Self = .init(
		coefficient: 4.5359237e-1,
		symbol: "lb"
	)
	
	/// The ounce unit of mass.
	public static let ounce: Self = .init(
		coefficient: Self.pound.coefficient / 16,
		symbol: "oz"
	)
	
	/// The carat unit of mass.
	public static let dram: Self = .init(
		coefficient: Self.ounce.coefficient / 16,
		symbol: "dr"
	)
	
	/// The pennyweight unit of mass.
	public static let pennyweight: Self = .init(
		coefficient: Self.grain.coefficient * 24,
		symbol: "dwt"
	)
	
	/// The grain unit of mass.
	public static let grain: Self = .init(
		coefficient: Self.pound.coefficient / 7e+3,
		symbol: "gr"
	)
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let coefficient: Double = prefix.coefficient / 1000
		let symbol: String = prefix.symbol + "g"
		
		self.init(
			coefficient: coefficient,
			symbol: symbol
		)
	}
	
	/// The yottagram unit of mass.
	public static let yottagram: Self = .init(.yotta)
	
	/// The zettagram unit of mass.
	public static let zettagram: Self = .init(.zetta)
	
	/// The hexagram unit of mass.
	public static let hexagram: Self = .init(.hexa)
	
	/// The petagram unit of mass.
	public static let petagram: Self = .init(.peta)
	
	/// The teragram unit of mass.
	public static let teragram: Self = .init(.tera)
	
	/// The gigagram unit of mass.
	public static let gigagram: Self = .init(.giga)
	
	/// The megagram unit of mass.
	public static let megagram: Self = .init(.yotta)
	
	/// The kilogram unit of mass.
	public static let kilogram: Self = .init(.kilo)
	
	/// The hectogram unit of mass.
	public static let hectogram: Self = .init(.hecto)
	
	/// The decagram unit of mass.
	public static let decagram: Self = .init(.deca)
	
	/// The gram unit of mass.
	public static let gram: Self = .init(.none)
	
	/// The decigram unit of mass.
	public static let decigram: Self = .init(.deci)
	
	/// The centigram unit of mass.
	public static let centigram: Self = .init(.centi)
	
	/// The milligram unit of mass.
	public static let milligram: Self = .init(.milli)
	
	/// The microgram unit of mass.
	public static let microgram: Self = .init(.micro)
	
	/// The nanogram unit of mass.
	public static let nanogram: Self = .init(.nano)
	
	/// The picogram unit of mass.
	public static let picogram: Self = .init(.pico)
	
	/// The femtogram unit of mass.
	public static let femtogram: Self = .init(.femto)
	
	/// The attogram unit of mass.
	public static let attogram: Self = .init(.atto)
	
	/// The zeptogram unit of mass.
	public static let zeptogram: Self = .init(.zepto)
	
	/// The yoctogram unit of mass.
	public static let yoctogram: Self = .init(.yocto)
	
	// MARK: - Other Metric Units
	
	/// The tonne unit of mass.
	public static let tonne: Self = .init(
		coefficient: Self.megagram.coefficient,
		symbol: "t"
	)

	/// The carat unit of mass.
	public static let carat: Self = .init(
		coefficient: 2e-4,
		symbol: "ct"
	)
	
	// MARK: - Troy Units
	
	/// The troy pound unit of mass.
	public static let troyPound: Self = .init(
		coefficient: Self.troyOunce.coefficient * 12,
		symbol: "tlb"
	)
	
	/// The troy ounce unit of mass.
	public static let troyOunce: Self = .init(
		coefficient: Self.grain.coefficient * 480,
		symbol: "toz"
	)
}
