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
		
		return .init(
			coefficient: coefficient,
			symbol: symbol
		)
	}
	
	/// Returns the result of raising this value to its cube.
	///
	/// - returns: A unit of volume.
	public func cubed() -> Volume {
		let coefficient: Double = self.coefficient.raising(to: 3)
		let symbol: String = self.symbol + "³"
		
		return .init(
			coefficient: coefficient,
			symbol: symbol
		)
	}
}
