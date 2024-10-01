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
    private static func bit(_ prefix: BinaryPrefix) -> Self {
        precondition(prefix.coefficient >= .zero)
        
        let symbol: String = prefix.symbol + "b"
        
        return self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yobibit unit of memory.
    public static let yobibit: Self = .bit(.yobi)
    
    /// The zebibit unit of memory.
    public static let zebibit: Self = .bit(.zebi)
    
    /// The exbibit unit of memory.
    public static let exbibit: Self = .bit(.exbi)
    
    /// The pebibit unit of memory.
    public static let pebibit: Self = .bit(.pebi)
    
    /// The tebibit unit of memory.
    public static let tebibit: Self = .bit(.tebi)
    
    /// The gibibit unit of memory.
    public static let gibibit: Self = .bit(.gibi)
    
    /// The mebibit unit of memory.
    public static let mebibit: Self = .bit(.mebi)
    
    /// The kibibit unit of memory.
    public static let kibibit: Self = .bit(.kibi)
    
    // MARK: Metric Units
    
    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    private static func bit(_ prefix: MetricPrefix) -> Self {
        precondition(prefix.coefficient >= .zero)
        
        let symbol: String = prefix.symbol + "b"
        
        return self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yottabit unit of memory.
    public static let yottabit: Self = .bit(.yotta)
    
    /// The zettabit unit of memory.
    public static let zettabit: Self = .bit(.zetta)
    
    /// The hexabit unit of memory.
    public static let hexabit: Self = .bit(.hexa)
    
    /// The petabit unit of memory.
    public static let petabit: Self = .bit(.peta)
    
    /// The terabit unit of memory.
    public static let terabit: Self = .bit(.tera)
    
    /// The gigabit unit of memory.
    public static let gigabit: Self = .bit(.giga)
    
    /// The megabit unit of memory.
    public static let megabit: Self = .bit(.mega)
    
    /// The kilobit unit of memory.
    public static let kilobit: Self = .bit(.kilo)
    
    /// The hectobit unit of memory.
    public static let hectobit: Self = .bit(.hecto)
    
    /// The decabit unit of memory.
    public static let decabit: Self = .bit(.deca)
    
    /// The bit unit of memory.
    public static let bit: Self = .bit(MetricPrefix.none)
    
    // MARK: Additional Binary Units
    
    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    private static func byte(_ prefix: BinaryPrefix) -> Self {
        precondition(prefix.coefficient >= .zero)
        
        let symbol: String = prefix.symbol + "B"
        
        return self.init(
            coefficient: prefix.coefficient * 8,
            symbol: symbol
        )
    }
    
    /// The yobibyte unit of memory.
    public static let yobibyte: Self = .byte(.yobi)
    
    /// The zebibyte unit of memory.
    public static let zebibyte: Self = .byte(.zebi)
    
    /// The exbibyte unit of memory.
    public static let exbibyte: Self = .byte(.exbi)
    
    /// The pebibyte unit of memory.
    public static let pebibyte: Self = .byte(.pebi)
    
    /// The tebibyte unit of memory.
    public static let tebibyte: Self = .byte(.tebi)
    
    /// The gibibyte unit of memory.
    public static let gibibyte: Self = .byte(.gibi)
    
    /// The mebibyte unit of memory.
    public static let mebibyte: Self = .byte(.mebi)
    
    /// The kibibyte unit of memory.
    public static let kibibyte: Self = .byte(.kibi)
    
    // MARK: Additional Metric Units
    
    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    private static func byte(_ prefix: MetricPrefix) -> Self {
        precondition(prefix.coefficient >= .zero)
        
        let symbol: String = prefix.symbol + "B"
        
        return self.init(
            coefficient: prefix.coefficient * 8,
            symbol: symbol
        )
    }
    
    /// The yottabyte unit of memory.
    public static let yottabyte: Self = .byte(.yotta)
    
    /// The zettabyte unit of memory.
    public static let zettabyte: Self = .byte(.zetta)
    
    /// The hexabyte unit of memory.
    public static let hexabyte: Self = .byte(.hexa)
    
    /// The petabyte unit of memory.
    public static let petabyte: Self = .byte(.peta)
    
    /// The terabyte unit of memory.
    public static let terabyte: Self = .byte(.tera)
    
    /// The gigabyte unit of memory.
    public static let gigabyte: Self = .byte(.giga)
    
    /// The megabyte unit of memory.
    public static let megabyte: Self = .byte(.mega)
    
    /// The kilobyte unit of memory.
    public static let kilobyte: Self = .byte(.kilo)
    
    /// The hectobyte unit of memory.
    public static let hectobyte: Self = .byte(.hecto)
    
    /// The decabyte unit of memory.
    public static let decabyte: Self = .byte(.deca)
    
    /// The byte unit of memory.
    public static let byte: Self = .byte(MetricPrefix.none)
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
