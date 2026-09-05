// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for luminous flux.
@MetricUnits(name: "lumen", symbol: "lm")
public struct LuminousFlux {
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

extension LuminousFlux: Codable {}

// MARK: - Comparable

extension LuminousFlux: Comparable {}

// MARK: - Divisible

extension LuminousFlux {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - Parameter area: A unit of area.
    /// - Returns: A unit of illuminance.
    public func dividing(by area: Area) -> Illuminance {
        let coefficient: Double = self.coefficient * (1 / area.coefficient)
        let symbol: String = self.symbol + "/" + area.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension LuminousFlux: Equatable {}

// MARK: - Hashable

extension LuminousFlux: Hashable {}

// MARK: - Measurable

extension LuminousFlux: Measurable {
    public static let base: Self = .lumen
}

// MARK: - Sendable

extension LuminousFlux: Sendable {}
