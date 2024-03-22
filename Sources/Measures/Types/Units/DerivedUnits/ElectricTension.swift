//
// ElectricTension.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A unit of measure for electric tension.
public struct ElectricTension {
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
    
    /// The ampere hour unit of electric tension.
    public static let ampereHour: Self = ElectricCurrent.ampere.dividing(by: .hour)
    
    /// The ampere second unit of electric tension.
    public static let ampereSecond: Self = ElectricCurrent.ampere.dividing(by: .second)
    
    // MARK: Metric Units
    
    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    fileprivate init(_ prefix: MetricPrefix) {
        let symbol: String = prefix.symbol + "C"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yottacoulomb unit of electric tension.
    public static let yottacoulomb: Self = .init(.yotta)
    
    /// The zettacoulomb unit of electric tension.
    public static let zettacoulomb: Self = .init(.zetta)
    
    /// The hexacoulomb unit of electric tension.
    public static let hexacoulomb: Self = .init(.hexa)
    
    /// The petacoulomb unit of electric tension.
    public static let petacoulomb: Self = .init(.peta)
    
    /// The teracoulomb unit of electric tension.
    public static let teracoulomb: Self = .init(.tera)
    
    /// The gigacoulomb unit of electric tension.
    public static let gigacoulomb: Self = .init(.giga)
    
    /// The megacoulomb unit of electric tension.
    public static let megacoulomb: Self = .init(.yotta)
    
    /// The kilocoulomb unit of electric tension.
    public static let kilocoulomb: Self = .init(.kilo)
    
    /// The hectocoulomb unit of electric tension.
    public static let hectocoulomb: Self = .init(.hecto)
    
    /// The decacoulomb unit of electric tension.
    public static let decacoulomb: Self = .init(.deca)
    
    /// The coulomb unit of electric tension.
    public static let coulomb: Self = .init(.none)
    
    /// The decicoulomb unit of electric tension.
    public static let decicoulomb: Self = .init(.deci)
    
    /// The centicoulomb unit of electric tension.
    public static let centicoulomb: Self = .init(.centi)
    
    /// The millicoulomb unit of electric tension.
    public static let millicoulomb: Self = .init(.milli)
    
    /// The microcoulomb unit of electric tension.
    public static let microcoulomb: Self = .init(.micro)
    
    /// The nanocoulomb unit of electric tension.
    public static let nanocoulomb: Self = .init(.nano)
    
    /// The picocoulomb unit of electric tension.
    public static let picocoulomb: Self = .init(.pico)
    
    /// The femtocoulomb unit of electric tension.
    public static let femtocoulomb: Self = .init(.femto)
    
    /// The attocoulomb unit of electric tension.
    public static let attocoulomb: Self = .init(.atto)
    
    /// The zeptocoulomb unit of electric tension.
    public static let zeptocoulomb: Self = .init(.zepto)
    
    /// The yoctocoulomb unit of electric tension.
    public static let yoctocoulomb: Self = .init(.yocto)
}

// MARK: - Codable

extension ElectricTension: Codable {}

// MARK: - Comparable

extension ElectricTension: Comparable {}

// MARK: - Equatable

extension ElectricTension: Equatable {}

// MARK: - Hashable

extension ElectricTension: Hashable {}

// MARK: - Measurable

extension ElectricTension: Measurable {
    public static let base: Self = .coulomb
}

// MARK: - Sendable

extension ElectricTension: Sendable {}
