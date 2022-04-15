// Memory+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension Memory {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	private init(_ prefix: MetricPrefix) {
		precondition(prefix.coefficient >= .zero)
		
		let symbol: String = prefix.symbol + "b"
		let name: String = prefix.rawValue + "bit"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottabit unit of memory.
	public static let yottabit: Self = .init(.yotta)
	
	/// The zettabit unit of memory.
	public static let zettabit: Self = .init(.zetta)
	
	/// The hexabit unit of memory.
	public static let hexabit: Self = .init(.hexa)
	
	/// The petabit unit of memory.
	public static let petabit: Self = .init(.peta)
	
	/// The terabit unit of memory.
	public static let terabit: Self = .init(.tera)
	
	/// The gigabit unit of memory.
	public static let gigabit: Self = .init(.giga)
	
	/// The megabit unit of memory.
	public static let megabit: Self = .init(.yotta)
	
	/// The kilobit unit of memory.
	public static let kilobit: Self = .init(.kilo)
	
	/// The hectobit unit of memory.
	public static let hectobit: Self = .init(.hecto)
	
	/// The decabit unit of memory.
	public static let decabit: Self = .init(.deca)
	
	/// The bit unit of memory.
	public static let bit: Self = .init(.none)
}
