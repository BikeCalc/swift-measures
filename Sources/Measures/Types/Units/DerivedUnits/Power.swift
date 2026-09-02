// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for power.
public struct Power {
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

    /// The joule per second unit of power.
    public static let joulePerSecond: Self = Energy.joule.dividing(by: .second)

    // MARK: Metric Units

    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    fileprivate init(_ prefix: MetricPrefix) {
        let symbol: String = prefix.symbol + "W"

        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }

    /// The quettawatt unit of power.
    public static let quettawatt: Self = .init(.quetta)

    /// The ronnawatt unit of power.
    public static let ronnawatt: Self = .init(.ronna)

    /// The yottawatt unit of power.
    public static let yottawatt: Self = .init(.yotta)

    /// The zettawatt unit of power.
    public static let zettawatt: Self = .init(.zetta)

    /// The exawatt unit of power.
    public static let exawatt: Self = .init(.exa)

    /// The petawatt unit of power.
    public static let petawatt: Self = .init(.peta)

    /// The terawatt unit of power.
    public static let terawatt: Self = .init(.tera)

    /// The gigawatt unit of power.
    public static let gigawatt: Self = .init(.giga)

    /// The megawatt unit of power.
    public static let megawatt: Self = .init(.mega)

    /// The kilowatt unit of power.
    public static let kilowatt: Self = .init(.kilo)

    /// The hectowatt unit of power.
    public static let hectowatt: Self = .init(.hecto)

    /// The decawatt unit of power.
    public static let decawatt: Self = .init(.deca)

    /// The watt unit of power.
    public static let watt: Self = .init(.none)

    /// The deciwatt unit of power.
    public static let deciwatt: Self = .init(.deci)

    /// The centiwatt unit of power.
    public static let centiwatt: Self = .init(.centi)

    /// The milliwatt unit of power.
    public static let milliwatt: Self = .init(.milli)

    /// The microwatt unit of power.
    public static let microwatt: Self = .init(.micro)

    /// The nanowatt unit of power.
    public static let nanowatt: Self = .init(.nano)

    /// The picowatt unit of power.
    public static let picowatt: Self = .init(.pico)

    /// The femtowatt unit of power.
    public static let femtowatt: Self = .init(.femto)

    /// The attowatt unit of power.
    public static let attowatt: Self = .init(.atto)

    /// The zeptowatt unit of power.
    public static let zeptowatt: Self = .init(.zepto)

    /// The yoctowatt unit of power.
    public static let yoctowatt: Self = .init(.yocto)

    /// The rontowatt unit of power.
    public static let rontowatt: Self = .init(.ronto)

    /// The quectowatt unit of power.
    public static let quectowatt: Self = .init(.quecto)

    // MARK: U.S. Customary and Imperial Units

    /// The mechanical horsepower unit of power.
    public static let mechanicalHorsepower: Self = .init(
        coefficient: Energy.footPoundForce.coefficient * 550,
        symbol: "hp"
    )
}

// MARK: - Codable

extension Power: Codable {}

// MARK: - Comparable

extension Power: Comparable {}

// MARK: - Multipliable

extension Power {
    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - parameter time: A unit of time.
    /// - returns: A unit of energy.
    public func multiplying(by time: Time) -> Energy {
        let coefficient: Double = self.coefficient * time.coefficient
        let symbol: String = self.symbol + "⋅" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension Power: Equatable {}

// MARK: - Hashable

extension Power: Hashable {}

// MARK: - Measurable

extension Power: Measurable {
    public static let base: Self = .watt
}

// MARK: - Sendable

extension Power: Sendable {}
