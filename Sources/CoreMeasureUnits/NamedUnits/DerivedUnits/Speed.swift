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

/// A unit of measure for speed.
@CaseIterableUnits
public struct Speed {
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
        time: -1
    )

    /// Creates a unit of speed from the specified units.
    ///
    /// The coefficient and symbol are formed by dividing the length unit by the time unit.
    ///
    /// - Parameters:
    ///   - length: The length unit.
    ///   - time: The time unit.
    internal init(
        length: Length,
        time: Time
    ) {
        self.init(
            coefficient: length.coefficient * (1 / time.coefficient),
            symbol: length.symbol + "/" + time.symbol
        )
    }

    /// Returns a unit of acceleration by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The speed unit.
    ///   - rhs: The time unit.
    /// - Returns: A unit of acceleration.
    public static func / (
        lhs: Self,
        rhs: Time
    ) -> Acceleration {
        return .init(
            speed: lhs,
            time: rhs
        )
    }

    // MARK: Customary and Imperial Units

    /// The miles per hour unit of speed.
    public static let milesPerHour: Self = .init(
        length: .mile,
        time: .hour
    )

    /// The feet per second unit of speed.
    public static let feetPerSecond: Self = .init(
        length: .foot,
        time: .second
    )

    // MARK: Metric Units

    /// The kilometers per hour unit of speed.
    public static let kilometersPerHour: Self = .init(
        length: .kilometer,
        time: .hour
    )

    /// The meter per second unit of speed.
    public static let metersPerSecond: Self = .init(
        length: .meter,
        time: .second
    )

    /// The centimeters per second unit of speed.
    public static let centimetersPerSecond: Self = .init(
        length: .centimeter,
        time: .second
    )

    // MARK: Other Units

    /// The knot unit of speed.
    public static let knot: Self = .init(
        length: .nauticalMile,
        time: .hour
    )
}

// MARK: - CanonicallyEquatable

extension Speed: CanonicallyEquatable {}

// MARK: - Codable

extension Speed: Codable {}

// MARK: - Comparable

extension Speed: Comparable {}

// MARK: - ComposableUnit

extension Speed: ComposableUnit {}

// MARK: - DefinedUnit

extension Speed: DefinedUnit {
    public static let base: Self = .metersPerSecond
}

// MARK: - Equatable

extension Speed: Equatable {}

// MARK: - Hashable

extension Speed: Hashable {}

// MARK: - Sendable

extension Speed: Sendable {}
