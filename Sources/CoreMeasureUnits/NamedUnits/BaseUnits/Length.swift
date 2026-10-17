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

/// A unit of measure for length.
@MetricUnits(name: "meter", symbol: "m")
public struct Length {
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

    public let dimension: Dimension = .init(length: 1)

    /// Returns a unit of energy by multiplying the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The length unit.
    ///   - rhs: The force unit.
    /// - Returns: A unit of energy.
    public static func * (
        lhs: Self,
        rhs: Force
    ) -> Energy {
        return .init(
            force: rhs,
            length: lhs
        )
    }

    /// Returns a unit of speed by dividing the specified units.
    ///
    /// - Parameters:
    ///   - lhs: The length unit.
    ///   - rhs: The time unit.
    /// - Returns: A unit of speed.
    public static func / (
        lhs: Self,
        rhs: Time
    ) -> Speed {
        return .init(
            length: lhs,
            time: rhs
        )
    }

    // MARK: Astronomical Units

    /// The parsec unit of length.
    public static let parsec: Self = .init(
        coefficient: 3.086e+16,
        symbol: "pc"
    )

    /// The light year unit of length.
    public static let lightYear: Self = .init(
        coefficient: 9.4607e+15,
        symbol: "ly"
    )

    /// The astronomical unit unit of length.
    public static let astronomicalUnit: Self = .init(
        coefficient: 1.496e+11,
        symbol: "au"
    )

    // MARK: Customary and Imperial Units

    /// The nautical league unit of length.
    public static let nauticalLeague: Self = .init(
        coefficient: Self.nauticalMile.coefficient * 3,
        symbol: "nlea"
    )

    /// The league unit of length.
    public static let league: Self = .init(
        coefficient: Self.mile.coefficient * 3,
        symbol: "lea"
    )

    /// The nautical mile unit of length.
    public static let nauticalMile: Self = .init(
        coefficient: 1.852e+3,
        symbol: "nmi"
    )

    /// The mile unit of length.
    public static let mile: Self = .init(
        coefficient: 1.609344e+3,
        symbol: "mi"
    )

    /// The cable unit of length.
    public static let cable: Self = .init(
        coefficient: Self.nauticalMile.coefficient / 10,
        symbol: "cb"
    )

    /// The furlong unit of length.
    public static let furlong: Self = .init(
        coefficient: 2.01168e+2,
        symbol: "fur"
    )

    /// The chain unit of length.
    public static let chain: Self = .init(
        coefficient: Self.inch.coefficient * 792,
        symbol: "ch"
    )

    /// The rod unit of length.
    public static let rod: Self = .init(
        coefficient: Self.inch.coefficient * 198,
        symbol: "rd"
    )

    /// The fathom unit of length.
    public static let fathom: Self = .init(
        coefficient: Self.inch.coefficient * 72,
        symbol: "ftm"
    )

    /// The yard unit of length.
    public static let yard: Self = .init(
        coefficient: Self.inch.coefficient * 36,
        symbol: "yd"
    )

    /// The foot unit of length.
    public static let foot: Self = .init(
        coefficient: Self.inch.coefficient * 12,
        symbol: "ft"
    )

    /// The link unit of length.
    public static let link: Self = .init(
        coefficient: 2.01168e-1,
        symbol: "li"
    )

    /// The inch unit of length.
    public static let inch: Self = .init(
        coefficient: 2.54e-2,
        symbol: "in"
    )

    /// The pica unit of length.
    public static let pica: Self = .init(
        coefficient: Self.inch.coefficient / 6,
        symbol: "pc"
    )

    /// The point unit of length.
    public static let point: Self = .init(
        coefficient: Self.inch.coefficient / 72,
        symbol: "pt"
    )

    /// The thou unit of length.
    public static let thou: Self = .init(
        coefficient: Self.inch.coefficient / 1_000,
        symbol: "th"
    )
}

// MARK: - CanonicallyEquatable

extension Length: CanonicallyEquatable {}

// MARK: - CaseIterable

extension Length: CaseIterable {
    /// The predefined units, excluding the duplicate base alias and custom units.
    ///
    /// Metric units appear from largest to smallest prefix, followed by other units in source declaration order.
    public static let allCases: Array<Self> = [
        .quettameter,
        .ronnameter,
        .yottameter,
        .zettameter,
        .exameter,
        .petameter,
        .terameter,
        .gigameter,
        .megameter,
        .kilometer,
        .hectometer,
        .decameter,
        .meter,
        .decimeter,
        .centimeter,
        .millimeter,
        .micrometer,
        .nanometer,
        .picometer,
        .femtometer,
        .attometer,
        .zeptometer,
        .yoctometer,
        .rontometer,
        .quectometer,
        .parsec,
        .lightYear,
        .astronomicalUnit,
        .nauticalLeague,
        .league,
        .nauticalMile,
        .mile,
        .cable,
        .furlong,
        .chain,
        .rod,
        .fathom,
        .yard,
        .foot,
        .link,
        .inch,
        .pica,
        .point,
        .thou
    ]
}

// MARK: - Codable

extension Length: Codable {}

// MARK: - Comparable

extension Length: Comparable {}

// MARK: - ComposableUnit

extension Length: ComposableUnit {}

// MARK: - DefinedUnit

extension Length: DefinedUnit {
    public static let base: Self = .meter
}

// MARK: - Equatable

extension Length: Equatable {}

// MARK: - Hashable

extension Length: Hashable {}

// MARK: - Sendable

extension Length: Sendable {}
