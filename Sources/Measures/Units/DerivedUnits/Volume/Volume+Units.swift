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
		let name: String = prefix.name + "litre"
		
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
}
