//
// Speed.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for speed.
public struct Speed {
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
    
    // MARK: Customary and Imperial Units

    /// The miles per hour unit of speed.
    public static let milesPerHour: Self = Length.mile.dividing(by: .hour)
    
    // MARK: Metric Units

    /// The kilometers per hour unit of speed.
    public static let kilometersPerHour: Self = Length.kilometer.dividing(by: .hour)

    /// The meter per second unit of speed.
    public static let metersPerSecond: Self = Length.meter.dividing(by: .second)
    
    // MARK: Other Units
    
    /// The knot unit of speed.
    public static let knot: Self = Length.nauticalMile.dividing(by: .hour)
}

// MARK: - Codable

extension Speed: Codable {}

// MARK: - Comparable

extension Speed: Comparable {}

// MARK: - Equatable

extension Speed: Equatable {}

// MARK: - Hashable

extension Speed: Hashable {}

// MARK: - Measurable

extension Speed: Measurable {
    public static let base: Self = .metersPerSecond
}

// MARK: - Sendable

extension Speed: Sendable {}
