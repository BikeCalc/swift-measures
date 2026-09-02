// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

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

    // MARK: Composed Units

    /// The square mile unit of area.
    public static let squareMile: Self = Length.mile.squared()

    /// The square kilometer unit of area.
    public static let squareKilometer: Self = Length.kilometer.squared()

    /// The square meter unit of area.
    public static let squareMeter: Self = Length.meter.squared()

    /// The square yard unit of area.
    public static let squareYard: Self = Length.yard.squared()

    /// The square foot unit of area.
    public static let squareFoot: Self = Length.foot.squared()

    /// The square inch unit of area.
    public static let squareInch: Self = Length.inch.squared()

    /// The square centimeter unit of area.
    public static let squareCentimeter: Self = Length.centimeter.squared()

    /// The square millimeter unit of area.
    public static let squareMillimeter: Self = Length.millimeter.squared()

    // MARK: Customary and Imperial Units

    /// The acre unit of area.
    public static let acre: Self = .init(
        coefficient: Length.chain.squared().coefficient * 10,
        symbol: "ac"
    )

    /// The rood unit of area.
    public static let rood: Self = .init(
        coefficient: Self.perch.coefficient * 40,
        symbol: "roo"
    )

    /// The perch unit of area.
    public static let perch: Self = Length.rod.squared()

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

// MARK: - Codable

extension Area: Codable {}

// MARK: - Comparable

extension Area: Comparable {}

// MARK: - Equatable

extension Area: Equatable {}

// MARK: - Hashable

extension Area: Hashable {}

// MARK: - Measurable

extension Area: Measurable {
    public static let base: Self = .squareMeter
}

// MARK: - Multipliable

extension Area {
    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - parameter length: A unit of length.
    /// - returns: A unit of volume.
    public func multiplying(by length: Length) -> Volume {
        let coefficient: Double = self.coefficient * length.coefficient
        let symbol: String = self.symbol + "⋅" + length.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Sendable

extension Area: Sendable {}
