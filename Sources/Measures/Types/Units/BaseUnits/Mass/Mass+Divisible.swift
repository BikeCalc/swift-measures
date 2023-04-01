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
	/// - parameter area: A unit of area.
	/// - returns: A unit of surface density.
	public func dividing(by area: Area) -> SurfaceDensity {
		let coefficient: Double = self.coefficient * (1 / area.coefficient)
		let symbol: String = self.symbol + "/" + area.symbol
		
		return .init(
			coefficient: coefficient,
			symbol: symbol
		)
	}
	
	/// Returns the quotient of dividing this value by the specified value.
	///
	/// - parameter area: A unit of substance amount.
	/// - returns: A unit of molar mass.
	public func dividing(by substanceAmount: SubstanceAmount) -> MolarMass {
		let coefficient: Double = self.coefficient * (1 / substanceAmount.coefficient)
		let symbol: String = self.symbol + "/" + substanceAmount.symbol
		
		return .init(
			coefficient: coefficient,
			symbol: symbol
		)
	}
	
	/// Returns the quotient of dividing this value by the specified value.
	///
	/// - parameter volume: A unit of volume.
	/// - returns: A unit of concentration.
	public func dividing(by volume: Volume) -> Concentration {
		let coefficient: Double = self.coefficient * (1 / volume.coefficient)
		let symbol: String = self.symbol + "/" + volume.symbol
		
		return .init(
			coefficient: coefficient,
			symbol: symbol
		)
	}
}
