// Concentration+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Concentration {
	
	// MARK: - Composed Units
	
	/// Creates a new instance with the specified mass and volume.
	///
	/// - parameter mass: The mass.
	/// - parameter volume: The volume.
	private init(_ mass: Mass, dividedBy volume: Volume) {
		let coefficient: Double = mass.coefficient / volume.coefficient
		let symbol: String = mass.symbol + "/" + volume.symbol
		let name: String = mass.name + " " + volume.name
		
		self.init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The gram per litre unit of concentration.
	public static let gramPerLitre: Self = .init(.gram, dividedBy: .litre)
}
