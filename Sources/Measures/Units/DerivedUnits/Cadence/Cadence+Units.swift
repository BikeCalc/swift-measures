// Cadence+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Cadence {
	/// Returns the quotient of dividing this value by the specified value.
	///
	/// - parameter volume: A unit of time.
	/// - returns: A unit of cadence.
	fileprivate static func dividing(by time: Time) -> Self {
		let coefficient: Double = Time.base.coefficient * (1 / time.coefficient)
		let symbol: String = "r" + "/" + time.symbol
		let name: String = "revolutions" + " " + time.name
		
		return .init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	// MARK: - Other Units

	/// The revolutions per second unit of cadence.
	public static let revolutionsPerSecond: Self = .dividing(by: .second)

	/// The revolutions per minute unit of cadence.
	public static let revolutionsPerMinute: Self = .dividing(by: .minute)
	
	/// The revolutions per hour unit of cadence.
	public static let revolutionsPerHour: Self = .dividing(by: .hour)
}
