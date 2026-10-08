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

    public let dimension: Dimension = .init(
        length: -2,
        mass: -1,
        time: 3,
        electricCurrent: 2
    )
}

// MARK: - Codable

extension ElectricConductance: Codable {}

// MARK: - Comparable

extension ElectricConductance: Comparable {}

// MARK: - ComposableUnit

extension ElectricConductance: ComposableUnit {}

// MARK: - DefinedUnit

extension ElectricConductance: DefinedUnit {
    public static let base: Self = .siemens
}

// MARK: - Equatable

extension ElectricConductance: Equatable {}

// MARK: - Hashable

extension ElectricConductance: Hashable {}

// MARK: - Sendable

extension ElectricConductance: Sendable {}
