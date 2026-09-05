// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for time.
@MetricUnits(name: "second", symbol: "s")
public struct Time {
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

    // MARK: Other Units

    /// The millennium unit of time.
    public static let millennium: Self = .init(
        coefficient: 3.1556952e+10,
        symbol: "mil"
    )

    /// The century unit of time.
    public static let century: Self = .init(
        coefficient: 3.1556952e+9,
        symbol: "cent"
    )

    /// The decade unit of time.
    public static let decade: Self = .init(
        coefficient: 3.1556952e+8,
        symbol: "dec"
    )

    /// The year unit of time.
    public static let year: Self = .init(
        coefficient: 3.1556952e+7,
        symbol: "yr"
    )

    /// The quarter unit of time.
    public static let quarter: Self = .init(
        coefficient: 7.889238e+6,
        symbol: "qr"
    )

    /// The month unit of time.
    public static let month: Self = .init(
        coefficient: 2.629746e+6,
        symbol: "mo"
    )

    /// The week unit of time.
    public static let week: Self = .init(
        coefficient: 6.04800e+5,
        symbol: "wk"
    )

    /// The day unit of time.
    public static let day: Self = .init(
        coefficient: 8.64e+4,
        symbol: "day"
    )

    /// The hour unit of time.
    public static let hour: Self = .init(
        coefficient: 3.6e+3,
        symbol: "h"
    )

    /// The minute unit of time.
    public static let minute: Self = .init(
        coefficient: 6e+1,
        symbol: "min"
    )
}

// MARK: - Codable

extension Time: Codable {}

// MARK: - Comparable

extension Time: Comparable {}

// MARK: - Equatable

extension Time: Equatable {}

// MARK: - Hashable

extension Time: Hashable {}

// MARK: - Measurable

extension Time: Measurable {
    public static let base: Self = .second
}

// MARK: - Sendable

extension Time: Sendable {}
