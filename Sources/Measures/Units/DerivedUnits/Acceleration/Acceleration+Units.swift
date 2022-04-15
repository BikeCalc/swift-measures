// Acceleration+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Acceleration {
	
	// MARK: - Composed Units
	
	/// Creates a new instance with the specified length and time.
	///
	/// - parameter length: The length.
	/// - parameter time: The time.
	private init(_ length: Length, dividedBy time: Time) {
		let coefficient: Double = length.coefficient / time.coefficient.raising(to: 2)
		let symbol: String = length.symbol + "/" + time.symbol + "²"
		let name: String = length.name + " " + time.name + " " + "squared"
		
		self.init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The metre per second squared unit of acceleration.
	public static let metrePerSecondSquared: Self = .init(.metre, dividedBy: .second)
}
