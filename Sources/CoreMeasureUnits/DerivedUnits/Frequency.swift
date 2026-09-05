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
}

// MARK: - Codable

extension Frequency: Codable {}

// MARK: - Comparable

extension Frequency: Comparable {}

// MARK: - Equatable

extension Frequency: Equatable {}

// MARK: - Hashable

extension Frequency: Hashable {}

// MARK: - Measurable

extension Frequency: Measurable {
    public static let base: Self = .hertz
}

// MARK: - Sendable

extension Frequency: Sendable {}

// MARK: - Measure

extension Measure
where Unit == Frequency {
    /// Returns this measure converted to the specified unit of time.
    ///
    /// ```swift
    /// let measure: Measure<Frequency> = .init(1, .hertz).converted(to: .second)
    /// print(measure)
    /// // Prints "1.0 s"
    /// ```
    ///
    /// - Parameter rhs: The unit of time to convert to.
    /// - Returns: The converted measure of time.
    public func converted(to rhs: Time) -> Measure<Time> {
        let baseValue: Double = self.value * self.unit.coefficient + self.unit.constant
        let newValue: Double = (baseValue - rhs.constant) / rhs.coefficient

        return .init(1 / newValue, rhs)
    }
}
