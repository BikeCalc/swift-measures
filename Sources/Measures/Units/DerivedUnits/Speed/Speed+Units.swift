// Speed+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Speed {
	
	// MARK: - Composed Units
	
	/// Creates a new instance with the specified length and time.
	///
	/// - parameter length: The length.
	/// - parameter time: The time.
	private init(_ length: Length, dividedBy time: Time) {
		let coefficient: Double = length.coefficient / time.coefficient
		let symbol: String = length.symbol + "/" + time.symbol
		let name: String = length.name + " " + time.name
		
		self.init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The knot unit of speed.
	public static let knot: Self = .init(.nauticalMile, dividedBy: .hour)

	/// The mile per hour unit of speed.
	public static let milePerHour: Self = .init(.mile, dividedBy: .hour)

	/// The kilometre per hour unit of speed.
	public static let kilometrePerHour: Self = .init(.kilometre, dividedBy: .hour)

	/// The metre per second unit of speed.
	public static let metrePerSecond: Self = .init(.metre, dividedBy: .second)
}
