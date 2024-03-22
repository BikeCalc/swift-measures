//
// Acceleration.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for acceleration.
public struct Acceleration {
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
    
    // MARK: Composed Units
    
    /// The meter per square second unit of acceleration.
    public static let meterPerSquareSecond: Self = Length.meter.dividing(by: .second)
}

// MARK: - Codable

extension Acceleration: Codable {}

// MARK: - Comparable

extension Acceleration: Comparable {}

// MARK: - Equatable

extension Acceleration: Equatable {}

// MARK: - Hashable

extension Acceleration: Hashable {}

// MARK: - Measurable

extension Acceleration: Measurable {
    public static let base: Self = .meterPerSquareSecond
}

// MARK: - Sendable

extension Acceleration: Sendable {}
