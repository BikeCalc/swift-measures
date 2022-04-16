// Mass+Divisible.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Mass {
	
	// MARK: - Dividing Units
	
	/// Returns the quotient of dividing this value by the specified value.
	///
	/// - parameter volume: A unit of volume.
	/// - returns: A unit of concentration.
	public func dividing(by volume: Volume) -> Concentration {
		let coefficient: Double = self.coefficient / volume.coefficient
		let symbol: String = self.symbol + "/" + volume.symbol
		let name: String = self.name + " " + volume.name
		
		return .init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
}
