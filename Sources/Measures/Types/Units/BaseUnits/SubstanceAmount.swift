//
// SubstanceAmount.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for substance amount.
public struct SubstanceAmount {
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
        let symbol: String = prefix.symbol + "mol"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The quettamole unit of substance amount.
    public static let quettamole: Self = .init(.quetta)

    /// The ronnamole unit of substance amount.
    public static let ronnamole: Self = .init(.ronna)

    /// The yottamole unit of substance amount.
    public static let yottamole: Self = .init(.yotta)
    
    /// The zettamole unit of substance amount.
    public static let zettamole: Self = .init(.zetta)
    
    /// The examole unit of substance amount.
    public static let examole: Self = .init(.exa)
    
    /// The petamole unit of substance amount.
    public static let petamole: Self = .init(.peta)
    
    /// The teramole unit of substance amount.
    public static let teramole: Self = .init(.tera)
    
    /// The gigamole unit of substance amount.
    public static let gigamole: Self = .init(.giga)
    
    /// The megamole unit of substance amount.
    public static let megamole: Self = .init(.yotta)
    
    /// The kilomole unit of substance amount.
    public static let kilomole: Self = .init(.kilo)
    
    /// The hectomole unit of substance amount.
    public static let hectomole: Self = .init(.hecto)
    
    /// The decamole unit of substance amount.
    public static let decamole: Self = .init(.deca)
    
    /// The mole unit of substance amount.
    public static let mole: Self = .init(.none)
    
    /// The decimole unit of substance amount.
    public static let decimole: Self = .init(.deci)
    
    /// The centimole unit of substance amount.
    public static let centimole: Self = .init(.centi)
    
    /// The millimole unit of substance amount.
    public static let millimole: Self = .init(.milli)
    
    /// The micromole unit of substance amount.
    public static let micromole: Self = .init(.micro)
    
    /// The nanomole unit of substance amount.
    public static let nanomole: Self = .init(.nano)
    
    /// The picomole unit of substance amount.
    public static let picomole: Self = .init(.pico)
    
    /// The femtomole unit of substance amount.
    public static let femtomole: Self = .init(.femto)
    
    /// The attomole unit of substance amount.
    public static let attomole: Self = .init(.atto)
    
    /// The zeptomole unit of substance amount.
    public static let zeptomole: Self = .init(.zepto)
    
    /// The yoctomole unit of substance amount.
    public static let yoctomole: Self = .init(.yocto)

    /// The rontomole unit of substance amount.
    public static let rontomole: Self = .init(.ronto)

    /// The quectomole unit of substance amount.
    public static let quectomole: Self = .init(.quecto)
}

// MARK: - Codable

extension SubstanceAmount: Codable {}

// MARK: - Comparable

extension SubstanceAmount: Comparable {}

// MARK: - Equatable

extension SubstanceAmount: Equatable {}

// MARK: - Hashable

extension SubstanceAmount: Hashable {}

// MARK: - Measurable

extension SubstanceAmount: Measurable {
    public static let base: Self = .mole
}

// MARK: - Sendable

extension SubstanceAmount: Sendable {}

