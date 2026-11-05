// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro
import NumericsExtended

/// A unit of measure for substance amount.
@CaseIterableUnits
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

    public let dimension: Dimension = .init(substanceAmount: 1)

    /// Returns a unit of catalytic activity by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The substance amount unit.
    ///   - rhs: The time unit.
    /// - Returns: A unit of catalytic activity.
    public static func / (
        lhs: Self,
        rhs: Time
    ) -> CatalyticActivity {
        return .init(
            substanceAmount: lhs,
            time: rhs
        )
    }
}

// MARK: - CanonicallyEquatable

extension SubstanceAmount: CanonicallyEquatable {}

// MARK: - Codable

extension SubstanceAmount: Codable {}

// MARK: - Comparable

extension SubstanceAmount: Comparable {}

// MARK: - ComposableUnit

extension SubstanceAmount: ComposableUnit {}

// MARK: - DefinedUnit

extension SubstanceAmount: DefinedUnit {
    public static let base: Self = .mole
}

// MARK: - Equatable

extension SubstanceAmount: Equatable {}

// MARK: - Hashable

extension SubstanceAmount: Hashable {}

// MARK: - Sendable

extension SubstanceAmount: Sendable {}
