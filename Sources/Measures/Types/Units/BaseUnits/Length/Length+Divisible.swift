// Length+Divisible.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Length {
	
	// MARK: - Dividing Units
	
	/// Returns the quotient of dividing this value by the specified value.
	///
	/// - parameter time: A unit of time.
	/// - returns: A unit of acceleration.
	public func dividing(by time: Time) -> Acceleration {
		let coefficient: Double = self.coefficient * (1 / time.coefficient.raising(to: 2))
		let symbol: String = self.symbol + "/" + time.symbol + "²"
		let name: String = self.name + " " + "square" + " " + time.name
		
		return .init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// Returns the quotient of dividing this value by the specified value.
	///
	/// - parameter time: A unit of time.
	/// - returns: A unit of speed.
	public func dividing(by time: Time) -> Speed {
		let coefficient: Double =  self.coefficient * (1 / time.coefficient)
		let symbol: String = self.symbol + "/" + time.symbol
		let name: String = self.name + " " + time.name
		
		return .init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
}
