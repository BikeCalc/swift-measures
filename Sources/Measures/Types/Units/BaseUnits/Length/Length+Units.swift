// Length+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Length {
	
	// MARK: - Astronomical Units
	
	/// The parsec unit of length.
	public static let parsec: Self = .init(
		coefficient: 3.086e+16,
		symbol: "pc",
		name: "parsec"
	)
	
	/// The light year unit of length.
	public static let lightYear: Self = .init(
		coefficient: 9.4607e+15,
		symbol: "ly",
		name: "light year"
	)
	
	/// The astronomical unit unit of length.
	public static let astronomicalUnit: Self = .init(
		coefficient: 1.496e+11,
		symbol: "au",
		name: "astronomical unit"
	)
	
	// MARK: - Customary and Imperial Units
	
	/// The nautical league unit of length.
	public static let nauticalLeague: Self = .init(
		coefficient: Self.nauticalMile.coefficient * 3,
		symbol: "nlea",
		name: "nautical league"
	)
	
	/// The league unit of length.
	public static let league: Self = .init(
		coefficient: Self.mile.coefficient * 3,
		symbol: "lea",
		name: "league"
	)
	
	/// The nautical mile unit of length.
	public static let nauticalMile: Self = .init(
		coefficient: 1.852e+3,
		symbol: "nmi",
		name: "nautical mile"
	)
	
	/// The mile unit of length.
	public static let mile: Self = .init(
		coefficient: 1.609344e+3,
		symbol: "mi",
		name: "mile"
	)
	
	/// The cable unit of length.
	public static let cable: Self = .init(
		coefficient: Self.nauticalMile.coefficient / 10,
		symbol: "cb",
		name: "cable"
	)
	
	/// The furlong unit of length.
	public static let furlong: Self = .init(
		coefficient: 2.01168e+2, symbol: "fur",
		name: "furlong"
	)
	
	/// The chain unit of length.
	public static let chain: Self = .init(
		coefficient: Self.inch.coefficient * 792,
		symbol: "ch",
		name: "chain"
	)
	
	/// The rod unit of length.
	public static let rod: Self = .init(
		coefficient: Self.inch.coefficient * 198,
		symbol: "rd",
		name: "rod"
	)
	
	/// The fathom unit of length.
	public static let fathom: Self = .init(
		coefficient: Self.inch.coefficient * 72,
		symbol: "ftm",
		name: "fathom"
	)
	
	/// The yard unit of length.
	public static let yard: Self = .init(
		coefficient: Self.inch.coefficient * 36,
		symbol: "yd",
		name: "yard"
	)
	
	/// The foot unit of length.
	public static let foot: Self = .init(
		coefficient: Self.inch.coefficient * 12,
		symbol: "ft",
		name: "foot"
	)
	
	/// The link unit of length.
	public static let link: Self = .init(
		coefficient: 2.01168,
		symbol: "li",
		name: "link"
	)
	
	/// The inch unit of length.
	public static let inch: Self = .init(
		coefficient: 2.54e-2,
		symbol: "in",
		name: "inch"
	)
	
	/// The pica unit of length.
	public static let pica: Self = .init(
		coefficient: Self.inch.coefficient / 6,
		symbol: "Pc",
		name: "pica"
	)
	
	/// The point unit of length.
	public static let point: Self = .init(
		coefficient: Self.inch.coefficient / 72,
		symbol: "Pt",
		name: "point"
	)
	
	/// The thou unit of length.
	public static let thou: Self = .init(
		coefficient: Self.inch.coefficient / 1_000,
		symbol: "th",
		name: "thou"
	)
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "m"
		let name: String = prefix.name + "metre"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottametre unit of length.
	public static let yottametre: Self = .init(.yotta)
	
	/// The zettametre unit of length.
	public static let zettametre: Self = .init(.zetta)
	
	/// The hexametre unit of length.
	public static let hexametre: Self = .init(.hexa)
	
	/// The petametre unit of length.
	public static let petametre: Self = .init(.peta)
	
	/// The terametre unit of length.
	public static let terametre: Self = .init(.tera)
	
	/// The gigametre unit of length.
	public static let gigametre: Self = .init(.giga)
	
	/// The megametre unit of length.
	public static let megametre: Self = .init(.yotta)
	
	/// The kilometre unit of length.
	public static let kilometre: Self = .init(.kilo)
	
	/// The hectometre unit of length.
	public static let hectometre: Self = .init(.hecto)
	
	/// The decametre unit of length.
	public static let decametre: Self = .init(.deca)
	
	/// The metre unit of length.
	public static let metre: Self = .init(.none)
	
	/// The decimetre unit of length.
	public static let decimetre: Self = .init(.deci)
	
	/// The centimetre unit of length.
	public static let centimetre: Self = .init(.centi)
	
	/// The millimetre unit of length.
	public static let millimetre: Self = .init(.milli)
	
	/// The micrometre unit of length.
	public static let micrometre: Self = .init(.micro)
	
	/// The nanometre unit of length.
	public static let nanometre: Self = .init(.nano)
	
	/// The picometre unit of length.
	public static let picometre: Self = .init(.pico)
	
	/// The femtometre unit of length.
	public static let femtometre: Self = .init(.femto)
	
	/// The attometre unit of length.
	public static let attometre: Self = .init(.atto)
	
	/// The zeptometre unit of length.
	public static let zeptometre: Self = .init(.zepto)
	
	/// The yoctometre unit of length.
	public static let yoctometre: Self = .init(.yocto)
}
