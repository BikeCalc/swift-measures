//
// ElectricPotential.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for electric potential.
public struct ElectricPotential {
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
        let symbol: String = prefix.symbol + "V"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yottavolt unit of electric potential.
    public static let yottavolt: Self = .init(.yotta)
    
    /// The zettavolt unit of electric potential.
    public static let zettavolt: Self = .init(.zetta)
    
    /// The hexavolt unit of electric potential.
    public static let hexavolt: Self = .init(.hexa)
    
    /// The petavolt unit of electric potential.
    public static let petavolt: Self = .init(.peta)
    
    /// The teravolt unit of electric potential.
    public static let teravolt: Self = .init(.tera)
    
    /// The gigavolt unit of electric potential.
    public static let gigavolt: Self = .init(.giga)
    
    /// The megavolt unit of electric potential.
    public static let megavolt: Self = .init(.yotta)
    
    /// The kilovolt unit of electric potential.
    public static let kilovolt: Self = .init(.kilo)
    
    /// The hectovolt unit of electric potential.
    public static let hectovolt: Self = .init(.hecto)
    
    /// The decavolt unit of electric potential.
    public static let decavolt: Self = .init(.deca)
    
    /// The volt unit of electric potential.
    public static let volt: Self = .init(.none)
    
    /// The decivolt unit of electric potential.
    public static let decivolt: Self = .init(.deci)
    
    /// The centivolt unit of electric potential.
    public static let centivolt: Self = .init(.centi)
    
    /// The millivolt unit of electric potential.
    public static let millivolt: Self = .init(.milli)
    
    /// The microvolt unit of electric potential.
    public static let microvolt: Self = .init(.micro)
    
    /// The nanovolt unit of electric potential.
    public static let nanovolt: Self = .init(.nano)
    
    /// The picovolt unit of electric potential.
    public static let picovolt: Self = .init(.pico)
    
    /// The femtovolt unit of electric potential.
    public static let femtovolt: Self = .init(.femto)
    
    /// The attovolt unit of electric potential.
    public static let attovolt: Self = .init(.atto)
    
    /// The zeptovolt unit of electric potential.
    public static let zeptovolt: Self = .init(.zepto)
    
    /// The yoctovolt unit of electric potential.
    public static let yoctovolt: Self = .init(.yocto)
}

// MARK: - Codable

extension ElectricPotential: Codable {}

// MARK: - Comparable

extension ElectricPotential: Comparable {}

// MARK: - Equatable

extension ElectricPotential: Equatable {}

// MARK: - Hashable

extension ElectricPotential: Hashable {}

// MARK: - Measurable

extension ElectricPotential: Measurable {
    public static let base: Self = .volt
}

// MARK: - Sendable

extension ElectricPotential: Sendable {}
