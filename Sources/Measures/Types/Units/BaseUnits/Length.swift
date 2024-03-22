//
// Length.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import NumericProtocols

/// A unit of measure for length.
public struct Length {
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
    
    // MARK: Astronomical Units
    
    /// The parsec unit of length.
    public static let parsec: Self = .init(
        coefficient: 3.086e+16,
        symbol: "pc"
    )
    
    /// The light year unit of length.
    public static let lightYear: Self = .init(
        coefficient: 9.4607e+15,
        symbol: "ly"
    )
    
    /// The astronomical unit unit of length.
    public static let astronomicalUnit: Self = .init(
        coefficient: 1.496e+11,
        symbol: "au"
    )
    
    // MARK: Customary and Imperial Units
    
    /// The nautical league unit of length.
    public static let nauticalLeague: Self = .init(
        coefficient: Self.nauticalMile.coefficient * 3,
        symbol: "nlea"
    )
    
    /// The league unit of length.
    public static let league: Self = .init(
        coefficient: Self.mile.coefficient * 3,
        symbol: "lea"
    )
    
    /// The nautical mile unit of length.
    public static let nauticalMile: Self = .init(
        coefficient: 1.852e+3,
        symbol: "nmi"
    )
    
    /// The mile unit of length.
    public static let mile: Self = .init(
        coefficient: 1.609344e+3,
        symbol: "mi"
    )
    
    /// The cable unit of length.
    public static let cable: Self = .init(
        coefficient: Self.nauticalMile.coefficient / 10,
        symbol: "cb"
    )
    
    /// The furlong unit of length.
    public static let furlong: Self = .init(
        coefficient: 2.01168e+2, symbol: "fur"
    )
    
    /// The chain unit of length.
    public static let chain: Self = .init(
        coefficient: Self.inch.coefficient * 792,
        symbol: "ch"
    )
    
    /// The rod unit of length.
    public static let rod: Self = .init(
        coefficient: Self.inch.coefficient * 198,
        symbol: "rd"
    )
    
    /// The fathom unit of length.
    public static let fathom: Self = .init(
        coefficient: Self.inch.coefficient * 72,
        symbol: "ftm"
    )
    
    /// The yard unit of length.
    public static let yard: Self = .init(
        coefficient: Self.inch.coefficient * 36,
        symbol: "yd"
    )
    
    /// The foot unit of length.
    public static let foot: Self = .init(
        coefficient: Self.inch.coefficient * 12,
        symbol: "ft"
    )
    
    /// The link unit of length.
    public static let link: Self = .init(
        coefficient: 2.01168,
        symbol: "li"
    )
    
    /// The inch unit of length.
    public static let inch: Self = .init(
        coefficient: 2.54e-2,
        symbol: "in"
    )
    
    /// The pica unit of length.
    public static let pica: Self = .init(
        coefficient: Self.inch.coefficient / 6,
        symbol: "pc"
    )
    
    /// The point unit of length.
    public static let point: Self = .init(
        coefficient: Self.inch.coefficient / 72,
        symbol: "pt"
    )
    
    /// The thou unit of length.
    public static let thou: Self = .init(
        coefficient: Self.inch.coefficient / 1_000,
        symbol: "th"
    )
    
    // MARK: Metric Units
    
    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    fileprivate init(_ prefix: MetricPrefix) {
        let symbol: String = prefix.symbol + "m"
        
        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }
    
    /// The yottameter unit of length.
    public static let yottameter: Self = .init(.yotta)
    
    /// The zettameter unit of length.
    public static let zettameter: Self = .init(.zetta)
    
    /// The hexameter unit of length.
    public static let hexameter: Self = .init(.hexa)
    
    /// The petameter unit of length.
    public static let petameter: Self = .init(.peta)
    
    /// The terameter unit of length.
    public static let terameter: Self = .init(.tera)
    
    /// The gigameter unit of length.
    public static let gigameter: Self = .init(.giga)
    
    /// The megameter unit of length.
    public static let megameter: Self = .init(.yotta)
    
    /// The kilometer unit of length.
    public static let kilometer: Self = .init(.kilo)
    
    /// The hectometer unit of length.
    public static let hectometer: Self = .init(.hecto)
    
    /// The decameter unit of length.
    public static let decameter: Self = .init(.deca)
    
    /// The meter unit of length.
    public static let meter: Self = .init(.none)
    
    /// The decimeter unit of length.
    public static let decimeter: Self = .init(.deci)
    
    /// The centimeter unit of length.
    public static let centimeter: Self = .init(.centi)
    
    /// The millimeter unit of length.
    public static let millimeter: Self = .init(.milli)
    
    /// The micrometer unit of length.
    public static let micrometer: Self = .init(.micro)
    
    /// The nanometer unit of length.
    public static let nanometer: Self = .init(.nano)
    
    /// The picometer unit of length.
    public static let picometer: Self = .init(.pico)
    
    /// The femtometer unit of length.
    public static let femtometer: Self = .init(.femto)
    
    /// The attometer unit of length.
    public static let attometer: Self = .init(.atto)
    
    /// The zeptometer unit of length.
    public static let zeptometer: Self = .init(.zepto)
    
    /// The yoctometer unit of length.
    public static let yoctometer: Self = .init(.yocto)
}

// MARK: - Codable

extension Length: Codable {}

// MARK: - Comparable

extension Length: Comparable {}

// MARK: - Divisible

extension Length {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter time: A unit of time.
    /// - returns: A unit of acceleration.
    public func dividing(by time: Time) -> Acceleration {
        let coefficient: Double = self.coefficient * (1 / time.coefficient.raising(to: 2))
        let symbol: String = self.symbol + "/" + time.symbol + "²"
        
        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
    
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter time: A unit of time.
    /// - returns: A unit of speed.
    public func dividing(by time: Time) -> Speed {
        let coefficient: Double =  self.coefficient * (1 / time.coefficient)
        let symbol: String = self.symbol + "/" + time.symbol
        
        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}


// MARK: - Equatable

extension Length: Equatable {}

// MARK: - Hashable

extension Length: Hashable {}

// MARK: - Measurable

extension Length: Measurable {
    public static let base: Self = .meter
}

// MARK: - Raisable

extension Length {
    /// Returns the result of raising this value to its square.
    ///
    /// - returns: A unit of area.
    public func squared() -> Area {
        let coefficient: Double = self.coefficient.raising(to: 2)
        let symbol: String = self.symbol + "²"
        
        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
    
    /// Returns the result of raising this value to its cube.
    ///
    /// - returns: A unit of volume.
    public func cubed() -> Volume {
        let coefficient: Double = self.coefficient.raising(to: 3)
        let symbol: String = self.symbol + "³"
        
        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Sendable

extension Length: Sendable {}
