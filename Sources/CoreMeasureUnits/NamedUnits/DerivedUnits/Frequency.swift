// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for frequency.
@MetricUnits(name: "hertz", symbol: "Hz")
public struct Frequency {
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

    public let dimension: Dimension = .init(time: -1)

    /// Creates a unit of frequency expressed in cycles per the specified time unit.
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

extension Frequency: Codable {}

// MARK: - Comparable

extension Frequency: Comparable {}

// MARK: - ComposableUnit

extension Frequency: ComposableUnit {}

// MARK: - DefinedUnit

extension Frequency: DefinedUnit {
    public static let base: Self = .hertz
}

// MARK: - Equatable

extension Frequency: Equatable {}

// MARK: - Hashable

extension Frequency: Hashable {}

// MARK: - Sendable

extension Frequency: Sendable {}
