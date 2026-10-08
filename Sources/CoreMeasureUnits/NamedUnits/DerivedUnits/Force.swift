// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for force.
@MetricUnits(name: "newton", symbol: "N")
public struct Force {
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
        length: 1,
        mass: 1,
        time: -2
    )

    /// Creates a unit of force from the specified units.
    ///
    /// The coefficient and symbol are formed by multiplying the mass unit by the acceleration unit.
    ///
    /// - Parameters:
    ///   - mass: The mass unit.
    ///   - acceleration: The acceleration unit.
    internal init(
        mass: Mass,
        acceleration: Acceleration
    ) {
        self.init(
            coefficient: mass.coefficient * acceleration.coefficient,
            symbol: mass.symbol + "·" + acceleration.symbol
        )
    }

    /// Returns a unit of energy by multiplying the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The force unit.
    ///   - rhs: The length unit.
    /// - Returns: A unit of energy.
    public static func * (
        lhs: Self,
        rhs: Length
    ) -> Energy {
        return .init(
            force: lhs,
            length: rhs
        )
    }

    /// Returns a unit of pressure by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The force unit.
    ///   - rhs: The area unit.
    /// - Returns: A unit of pressure.
    public static func / (
        lhs: Self,
        rhs: Area
    ) -> Pressure {
        return .init(
            force: lhs,
            area: rhs
        )
    }

    // MARK: Composed Units

    /// The kilogram-meter per square second unit of force.
    public static let kilogramMeterPerSquareSecond: Self = .init(
        mass: .kilogram,
        acceleration: .meterPerSquareSecond
    )

    // MARK: U.S. Customary and Imperial Units

    /// The pound-force unit of force.
    public static let poundForce: Self = .init(
        coefficient: Mass.pound.coefficient * 9.80665,
        symbol: "lbf"
    )

    // MARK: Other Units

    /// The gravity unit of force.
    public static let gravity: Self = .init(
        coefficient: 9.80665 * Mass.kilogram.coefficient,
        symbol: "G"
    )
}

// MARK: - Codable

extension Force: Codable {}

// MARK: - Comparable

extension Force: Comparable {}

// MARK: - ComposableUnit

extension Force: ComposableUnit {}

// MARK: - DefinedUnit

extension Force: DefinedUnit {
    public static let base: Self = .newton
}

// MARK: - Equatable

extension Force: Equatable {}

// MARK: - Hashable

extension Force: Hashable {}

// MARK: - Sendable

extension Force: Sendable {}
