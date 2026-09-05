// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for electric conductance.
@MetricUnits(name: "siemens", symbol: "S")
public struct ElectricConductance {
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

extension ElectricConductance: Codable {}

// MARK: - Comparable

extension ElectricConductance: Comparable {}

// MARK: - Equatable

extension ElectricConductance: Equatable {}

// MARK: - Hashable

extension ElectricConductance: Hashable {}

// MARK: - Measurable

extension ElectricConductance: Measurable {
    public static let base: Self = .siemens
}

// MARK: - Sendable

extension ElectricConductance: Sendable {}
