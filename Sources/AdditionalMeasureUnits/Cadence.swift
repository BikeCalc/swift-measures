// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import CoreMeasureUnits
import NumericsExtended

/// A unit for measuring cadence.
public struct Cadence {
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

    /// Creates a unit of cadence expressed in revolutions per the specified time unit.
    ///
    /// - Parameter time: The time unit used for one revolution.
    private init(per time: Time) {
        self.init(
            coefficient: Time.base.coefficient / time.coefficient,
            symbol: "r/" + time.symbol
        )
    }

    // MARK: Other Units

    /// The revolutions per second unit of cadence.
    public static let revolutionsPerSecond: Self = .init(per: .second)

    /// The revolutions per minute unit of cadence.
    public static let revolutionsPerMinute: Self = .init(per: .minute)

    /// The revolutions per hour unit of cadence.
    public static let revolutionsPerHour: Self = .init(per: .hour)
}

// MARK: - CanonicallyEquatable

extension Cadence: CanonicallyEquatable {}

// MARK: - Codable

extension Cadence: Codable {}

// MARK: - Comparable

extension Cadence: Comparable {}

// MARK: - DefinedUnit

extension Cadence: DefinedUnit {
    public static let base: Self = .revolutionsPerSecond
}

// MARK: - Equatable

extension Cadence: Equatable {}

// MARK: - Hashable

extension Cadence: Hashable {}

// MARK: - Sendable

extension Cadence: Sendable {}
