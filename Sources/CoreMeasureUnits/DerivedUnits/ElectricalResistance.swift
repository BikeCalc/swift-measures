// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for electrical resistance.
@MetricUnits(name: "ohm", symbol: "Ω")
public struct ElectricalResistance {
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

extension ElectricalResistance: Codable {}

// MARK: - Comparable

extension ElectricalResistance: Comparable {}

// MARK: - Equatable

extension ElectricalResistance: Equatable {}

// MARK: - Hashable

extension ElectricalResistance: Hashable {}

// MARK: - Measurable

extension ElectricalResistance: Measurable {
    public static let base: Self = .ohm
}

// MARK: - Multipliable

extension ElectricalResistance {
    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - Parameter time: A unit of time.
    /// - Returns: A unit of electrical inductance.
    public func multiplying(by time: Time) -> ElectricalInductance {
        let coefficient: Double = self.coefficient * time.coefficient
        let symbol: String = self.symbol + "⋅" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Sendable

extension ElectricalResistance: Sendable {}
