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

    public let dimension: Dimension = .init(time: -1)

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

// MARK: - CanonicallyEquatable

extension Radioactivity: CanonicallyEquatable {}

// MARK: - CaseIterable

extension Radioactivity: CaseIterable {
    /// The predefined units, excluding the duplicate base alias and custom units.
    ///
    /// Metric units appear from largest to smallest prefix, followed by other units in source declaration order.
    public static let allCases: Array<Self> = [
        .quettabecquerel,
        .ronnabecquerel,
        .yottabecquerel,
        .zettabecquerel,
        .exabecquerel,
        .petabecquerel,
        .terabecquerel,
        .gigabecquerel,
        .megabecquerel,
        .kilobecquerel,
        .hectobecquerel,
        .decabecquerel,
        .becquerel,
        .decibecquerel,
        .centibecquerel,
        .millibecquerel,
        .microbecquerel,
        .nanobecquerel,
        .picobecquerel,
        .femtobecquerel,
        .attobecquerel,
        .zeptobecquerel,
        .yoctobecquerel,
        .rontobecquerel,
        .quectobecquerel
    ]
}

// MARK: - Codable

extension Radioactivity: Codable {}

// MARK: - Comparable

extension Radioactivity: Comparable {}

// MARK: - ComposableUnit

extension Radioactivity: ComposableUnit {}

// MARK: - DefinedUnit

extension Radioactivity: DefinedUnit {
    public static let base: Self = .becquerel
}

// MARK: - Equatable

extension Radioactivity: Equatable {}

// MARK: - Hashable

extension Radioactivity: Hashable {}

// MARK: - Sendable

extension Radioactivity: Sendable {}
