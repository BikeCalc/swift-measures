// Area+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Area {
	
	// MARK: - Customary Units
	
	/// The township unit of area.
	public static let township: Self = .init(
		coefficient: Self.init(square: .mile).coefficient * 36,
		symbol: "twp",
		name: "township"
	)
	
	// MARK: - Customary and Imperial Units
	
	/// The acre unit of area.
	public static let acre: Self = .init(
		coefficient: Self.init(square: .chain).coefficient * 10,
		symbol: "ac",
		name: "acre"
	)
	
	/// The rood unit of area.
	public static let rood: Self = .init(
		coefficient: Self.perch.coefficient * 40,
		symbol: "roo",
		name: "rood"
	)
	
	/// The perch unit of area.
	public static let perch: Self = .init(square: .rod)
	
	// MARK: - Other Metric Units
	
	/// The hectare unit of area.
	public static let hectare: Self = .init(
		coefficient: 1e+4,
		symbol: "ha",
		name: "hectare"
	)
	
	/// The decare unit of area.
	public static let decare: Self = .init(
		coefficient: 1e+3,
		symbol: "daa",
		name: "decare"
	)
	
	/// The are unit of area.
	public static let are: Self = .init(
		coefficient: 1e+2,
		symbol: "a",
		name: "are"
	)
	
	/// The centiare unit of area.
	public static let centiare: Self = .init(
		coefficient: 1,
		symbol: "ca",
		name: "centiare"
	)
	
	// MARK: - Raised Units
	
	/// Creates a new instance with the specified squared length.
	///
	/// - parameter length: The length.
	public init(square length: Length) {
		let coefficient: Double = length.coefficient.raising(to: 2)
		let symbol: String = length.symbol + "²"
		let name: String = "square" + " " + length.name
		
		self.init(
			coefficient: coefficient,
			symbol: symbol,
			name: name
		)
	}
}
