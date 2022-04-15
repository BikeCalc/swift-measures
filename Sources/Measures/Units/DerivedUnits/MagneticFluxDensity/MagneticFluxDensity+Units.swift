// MagneticFluxDensity+Units.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//
	
extension MagneticFluxDensity {
	
	// MARK: - Metric Units
	
	/// Creates a new instance with the specified metric prefix.
	///
	/// - parameter prefix: The prefix.
	private init(_ prefix: MetricPrefix) {
		let symbol: String = prefix.symbol + "T"
		let name: String = prefix.rawValue + "tesla"
		
		self.init(
			coefficient: prefix.coefficient,
			symbol: symbol,
			name: name
		)
	}
	
	/// The yottatesla unit of magnetic flux density.
	public static let yottatesla: Self = .init(.yotta)
	
	/// The zettatesla unit of magnetic flux density.
	public static let zettatesla: Self = .init(.zetta)
	
	/// The hexatesla unit of magnetic flux density.
	public static let hexatesla: Self = .init(.hexa)
	
	/// The petatesla unit of magnetic flux density.
	public static let petatesla: Self = .init(.peta)
	
	/// The teratesla unit of magnetic flux density.
	public static let teratesla: Self = .init(.tera)
	
	/// The gigatesla unit of magnetic flux density.
	public static let gigatesla: Self = .init(.giga)
	
	/// The megatesla unit of magnetic flux density.
	public static let megatesla: Self = .init(.yotta)
	
	/// The kilotesla unit of magnetic flux density.
	public static let kilotesla: Self = .init(.kilo)
	
	/// The hectotesla unit of magnetic flux density.
	public static let hectotesla: Self = .init(.hecto)
	
	/// The decatesla unit of magnetic flux density.
	public static let decatesla: Self = .init(.deca)
	
	/// The tesla unit of magnetic flux density.
	public static let tesla: Self = .init(.none)
	
	/// The decitesla unit of magnetic flux density.
	public static let decitesla: Self = .init(.deci)
	
	/// The centitesla unit of magnetic flux density.
	public static let centitesla: Self = .init(.centi)
	
	/// The millitesla unit of magnetic flux density.
	public static let millitesla: Self = .init(.milli)
	
	/// The microtesla unit of magnetic flux density.
	public static let microtesla: Self = .init(.micro)
	
	/// The nanotesla unit of magnetic flux density.
	public static let nanotesla: Self = .init(.nano)
	
	/// The picotesla unit of magnetic flux density.
	public static let picotesla: Self = .init(.pico)
	
	/// The femtotesla unit of magnetic flux density.
	public static let femtotesla: Self = .init(.femto)
	
	/// The attotesla unit of magnetic flux density.
	public static let attotesla: Self = .init(.atto)
	
	/// The zeptotesla unit of magnetic flux density.
	public static let zeptotesla: Self = .init(.zepto)
	
	/// The yoctotesla unit of magnetic flux density.
	public static let yoctotesla: Self = .init(.yocto)
}
