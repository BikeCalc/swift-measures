// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for substance amount.
@MetricUnits(name: "mole", symbol: "mol")
public struct SubstanceAmount {
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

extension SubstanceAmount: Codable {}

// MARK: - Comparable

extension SubstanceAmount: Comparable {}

// MARK: - Divisible

extension SubstanceAmount {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - Parameter time: A unit of time.
    /// - Returns: A unit of catalytic activity.
    public func dividing(by time: Time) -> CatalyticActivity {
        let coefficient: Double = self.coefficient * (1 / time.coefficient)
        let symbol: String = self.symbol + "/" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension SubstanceAmount: Equatable {}

// MARK: - Hashable

extension SubstanceAmount: Hashable {}

// MARK: - Measurable

extension SubstanceAmount: Measurable {
    public static let base: Self = .mole
}

// MARK: - Sendable

extension SubstanceAmount: Sendable {}
