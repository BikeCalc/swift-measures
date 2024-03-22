//
// Memory.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for memory.
public struct Memory {
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
    
    // MARK: Binary Units
    
    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    private init(_ prefix: BinaryPrefix) {
        precondition(prefix.coefficient >= .zero)
        
        let symbol: String = prefix.symbol + "b"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yobibit unit of memory.
    public static let yobibit: Self = .init(.yobi)
    
    /// The zebibit unit of memory.
    public static let zebibit: Self = .init(.zebi)
    
    /// The exbibit unit of memory.
    public static let exbibit: Self = .init(.exbi)
    
    /// The pebibit unit of memory.
    public static let pebibit: Self = .init(.pebi)
    
    /// The tebibit unit of memory.
    public static let tebibit: Self = .init(.tebi)
    
    /// The gibibit unit of memory.
    public static let gibibit: Self = .init(.gibi)
    
    /// The mebibit unit of memory.
    public static let mebibit: Self = .init(.mebi)
    
    /// The kibibit unit of memory.
    public static let kibibit: Self = .init(.kibi)
    
    // MARK: Metric Units
    
    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    private init(_ prefix: MetricPrefix) {
        precondition(prefix.coefficient >= .zero)
        
        let symbol: String = prefix.symbol + "b"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
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
    public static let bit: Self = .init(MetricPrefix.none)
}

// MARK: - Codable

extension Memory: Codable {}

// MARK: - Comparable

extension Memory: Comparable {}

// MARK: - Equatable

extension Memory: Equatable {}

// MARK: - Hashable

extension Memory: Hashable {}

// MARK: - Measurable

extension Memory: Measurable {
    public static let base: Self = .bit
}

// MARK: - Sendable

extension Memory: Sendable {}
