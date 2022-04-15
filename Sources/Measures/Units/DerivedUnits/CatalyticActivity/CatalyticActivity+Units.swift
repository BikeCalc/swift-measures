// CatalyticActivity+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension CatalyticActivity {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	private init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "kat"
		let name: String = prefix.rawValue + "katal"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottakatal unit of catalytic activity.
	public static let yottakatal: Self = .init(.yotta)
	
	/// The zettakatal unit of catalytic activity.
	public static let zettakatal: Self = .init(.zetta)
	
	/// The hexakatal unit of catalytic activity.
	public static let hexakatal: Self = .init(.hexa)
	
	/// The petakatal unit of catalytic activity.
	public static let petakatal: Self = .init(.peta)
	
	/// The terakatal unit of catalytic activity.
	public static let terakatal: Self = .init(.tera)
	
	/// The gigakatal unit of catalytic activity.
	public static let gigakatal: Self = .init(.giga)
	
	/// The megakatal unit of catalytic activity.
	public static let megakatal: Self = .init(.yotta)
	
	/// The kilokatal unit of catalytic activity.
	public static let kilokatal: Self = .init(.kilo)
	
	/// The hectokatal unit of catalytic activity.
	public static let hectokatal: Self = .init(.hecto)
	
	/// The decakatal unit of catalytic activity.
	public static let decakatal: Self = .init(.deca)
	
	/// The katal unit of catalytic activity.
	public static let katal: Self = .init(.none)
	
	/// The decikatal unit of catalytic activity.
	public static let decikatal: Self = .init(.deci)
	
	/// The centikatal unit of catalytic activity.
	public static let centikatal: Self = .init(.centi)
	
	/// The millikatal unit of catalytic activity.
	public static let millikatal: Self = .init(.milli)
	
	/// The microkatal unit of catalytic activity.
	public static let microkatal: Self = .init(.micro)
	
	/// The nanokatal unit of catalytic activity.
	public static let nanokatal: Self = .init(.nano)
	
	/// The picokatal unit of catalytic activity.
	public static let picokatal: Self = .init(.pico)
	
	/// The femtokatal unit of catalytic activity.
	public static let femtokatal: Self = .init(.femto)
	
	/// The attokatal unit of catalytic activity.
	public static let attokatal: Self = .init(.atto)
	
	/// The zeptokatal unit of catalytic activity.
	public static let zeptokatal: Self = .init(.zepto)
	
	/// The yoctokatal unit of catalytic activity.
	public static let yoctokatal: Self = .init(.yocto)
}
