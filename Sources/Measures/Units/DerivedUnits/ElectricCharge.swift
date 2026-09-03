// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for electric charge.
public struct ElectricCharge {
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

    /// The ampere hour unit of electric charge.
    public static let ampereHour: Self = ElectricCurrent.ampere.multiplying(by: .hour)

    /// The milliampere-hour unit of electric charge.
    public static let milliampereHour: Self = ElectricCurrent.milliampere.multiplying(by: .hour)

    /// The ampere second unit of electric charge.
    public static let ampereSecond: Self = ElectricCurrent.ampere.multiplying(by: .second)

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

    /// The quettacoulomb unit of electric charge.
    public static let quettacoulomb: Self = .init(.quetta)

    /// The ronnacoulomb unit of electric charge.
    public static let ronnacoulomb: Self = .init(.ronna)

    /// The yottacoulomb unit of electric charge.
    public static let yottacoulomb: Self = .init(.yotta)

    /// The zettacoulomb unit of electric charge.
    public static let zettacoulomb: Self = .init(.zetta)

    /// The exacoulomb unit of electric charge.
    public static let exacoulomb: Self = .init(.exa)

    /// The petacoulomb unit of electric charge.
    public static let petacoulomb: Self = .init(.peta)

    /// The teracoulomb unit of electric charge.
    public static let teracoulomb: Self = .init(.tera)

    /// The gigacoulomb unit of electric charge.
    public static let gigacoulomb: Self = .init(.giga)

    /// The megacoulomb unit of electric charge.
    public static let megacoulomb: Self = .init(.mega)

    /// The kilocoulomb unit of electric charge.
    public static let kilocoulomb: Self = .init(.kilo)

    /// The hectocoulomb unit of electric charge.
    public static let hectocoulomb: Self = .init(.hecto)

    /// The decacoulomb unit of electric charge.
    public static let decacoulomb: Self = .init(.deca)

    /// The coulomb unit of electric charge.
    public static let coulomb: Self = .init(.none)

    /// The decicoulomb unit of electric charge.
    public static let decicoulomb: Self = .init(.deci)

    /// The centicoulomb unit of electric charge.
    public static let centicoulomb: Self = .init(.centi)

    /// The millicoulomb unit of electric charge.
    public static let millicoulomb: Self = .init(.milli)

    /// The microcoulomb unit of electric charge.
    public static let microcoulomb: Self = .init(.micro)

    /// The nanocoulomb unit of electric charge.
    public static let nanocoulomb: Self = .init(.nano)

    /// The picocoulomb unit of electric charge.
    public static let picocoulomb: Self = .init(.pico)

    /// The femtocoulomb unit of electric charge.
    public static let femtocoulomb: Self = .init(.femto)

    /// The attocoulomb unit of electric charge.
    public static let attocoulomb: Self = .init(.atto)

    /// The zeptocoulomb unit of electric charge.
    public static let zeptocoulomb: Self = .init(.zepto)

    /// The yoctocoulomb unit of electric charge.
    public static let yoctocoulomb: Self = .init(.yocto)

    /// The rontocoulomb unit of electric charge.
    public static let rontocoulomb: Self = .init(.ronto)

    /// The quectocoulomb unit of electric charge.
    public static let quectocoulomb: Self = .init(.quecto)
}

// MARK: - Codable

extension ElectricCharge: Codable {}

// MARK: - Comparable

extension ElectricCharge: Comparable {}

// MARK: - Divisible

extension ElectricCharge {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter electricPotential: A unit of electric potential.
    /// - returns: A unit of electrical capacitance.
    public func dividing(by electricPotential: ElectricPotential) -> ElectricalCapacitance {
        let coefficient: Double = self.coefficient * (1 / electricPotential.coefficient)
        let symbol: String = self.symbol + "/" + electricPotential.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }

    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter time: A unit of time.
    /// - returns: A unit of electric current.
    public func dividing(by time: Time) -> ElectricCurrent {
        let coefficient: Double = self.coefficient * (1 / time.coefficient)
        let symbol: String = self.symbol + "/" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension ElectricCharge: Equatable {}

// MARK: - Hashable

extension ElectricCharge: Hashable {}

// MARK: - Measurable

extension ElectricCharge: Measurable {
    public static let base: Self = .coulomb
}

// MARK: - Sendable

extension ElectricCharge: Sendable {}
