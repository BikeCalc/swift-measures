// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for absorbed dose.
@MetricUnits(name: "gray", symbol: "Gy")
public struct AbsorbedDose {
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
        length: 2,
        time: -2
    )

    // MARK: Composed Units

    /// The joule per kilogram unit of absorbed dose.
    public static let joulePerKilogram: Self = Energy.joule.dividing(by: .kilogram)
}

// MARK: - Codable

extension AbsorbedDose: Codable {}

// MARK: - Comparable

extension AbsorbedDose: Comparable {}

// MARK: - ComposableUnit

extension AbsorbedDose: ComposableUnit {}

// MARK: - DefinedUnit

extension AbsorbedDose: DefinedUnit {
    public static let base: Self = .gray
}

// MARK: - Equatable

extension AbsorbedDose: Equatable {}

// MARK: - Hashable

extension AbsorbedDose: Hashable {}

// MARK: - Sendable

extension AbsorbedDose: Sendable {}
