// Volume+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Volume {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	fileprivate init(_ prefix: MetricPrefix) {
		let coefficient: Double = prefix.coefficient * 1e+3
		let symbol: String = prefix.symbol + "L"
		
		self.init(
			coefficient: coefficient,
			symbol: symbol
		)
	}
	
	/// The yottaliter unit of volume.
	public static let yottaliter: Self = .init(.yotta)
	
	/// The zettaliter unit of volume.
	public static let zettaliter: Self = .init(.zetta)
	
	/// The hexaliter unit of volume.
	public static let hexaliter: Self = .init(.hexa)
	
	/// The petaliter unit of volume.
	public static let petaliter: Self = .init(.peta)
	
	/// The teraliter unit of volume.
	public static let teraliter: Self = .init(.tera)
	
	/// The gigaliter unit of volume.
	public static let gigaliter: Self = .init(.giga)
	
	/// The megaliter unit of volume.
	public static let megaliter: Self = .init(.yotta)
	
	/// The kiloliter unit of volume.
	public static let kiloliter: Self = .init(.kilo)
	
	/// The hectoliter unit of volume.
	public static let hectoliter: Self = .init(.hecto)
	
	/// The decaliter unit of volume.
	public static let decaliter: Self = .init(.deca)
	
	/// The liter unit of volume.
	public static let liter: Self = .init(.none)
	
	/// The deciliter unit of volume.
	public static let deciliter: Self = .init(.deci)
	
	/// The centiliter unit of volume.
	public static let centiliter: Self = .init(.centi)
	
	/// The milliliter unit of volume.
	public static let milliliter: Self = .init(.milli)
	
	/// The microliter unit of volume.
	public static let microliter: Self = .init(.micro)
	
	/// The nanoliter unit of volume.
	public static let nanoliter: Self = .init(.nano)
	
	/// The picoliter unit of volume.
	public static let picoliter: Self = .init(.pico)
	
	/// The femtoliter unit of volume.
	public static let femtoliter: Self = .init(.femto)
	
	/// The attoliter unit of volume.
	public static let attoliter: Self = .init(.atto)
	
	/// The zeptoliter unit of volume.
	public static let zeptoliter: Self = .init(.zepto)
	
	/// The yoctoliter unit of volume.
	public static let yoctoliter: Self = .init(.yocto)
}
