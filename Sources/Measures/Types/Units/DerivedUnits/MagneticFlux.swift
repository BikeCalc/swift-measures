//
// MagneticFlux.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for magnetic flux.
public struct MagneticFlux {
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
        let symbol: String = prefix.symbol + "Wb"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yottaweber unit of magnetic flux.
    public static let yottaweber: Self = .init(.yotta)
    
    /// The zettaweber unit of magnetic flux.
    public static let zettaweber: Self = .init(.zetta)
    
    /// The hexaweber unit of magnetic flux.
    public static let hexaweber: Self = .init(.hexa)
    
    /// The petaweber unit of magnetic flux.
    public static let petaweber: Self = .init(.peta)
    
    /// The teraweber unit of magnetic flux.
    public static let teraweber: Self = .init(.tera)
    
    /// The gigaweber unit of magnetic flux.
    public static let gigaweber: Self = .init(.giga)
    
    /// The megaweber unit of magnetic flux.
    public static let megaweber: Self = .init(.yotta)
    
    /// The kiloweber unit of magnetic flux.
    public static let kiloweber: Self = .init(.kilo)
    
    /// The hectoweber unit of magnetic flux.
    public static let hectoweber: Self = .init(.hecto)
    
    /// The decaweber unit of magnetic flux.
    public static let decaweber: Self = .init(.deca)
    
    /// The weber unit of magnetic flux.
    public static let weber: Self = .init(.none)
    
    /// The deciweber unit of magnetic flux.
    public static let deciweber: Self = .init(.deci)
    
    /// The centiweber unit of magnetic flux.
    public static let centiweber: Self = .init(.centi)
    
    /// The milliweber unit of magnetic flux.
    public static let milliweber: Self = .init(.milli)
    
    /// The microweber unit of magnetic flux.
    public static let microweber: Self = .init(.micro)
    
    /// The nanoweber unit of magnetic flux.
    public static let nanoweber: Self = .init(.nano)
    
    /// The picoweber unit of magnetic flux.
    public static let picoweber: Self = .init(.pico)
    
    /// The femtoweber unit of magnetic flux.
    public static let femtoweber: Self = .init(.femto)
    
    /// The attoweber unit of magnetic flux.
    public static let attoweber: Self = .init(.atto)
    
    /// The zeptoweber unit of magnetic flux.
    public static let zeptoweber: Self = .init(.zepto)
    
    /// The yoctoweber unit of magnetic flux.
    public static let yoctoweber: Self = .init(.yocto)
}

// MARK: - Codable

extension MagneticFlux: Codable {}

// MARK: - Comparable

extension MagneticFlux: Comparable {}

// MARK: - Equatable

extension MagneticFlux: Equatable {}

// MARK: - Hashable

extension MagneticFlux: Hashable {}

// MARK: - Measurable

extension MagneticFlux: Measurable {
    public static let base: Self = .weber
}

// MARK: - Sendable

extension MagneticFlux: Sendable {}
