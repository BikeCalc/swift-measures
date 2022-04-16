// Force+Divisible.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Force {
	
	// MARK: - Dividing Units
	
	/// Returns the quotient of dividing this value by the specified value.
	///
	/// - parameter area: A unit of area.
	/// - returns: A unit of pressure.
	public func dividing(by area: Area) -> Pressure {
		let coefficient: Double = self.coefficient / area.coefficient
		let symbol: String = self.symbol + "/" + area.symbol
		let name: String = self.name + " " + area.name
		
		return .init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
}
