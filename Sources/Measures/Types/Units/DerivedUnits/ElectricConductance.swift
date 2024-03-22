//
// ElectricConductance.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for electric conductance.
public struct ElectricConductance {
    public let coefficient: Double
    
    public let constant: Double
    
    public let symbol: String
    
	public init(
		coefficient: Double,
		constant: Double = 0,
		symbol: String
	) {
		self.coefficient = coefficient
		self.constant = constant
		self.symbol = symbol
	}
    
    // MARK: Metric Units
    
    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    fileprivate init(_ prefix: MetricPrefix) {
        let symbol: String = prefix.symbol + "S"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yottasiemens unit of electric conductance.
    public static let yottasiemens: Self = .init(.yotta)
    
    /// The zettasiemens unit of electric conductance.
    public static let zettasiemens: Self = .init(.zetta)
    
    /// The hexasiemens unit of electric conductance.
    public static let hexasiemens: Self = .init(.hexa)
    
    /// The petasiemens unit of electric conductance.
    public static let petasiemens: Self = .init(.peta)
    
    /// The terasiemens unit of electric conductance.
    public static let terasiemens: Self = .init(.tera)
    
    /// The gigasiemens unit of electric conductance.
    public static let gigasiemens: Self = .init(.giga)
    
    /// The megasiemens unit of electric conductance.
    public static let megasiemens: Self = .init(.yotta)
    
    /// The kilosiemens unit of electric conductance.
    public static let kilosiemens: Self = .init(.kilo)
    
    /// The hectosiemens unit of electric conductance.
    public static let hectosiemens: Self = .init(.hecto)
    
    /// The decasiemens unit of electric conductance.
    public static let decasiemens: Self = .init(.deca)
    
    /// The siemens unit of electric conductance.
    public static let siemens: Self = .init(.none)
    
    /// The decisiemens unit of electric conductance.
    public static let decisiemens: Self = .init(.deci)
    
    /// The centisiemens unit of electric conductance.
    public static let centisiemens: Self = .init(.centi)
    
    /// The millisiemens unit of electric conductance.
    public static let millisiemens: Self = .init(.milli)
    
    /// The microsiemens unit of electric conductance.
    public static let microsiemens: Self = .init(.micro)
    
    /// The nanosiemens unit of electric conductance.
    public static let nanosiemens: Self = .init(.nano)
    
    /// The picosiemens unit of electric conductance.
    public static let picosiemens: Self = .init(.pico)
    
    /// The femtosiemens unit of electric conductance.
    public static let femtosiemens: Self = .init(.femto)
    
    /// The attosiemens unit of electric conductance.
    public static let attosiemens: Self = .init(.atto)
    
    /// The zeptosiemens unit of electric conductance.
    public static let zeptosiemens: Self = .init(.zepto)
    
    /// The yoctosiemens unit of electric conductance.
    public static let yoctosiemens: Self = .init(.yocto)
}

// MARK: - Codable

extension ElectricConductance: Codable {}

// MARK: - Comparable

extension ElectricConductance: Comparable {}

// MARK: - Equatable

extension ElectricConductance: Equatable {}

// MARK: - Hashable

extension ElectricConductance: Hashable {}

// MARK: - Measurable

extension ElectricConductance: Measurable {
    public static let base: Self = .siemens
}

// MARK: - Sendable

extension ElectricConductance: Sendable {}
