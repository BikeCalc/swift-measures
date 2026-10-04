// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import CoreMeasureUnits

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

// MARK: - Codable

extension Cadence: Codable {
    private typealias CodingKeys = UnitCodingKeys

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Self.CodingKeys.self)
        self.init(
            coefficient: try container.decode(Double.self, forKey: .coefficient),
            constant: try container.decodeIfPresent(Double.self, forKey: .constant) ?? 0,
            symbol: try container.decode(String.self, forKey: .symbol)
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Self.CodingKeys.self)

        try container.encode(self.coefficient, forKey: .coefficient)
        try container.encode(self.constant, forKey: .constant)
        try container.encode(self.symbol, forKey: .symbol)
    }
}

// MARK: - Comparable

extension Cadence: Comparable {}

// MARK: - Equatable

extension Cadence: Equatable {}

// MARK: - Hashable

extension Cadence: Hashable {}

// MARK: - Unit

extension Cadence: Unit {
    public static let base: Self = .revolutionsPerSecond
}

// MARK: - Sendable

extension Cadence: Sendable {}
