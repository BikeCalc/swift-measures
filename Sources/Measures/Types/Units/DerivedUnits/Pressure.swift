//
// Pressure.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for pressure.
public struct Pressure {
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
    
    /// The newtons per square meter unit of pressure.
    public static let newtonsPerSquareMeter: Self = Force.newton.dividing(by: Length.meter.squared())
    
    /// The pounds per square inch unit of pressure.
    public static let poundsPerSquareInch: Self = .init(
        coefficient: Mass.pound.coefficient / Length.inch.squared().coefficient,
        symbol: "psi"
    )
    
    // MARK: Metric Units
    
    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    fileprivate init(_ prefix: MetricPrefix) {
        let symbol: String = prefix.symbol + "Pa"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yottapascal unit of pressure.
    public static let yottapascal: Self = .init(.yotta)
    
    /// The zettapascal unit of pressure.
    public static let zettapascal: Self = .init(.zetta)
    
    /// The hexapascal unit of pressure.
    public static let hexapascal: Self = .init(.hexa)
    
    /// The petapascal unit of pressure.
    public static let petapascal: Self = .init(.peta)
    
    /// The terapascal unit of pressure.
    public static let terapascal: Self = .init(.tera)
    
    /// The gigapascal unit of pressure.
    public static let gigapascal: Self = .init(.giga)
    
    /// The megapascal unit of pressure.
    public static let megapascal: Self = .init(.yotta)
    
    /// The kilopascal unit of pressure.
    public static let kilopascal: Self = .init(.kilo)
    
    /// The hectopascal unit of pressure.
    public static let hectopascal: Self = .init(.hecto)
    
    /// The decapascal unit of pressure.
    public static let decapascal: Self = .init(.deca)
    
    /// The pascal unit of pressure.
    public static let pascal: Self = .init(.none)
    
    /// The decipascal unit of pressure.
    public static let decipascal: Self = .init(.deci)
    
    /// The centipascal unit of pressure.
    public static let centipascal: Self = .init(.centi)
    
    /// The millipascal unit of pressure.
    public static let millipascal: Self = .init(.milli)
    
    /// The micropascal unit of pressure.
    public static let micropascal: Self = .init(.micro)
    
    /// The nanopascal unit of pressure.
    public static let nanopascal: Self = .init(.nano)
    
    /// The picopascal unit of pressure.
    public static let picopascal: Self = .init(.pico)
    
    /// The femtopascal unit of pressure.
    public static let femtopascal: Self = .init(.femto)
    
    /// The attopascal unit of pressure.
    public static let attopascal: Self = .init(.atto)
    
    /// The zeptopascal unit of pressure.
    public static let zeptopascal: Self = .init(.zepto)
    
    /// The yoctopascal unit of pressure.
    public static let yoctopascal: Self = .init(.yocto)
    
    // MARK: Other Metric Units
    
    /// The bar unit of energy.
    public static let bar: Self = .init(
        coefficient: 1e+5,
        symbol: "bar"
    )
    
    /// The millibar unit of energy.
    public static let millibar: Self = .init(
        coefficient: 1e+2,
        symbol: "mbar"
    )
    
    // MARK: Other Units
    
    /// The atmosphere unit of energy.
    public static let atmosphere: Self = .init(
        coefficient: 1.01325e+5,
        symbol: "atm"
    )
    
    /// The bar unit of energy.
    public static let torr: Self = .init(
        coefficient: Self.atmosphere.coefficient / 760,
        symbol: "Torr"
    )
    
    /// The millitorr unit of energy.
    public static let millitorr: Self = .init(
        coefficient: Self.torr.coefficient * 1e-3,
        symbol: "mTorr"
    )
}

// MARK: - Codable

extension Pressure: Codable {}

// MARK: - Comparable

extension Pressure: Comparable {}

// MARK: - Equatable

extension Pressure: Equatable {}

// MARK: - Hashable

extension Pressure: Hashable {}

// MARK: - Measurable

extension Pressure: Measurable {
    public static let base: Self = .pascal
}

// MARK: - Sendable

extension Pressure: Sendable {}
