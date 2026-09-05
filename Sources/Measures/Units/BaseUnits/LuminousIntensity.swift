// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for luminous intensity.
@MetricUnits(name: "candela", symbol: "cd")
public struct LuminousIntensity {
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

extension LuminousIntensity: Codable {}

// MARK: - Comparable

extension LuminousIntensity: Comparable {}

// MARK: - Equatable

extension LuminousIntensity: Equatable {}

// MARK: - Hashable

extension LuminousIntensity: Hashable {}

// MARK: - Measurable

extension LuminousIntensity: Measurable {
    public static let base: Self = .candela
}

// MARK: - Sendable

extension LuminousIntensity: Sendable {}
