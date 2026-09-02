// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for energy.
public struct Energy {
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

    /// The kilowatt year unit of energy.
    public static let kilowattYear: Self = Power.kilowatt.multiplying(by: .year)

    /// The kilowatt hour unit of energy.
    public static let kilowattHour: Self = Power.kilowatt.multiplying(by: .hour)

    /// The watt-hour unit of energy.
    public static let wattHour: Self = Power.watt.multiplying(by: .hour)

    /// The kilowatt second unit of energy.
    public static let kilowattSecond: Self = Power.kilowatt.multiplying(by: .second)

    /// The newton-meter unit of energy.
    public static let newtonMeter: Self = Force.newton.multiplying(by: .meter)

    /// The watt-second unit of energy.
    public static let wattSecond: Self = Power.watt.multiplying(by: .second)

    // MARK: Metric Units

    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    fileprivate init(_ prefix: MetricPrefix) {
        let symbol: String = prefix.symbol + "J"

        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }

    /// The quettajoule unit of energy.
    public static let quettajoule: Self = .init(.quetta)

    /// The ronnajoule unit of energy.
    public static let ronnajoule: Self = .init(.ronna)

    /// The yottajoule unit of energy.
    public static let yottajoule: Self = .init(.yotta)

    /// The zettajoule unit of energy.
    public static let zettajoule: Self = .init(.zetta)

    /// The exajoule unit of energy.
    public static let exajoule: Self = .init(.exa)

    /// The petajoule unit of energy.
    public static let petajoule: Self = .init(.peta)

    /// The terajoule unit of energy.
    public static let terajoule: Self = .init(.tera)

    /// The gigajoule unit of energy.
    public static let gigajoule: Self = .init(.giga)

    /// The megajoule unit of energy.
    public static let megajoule: Self = .init(.mega)

    /// The kilojoule unit of energy.
    public static let kilojoule: Self = .init(.kilo)

    /// The hectojoule unit of energy.
    public static let hectojoule: Self = .init(.hecto)

    /// The decajoule unit of energy.
    public static let decajoule: Self = .init(.deca)

    /// The joule unit of energy.
    public static let joule: Self = .init(.none)

    /// The decijoule unit of energy.
    public static let decijoule: Self = .init(.deci)

    /// The centijoule unit of energy.
    public static let centijoule: Self = .init(.centi)

    /// The millijoule unit of energy.
    public static let millijoule: Self = .init(.milli)

    /// The microjoule unit of energy.
    public static let microjoule: Self = .init(.micro)

    /// The nanojoule unit of energy.
    public static let nanojoule: Self = .init(.nano)

    /// The picojoule unit of energy.
    public static let picojoule: Self = .init(.pico)

    /// The femtojoule unit of energy.
    public static let femtojoule: Self = .init(.femto)

    /// The attojoule unit of energy.
    public static let attojoule: Self = .init(.atto)

    /// The zeptojoule unit of energy.
    public static let zeptojoule: Self = .init(.zepto)

    /// The yoctojoule unit of energy.
    public static let yoctojoule: Self = .init(.yocto)

    /// The rontojoule unit of energy.
    public static let rontojoule: Self = .init(.ronto)

    /// The quectojoule unit of energy.
    public static let quectojoule: Self = .init(.quecto)

    // MARK: U.S. Customary and Imperial Units

    /// The foot-pound-force unit of energy.
    public static let footPoundForce: Self = .init(
        coefficient: Force.poundForce.coefficient * Length.foot.coefficient,
        symbol: "ft·lbf"
    )

    /// The British thermal unit based on the International Table calorie.
    public static let britishThermalUnitInternationalTable: Self = .init(
        coefficient: 1_055.05585262,
        symbol: "Btu (IT)"
    )

    // MARK: Other Units

    /// The kilocalorie unit of energy.
    public static let kilocalorie: Self = .init(
        coefficient: Self.calorie.coefficient * 1_000,
        symbol: "kcal"
    )

    /// The calorie unit of energy.
    public static let calorie: Self = .init(
        coefficient: 4.184,
        symbol: "cal"
    )
}

// MARK: - Codable

extension Energy: Codable {}

// MARK: - Comparable

extension Energy: Comparable {}

// MARK: - Equatable

extension Energy: Equatable {}

// MARK: - Hashable

extension Energy: Hashable {}

// MARK: - Measurable

extension Energy: Measurable {
    public static let base: Self = .joule
}

// MARK: - Divisible

extension Energy {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter time: A unit of time.
    /// - returns: A unit of power.
    public func dividing(by time: Time) -> Power {
        let coefficient: Double = self.coefficient * (1 / time.coefficient)
        let symbol: String = self.symbol + "/" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Sendable

extension Energy: Sendable {}
