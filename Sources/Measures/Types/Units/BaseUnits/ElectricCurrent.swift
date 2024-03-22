//
// ElectricCurrent.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for electric current.
public struct ElectricCurrent {
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
        let symbol: String = prefix.symbol + "A"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yottaampere unit of electric current.
    public static let yottaampere: Self = .init(.yotta)
    
    /// The zettaampere unit of electric current.
    public static let zettaampere: Self = .init(.zetta)
    
    /// The hexaampere unit of electric current.
    public static let hexaampere: Self = .init(.hexa)
    
    /// The petaampere unit of electric current.
    public static let petaampere: Self = .init(.peta)
    
    /// The teraampere unit of electric current.
    public static let teraampere: Self = .init(.tera)
    
    /// The gigaampere unit of electric current.
    public static let gigaampere: Self = .init(.giga)
    
    /// The megaampere unit of electric current.
    public static let megaampere: Self = .init(.yotta)
    
    /// The kiloampere unit of electric current.
    public static let kiloampere: Self = .init(.kilo)
    
    /// The hectoampere unit of electric current.
    public static let hectoampere: Self = .init(.hecto)
    
    /// The decaampere unit of electric current.
    public static let decaampere: Self = .init(.deca)
    
    /// The ampere unit of electric current.
    public static let ampere: Self = .init(.none)
    
    /// The deciampere unit of electric current.
    public static let deciampere: Self = .init(.deci)
    
    /// The centiampere unit of electric current.
    public static let centiampere: Self = .init(.centi)
    
    /// The milliampere unit of electric current.
    public static let milliampere: Self = .init(.milli)
    
    /// The microampere unit of electric current.
    public static let microampere: Self = .init(.micro)
    
    /// The nanoampere unit of electric current.
    public static let nanoampere: Self = .init(.nano)
    
    /// The picoampere unit of electric current.
    public static let picoampere: Self = .init(.pico)
    
    /// The femtoampere unit of electric current.
    public static let femtoampere: Self = .init(.femto)
    
    /// The attoampere unit of electric current.
    public static let attoampere: Self = .init(.atto)
    
    /// The zeptoampere unit of electric current.
    public static let zeptoampere: Self = .init(.zepto)
    
    /// The yoctoampere unit of electric current.
    public static let yoctoampere: Self = .init(.yocto)
}

// MARK: - Codable

extension ElectricCurrent: Codable {}

// MARK: - Comparable

extension ElectricCurrent: Comparable {}

// MARK: - Divisible

extension ElectricCurrent {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter time: A unit of time.
    /// - returns: A unit of electric tension.
    public func dividing(by time: Time) -> ElectricTension {
        let coefficient: Double = self.coefficient * (1 / time.coefficient)
        let symbol: String = self.symbol + "/" + time.symbol
        
        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension ElectricCurrent: Equatable {}

// MARK: - Hashable

extension ElectricCurrent: Hashable {}

// MARK: - Measurable

extension ElectricCurrent: Measurable {
    public static let base: Self = .ampere
}

// MARK: - Sendable

extension ElectricCurrent: Sendable {}
