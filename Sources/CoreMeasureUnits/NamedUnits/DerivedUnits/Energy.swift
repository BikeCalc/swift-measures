// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro
import NumericsExtended

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

    public let dimension: Dimension = .init(
        length: 2,
        mass: 1,
        time: -2
    )

    /// Creates a unit of energy from the specified units.
    ///
    /// The coefficient and symbol are formed by multiplying the force unit by the length unit.
    ///
    /// - Parameters:
    ///   - force: The force unit.
    ///   - length: The length unit.
    internal init(
        force: Force,
        length: Length
    ) {
        self.init(
            coefficient: force.coefficient * length.coefficient,
            symbol: force.symbol + "·" + length.symbol
        )
    }

    /// Creates a unit of energy from the specified units.
    ///
    /// The coefficient and symbol are formed by multiplying the power unit by the time unit.
    ///
    /// - Parameters:
    ///   - power: The power unit.
    ///   - time: The time unit.
    internal init(
        power: Power,
        time: Time
    ) {
        self.init(
            coefficient: power.coefficient * time.coefficient,
            symbol: power.symbol + "·" + time.symbol
        )
    }

    /// Returns a unit of absorbed dose by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The energy unit.
    ///   - rhs: The mass unit.
    /// - Returns: A unit of absorbed dose.
    public static func / (
        lhs: Self,
        rhs: Mass
    ) -> AbsorbedDose {
        return .init(
            energy: lhs,
            mass: rhs
        )
    }

    /// Returns a unit of power by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The energy unit.
    ///   - rhs: The time unit.
    /// - Returns: A unit of power.
    public static func / (
        lhs: Self,
        rhs: Time
    ) -> Power {
        return .init(
            energy: lhs,
            time: rhs
        )
    }

    // MARK: Composed Units

    /// The kilowatt year unit of energy.
    public static let kilowattYear: Self = .init(
        power: .kilowatt,
        time: .year
    )

    /// The kilowatt hour unit of energy.
    public static let kilowattHour: Self = .init(
        power: .kilowatt,
        time: .hour
    )

    /// The watt-hour unit of energy.
    public static let wattHour: Self = .init(
        power: .watt,
        time: .hour
    )

    /// The kilowatt second unit of energy.
    public static let kilowattSecond: Self = .init(
        power: .kilowatt,
        time: .second
    )

    /// The newton-meter unit of energy.
    public static let newtonMeter: Self = .init(
        force: .newton,
        length: .meter
    )

    /// The watt-second unit of energy.
    public static let wattSecond: Self = .init(
        power: .watt,
        time: .second
    )

    // MARK: U.S. Customary and Imperial Units

    /// The foot-pound-force unit of energy.
    public static let footPoundForce: Self = .init(
        coefficient: Force.poundForce.coefficient * Length.foot.coefficient,
        symbol: Length.foot.symbol + "·" + Force.poundForce.symbol
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

// MARK: - CanonicallyEquatable

extension Energy: CanonicallyEquatable {}

// MARK: - Codable

extension Energy: Codable {}

// MARK: - Comparable

extension Energy: Comparable {}

// MARK: - ComposableUnit

extension Energy: ComposableUnit {}

// MARK: - DefinedUnit

extension Energy: DefinedUnit {
    public static let base: Self = .joule
}

// MARK: - Equatable

extension Energy: Equatable {}

// MARK: - Hashable

extension Energy: Hashable {}

// MARK: - Sendable

extension Energy: Sendable {}
