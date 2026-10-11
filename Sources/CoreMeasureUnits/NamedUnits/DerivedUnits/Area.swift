// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import NumericsExtended

/// A unit of measure for area.
public struct Area {
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

    public let dimension: Dimension = .init(length: 2)

    /// Creates a unit of area by squaring the specified length unit.
    ///
    /// - Parameter length: The length unit to square.
    internal init(squaring length: Length) {
        self.init(
            coefficient: length.coefficient * length.coefficient,
            symbol: length.symbol + "²"
        )
    }

    // MARK: Composed Units

    /// The square mile unit of area.
    public static let squareMile: Self = .init(squaring: .mile)

    /// The square kilometer unit of area.
    public static let squareKilometer: Self = .init(squaring: .kilometer)

    /// The square meter unit of area.
    public static let squareMeter: Self = .init(squaring: .meter)

    /// The square yard unit of area.
    public static let squareYard: Self = .init(squaring: .yard)

    /// The square foot unit of area.
    public static let squareFoot: Self = .init(squaring: .foot)

    /// The square inch unit of area.
    public static let squareInch: Self = .init(squaring: .inch)

    /// The square centimeter unit of area.
    public static let squareCentimeter: Self = .init(squaring: .centimeter)

    /// The square millimeter unit of area.
    public static let squareMillimeter: Self = .init(squaring: .millimeter)

    // MARK: Customary and Imperial Units

    /// The acre unit of area.
    public static let acre: Self = .init(
        coefficient: Self(squaring: .chain).coefficient * 10,
        symbol: "ac"
    )

    /// The rood unit of area.
    public static let rood: Self = .init(
        coefficient: Self.perch.coefficient * 40,
        symbol: "roo"
    )

    /// The perch unit of area.
    public static let perch: Self = .init(squaring: .rod)

    // MARK: Customary Units

    /// The township unit of area.
    public static let township: Self = .init(
        coefficient: Self.squareMile.coefficient * 36,
        symbol: "twp"
    )

    // MARK: Other Metric Units

    /// The hectare unit of area.
    public static let hectare: Self = .init(
        coefficient: 1e+4,
        symbol: "ha"
    )

    /// The decare unit of area.
    public static let decare: Self = .init(
        coefficient: 1e+3,
        symbol: "daa"
    )

    /// The are unit of area.
    public static let are: Self = .init(
        coefficient: 1e+2,
        symbol: "a"
    )

    /// The centiare unit of area.
    public static let centiare: Self = .init(
        coefficient: 1,
        symbol: "ca"
    )
}

// MARK: - CanonicallyEquatable

extension Area: CanonicallyEquatable {}

// MARK: - Codable

extension Area: Codable {}

// MARK: - Comparable

extension Area: Comparable {}

// MARK: - ComposableUnit

extension Area: ComposableUnit {}

// MARK: - DefinedUnit

extension Area: DefinedUnit {
    public static let base: Self = .squareMeter
}

// MARK: - Equatable

extension Area: Equatable {}

// MARK: - Hashable

extension Area: Hashable {}

// MARK: - Sendable

extension Area: Sendable {}
