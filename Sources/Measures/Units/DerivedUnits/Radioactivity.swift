// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

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
