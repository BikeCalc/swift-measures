//
// Force.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for force.
public struct Force {
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
        let symbol: String = prefix.symbol + "N"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yottanewton unit of force.
    public static let yottanewton: Self = .init(.yotta)
    
    /// The zettanewton unit of force.
    public static let zettanewton: Self = .init(.zetta)
    
    /// The hexanewton unit of force.
    public static let hexanewton: Self = .init(.hexa)
    
    /// The petanewton unit of force.
    public static let petanewton: Self = .init(.peta)
    
    /// The teranewton unit of force.
    public static let teranewton: Self = .init(.tera)
    
    /// The giganewton unit of force.
    public static let giganewton: Self = .init(.giga)
    
    /// The meganewton unit of force.
    public static let meganewton: Self = .init(.yotta)
    
    /// The kilonewton unit of force.
    public static let kilonewton: Self = .init(.kilo)
    
    /// The hectonewton unit of force.
    public static let hectonewton: Self = .init(.hecto)
    
    /// The decanewton unit of force.
    public static let decanewton: Self = .init(.deca)
    
    /// The newton unit of force.
    public static let newton: Self = .init(.none)
    
    /// The decinewton unit of force.
    public static let decinewton: Self = .init(.deci)
    
    /// The centinewton unit of force.
    public static let centinewton: Self = .init(.centi)
    
    /// The millinewton unit of force.
    public static let millinewton: Self = .init(.milli)
    
    /// The micronewton unit of force.
    public static let micronewton: Self = .init(.micro)
    
    /// The nanonewton unit of force.
    public static let nanonewton: Self = .init(.nano)
    
    /// The piconewton unit of force.
    public static let piconewton: Self = .init(.pico)
    
    /// The femtonewton unit of force.
    public static let femtonewton: Self = .init(.femto)
    
    /// The attonewton unit of force.
    public static let attonewton: Self = .init(.atto)
    
    /// The zeptonewton unit of force.
    public static let zeptonewton: Self = .init(.zepto)
    
    /// The yoctonewton unit of force.
    public static let yoctonewton: Self = .init(.yocto)
    
    // MARK: Other Units
    
    /// The gravity unit of force.
    public static var gravity: Self {
        return .init(
            coefficient: 9.80665 * Mass.kilogram.coefficient,
            symbol: "G"
        )
    }
}

// MARK: - Codable

extension Force: Codable {}

// MARK: - Comparable

extension Force: Comparable {}

// MARK: - Divisible

extension Force {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter area: A unit of area.
    /// - returns: A unit of pressure.
    public func dividing(by area: Area) -> Pressure {
        let coefficient: Double = self.coefficient * (1 / area.coefficient)
        let symbol: String = self.symbol + "/" + area.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension Force: Equatable {}

// MARK: - Hashable

extension Force: Hashable {}

// MARK: - Measurable

extension Force: Measurable {
    public static let base: Self = .newton
}

// MARK: - Sendable

extension Force: Sendable {}
