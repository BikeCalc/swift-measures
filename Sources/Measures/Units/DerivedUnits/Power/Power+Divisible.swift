// Power+Divisible.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Power {
	
	// MARK: - Dividing Units
	
	/// Returns the quotient of dividing this value by the specified value.
	///
	/// - parameter time: A unit of time.
	/// - returns: A unit of energy.
	public func dividing(by time: Time) -> Energy {
		let coefficient: Double = self.coefficient * (1 / time.coefficient)
		let symbol: String = self.symbol + "/" + time.symbol
		let name: String = self.name + " " + time.name
		
		return .init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
}
