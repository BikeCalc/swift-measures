// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit for measuring digital information.
@MetricUnits(name: "byte", symbol: "B", coefficient: 8)
@BinaryUnits(name: "byte", symbol: "B", coefficient: 8)
@MetricUnits(name: "bit", symbol: "b")
@BinaryUnits(name: "bit", symbol: "b")
public struct Memory {
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

extension Memory: Codable {}

// MARK: - Comparable

extension Memory: Comparable {}

// MARK: - Equatable

extension Memory: Equatable {}

// MARK: - Hashable

extension Memory: Hashable {}

// MARK: - Measurable

extension Memory: Measurable {
    public static let base: Self = .bit
}

// MARK: - Sendable

extension Memory: Sendable {}
