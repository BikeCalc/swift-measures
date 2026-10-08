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

    public let dimension: Dimension = .init(time: -1)
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
