//
// Cadence.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for absorbed dose.
public struct Cadence {
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
    
    // MARK: Other Units

    /// The revolutions per second unit of cadence.
    public static let revolutionsPerSecond: Self = .dividing(by: .second)

    /// The revolutions per minute unit of cadence.
    public static let revolutionsPerMinute: Self = .dividing(by: .minute)
    
    /// The revolutions per hour unit of cadence.
    public static let revolutionsPerHour: Self = .dividing(by: .hour)
}

// MARK: - Codable

extension Cadence: Codable {}

// MARK: - Comparable

extension Cadence: Comparable {}

// MARK: - Divisible

extension Cadence {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter volume: A unit of time.
    /// - returns: A unit of cadence.
    fileprivate static func dividing(by time: Time) -> Self {
        let coefficient: Double = Time.base.coefficient * (1 / time.coefficient)
        let symbol: String = "r" + "/" + time.symbol
        
        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension Cadence: Equatable {}

// MARK: - Hashable

extension Cadence: Hashable {}

// MARK: - Measurable

extension Cadence: Measurable {
    public static let base: Self = .revolutionsPerSecond
}

// MARK: - Sendable

extension Cadence: Sendable {}
