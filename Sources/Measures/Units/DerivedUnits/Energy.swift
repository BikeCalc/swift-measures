// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for energy.
@MetricUnits(name: "joule", symbol: "J")
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
    /// - parameter mass: A unit of mass.
    /// - returns: A unit of absorbed dose.
    public func dividing(by mass: Mass) -> AbsorbedDose {
        let coefficient: Double = self.coefficient * (1 / mass.coefficient)
        let symbol: String = self.symbol + "/" + mass.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }

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
