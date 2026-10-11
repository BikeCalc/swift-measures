// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import NumericsExtended

/// A unit of measure for acceleration.
public struct Acceleration {
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
        time: -2
    )

    /// Creates a unit of acceleration from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the speed unit by the time unit.
    ///
    /// - Parameters:
    ///   - speed: The speed unit.
    ///   - time: The time unit.
    internal init(
        speed: Speed,
        time: Time
    ) {
        self.init(
            coefficient: speed.coefficient * (1 / time.coefficient),
            symbol: speed.symbol + "/" + time.symbol
        )
    }

    /// Creates a unit of acceleration by dividing a length unit by the square of a time unit.
    ///
    /// - Parameters:
    ///   - length: The length unit.
    ///   - time: The time unit to square before dividing.
    internal init(
        length: Length,
        perSquare time: Time
    ) {
        self.init(
            coefficient: length.coefficient / (time.coefficient * time.coefficient),
            symbol: length.symbol + "/" + time.symbol + "²"
        )
    }

    /// Returns a unit of force by multiplying the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The acceleration unit.
    ///   - rhs: The mass unit.
    /// - Returns: A unit of force.
    public static func * (
        lhs: Self,
        rhs: Mass
    ) -> Force {
        return .init(
            mass: rhs,
            acceleration: lhs
        )
    }

    // MARK: Composed Units

    /// The meter per square second unit of acceleration.
    public static let meterPerSquareSecond: Self = .init(
        length: .meter,
        perSquare: .second
    )

    /// The foot per square second unit of acceleration.
    public static let footPerSquareSecond: Self = .init(
        length: .foot,
        perSquare: .second
    )
}

// MARK: - CanonicallyEquatable

extension Acceleration: CanonicallyEquatable {}

// MARK: - Codable

extension Acceleration: Codable {}

// MARK: - Comparable

extension Acceleration: Comparable {}

// MARK: - ComposableUnit

extension Acceleration: ComposableUnit {}

// MARK: - DefinedUnit

extension Acceleration: DefinedUnit {
    public static let base: Self = .meterPerSquareSecond
}

// MARK: - Equatable

extension Acceleration: Equatable {}

// MARK: - Hashable

extension Acceleration: Hashable {}

// MARK: - Sendable

extension Acceleration: Sendable {}
