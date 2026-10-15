// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for radioactivity.
@MetricUnits(name: "becquerel", symbol: "Bq")
public struct Radioactivity {
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

    /// Creates a unit of radioactivity expressed in decays per the specified time unit.
    ///
    /// - Parameter time: The time unit used as the denominator.
    internal init(per time: Time) {
        self.init(
            coefficient: 1 / time.coefficient,
            symbol: "1/" + time.symbol
        )
    }
}

// MARK: - Codable

extension Radioactivity: Codable {}

// MARK: - Comparable

extension Radioactivity: Comparable {}

// MARK: - Equatable

extension Radioactivity: Equatable {}

// MARK: - Hashable

extension Radioactivity: Hashable {}

// MARK: - Measurable

extension Radioactivity: Measurable {
    public static let base: Self = .becquerel
}

// MARK: - Sendable

extension Radioactivity: Sendable {}
