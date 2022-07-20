// ElectricCurrent+Divisible.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension ElectricCurrent {
	
	// MARK: - Dividing Units
	
	/// Returns the quotient of dividing this value by the specified value.
	///
	/// - parameter time: A unit of time.
	/// - returns: A unit of electric tension.
	public func dividing(by time: Time) -> ElectricTension {
		let coefficient: Double = self.coefficient * (1 / time.coefficient)
		let symbol: String = self.symbol + "/" + time.symbol
		
		return .init(
			coefficient: coefficient,
			symbol: symbol
		)
	}
}
