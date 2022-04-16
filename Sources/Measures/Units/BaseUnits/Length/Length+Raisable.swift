// Length+Raisable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Length {
	
	// MARK: - Raising Units
	
	/// Returns the result of raising this value to its square.
	///
	/// - returns: A unit of area.
	public func squared() -> Area {
		let coefficient: Double = self.coefficient.raising(to: 2)
		let symbol: String = self.symbol + "²"
		let name: String = "square" + " " + self.name
		
		return .init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// Returns the result of raising this value to its cube.
	///
	/// - returns: A unit of volume.
	public func cubed() -> Volume {
		let coefficient: Double = self.coefficient.raising(to: 3)
		let symbol: String = self.symbol + "³"
		let name: String = "cubic" + " " + self.name
		
		return .init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
}
