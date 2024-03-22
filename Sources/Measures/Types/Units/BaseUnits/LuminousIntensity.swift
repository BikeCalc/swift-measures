//
// LuminousIntensity.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for luminous intensity.
public struct LuminousIntensity {
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
        let symbol: String = prefix.symbol + "cd"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yottacandela unit of luminous intensity.
    public static let yottacandela: Self = .init(.yotta)
    
    /// The zettacandela unit of luminous intensity.
    public static let zettacandela: Self = .init(.zetta)
    
    /// The hexacandela unit of luminous intensity.
    public static let hexacandela: Self = .init(.hexa)
    
    /// The petacandela unit of luminous intensity.
    public static let petacandela: Self = .init(.peta)
    
    /// The teracandela unit of luminous intensity.
    public static let teracandela: Self = .init(.tera)
    
    /// The gigacandela unit of luminous intensity.
    public static let gigacandela: Self = .init(.giga)
    
    /// The megacandela unit of luminous intensity.
    public static let megacandela: Self = .init(.yotta)
    
    /// The kilocandela unit of luminous intensity.
    public static let kilocandela: Self = .init(.kilo)
    
    /// The hectocandela unit of luminous intensity.
    public static let hectocandela: Self = .init(.hecto)
    
    /// The decacandela unit of luminous intensity.
    public static let decacandela: Self = .init(.deca)
    
    /// The candela unit of luminous intensity.
    public static let candela: Self = .init(.none)
    
    /// The decicandela unit of luminous intensity.
    public static let decicandela: Self = .init(.deci)
    
    /// The centicandela unit of luminous intensity.
    public static let centicandela: Self = .init(.centi)
    
    /// The millicandela unit of luminous intensity.
    public static let millicandela: Self = .init(.milli)
    
    /// The microcandela unit of luminous intensity.
    public static let microcandela: Self = .init(.micro)
    
    /// The nanocandela unit of luminous intensity.
    public static let nanocandela: Self = .init(.nano)
    
    /// The picocandela unit of luminous intensity.
    public static let picocandela: Self = .init(.pico)
    
    /// The femtocandela unit of luminous intensity.
    public static let femtocandela: Self = .init(.femto)
    
    /// The attocandela unit of luminous intensity.
    public static let attocandela: Self = .init(.atto)
    
    /// The zeptocandela unit of luminous intensity.
    public static let zeptocandela: Self = .init(.zepto)
    
    /// The yoctocandela unit of luminous intensity.
    public static let yoctocandela: Self = .init(.yocto)
}

// MARK: - Codable

extension LuminousIntensity: Codable {}

// MARK: - Comparable

extension LuminousIntensity: Comparable {}

// MARK: - Equatable

extension LuminousIntensity: Equatable {}

// MARK: - Hashable

extension LuminousIntensity: Hashable {}

// MARK: - Measurable

extension LuminousIntensity: Measurable {
    public static let base: Self = .candela
}

// MARK: - Sendable

extension LuminousIntensity: Sendable {}
