// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for magnetic flux.
public struct MagneticFlux {
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

    /// The volt-second unit of magnetic flux.
    public static let voltSecond: Self = ElectricPotential.volt.multiplying(by: .second)

    // MARK: Metric Units

    /// Creates a new instance with the specified metric prefix.
    ///
    /// - parameter prefix: The prefix.
    fileprivate init(_ prefix: MetricPrefix) {
        let symbol: String = prefix.symbol + "Wb"

        self.init(
            coefficient: prefix.coefficient,
            symbol: symbol
        )
    }

    /// The quettaweber unit of magnetic flux.
    public static let quettaweber: Self = .init(.quetta)

    /// The ronnaweber unit of magnetic flux.
    public static let ronnaweber: Self = .init(.ronna)

    /// The yottaweber unit of magnetic flux.
    public static let yottaweber: Self = .init(.yotta)

    /// The zettaweber unit of magnetic flux.
    public static let zettaweber: Self = .init(.zetta)

    /// The exaweber unit of magnetic flux.
    public static let exaweber: Self = .init(.exa)

    /// The petaweber unit of magnetic flux.
    public static let petaweber: Self = .init(.peta)

    /// The teraweber unit of magnetic flux.
    public static let teraweber: Self = .init(.tera)

    /// The gigaweber unit of magnetic flux.
    public static let gigaweber: Self = .init(.giga)

    /// The megaweber unit of magnetic flux.
    public static let megaweber: Self = .init(.mega)

    /// The kiloweber unit of magnetic flux.
    public static let kiloweber: Self = .init(.kilo)

    /// The hectoweber unit of magnetic flux.
    public static let hectoweber: Self = .init(.hecto)

    /// The decaweber unit of magnetic flux.
    public static let decaweber: Self = .init(.deca)

    /// The weber unit of magnetic flux.
    public static let weber: Self = .init(.none)

    /// The deciweber unit of magnetic flux.
    public static let deciweber: Self = .init(.deci)

    /// The centiweber unit of magnetic flux.
    public static let centiweber: Self = .init(.centi)

    /// The milliweber unit of magnetic flux.
    public static let milliweber: Self = .init(.milli)

    /// The microweber unit of magnetic flux.
    public static let microweber: Self = .init(.micro)

    /// The nanoweber unit of magnetic flux.
    public static let nanoweber: Self = .init(.nano)

    /// The picoweber unit of magnetic flux.
    public static let picoweber: Self = .init(.pico)

    /// The femtoweber unit of magnetic flux.
    public static let femtoweber: Self = .init(.femto)

    /// The attoweber unit of magnetic flux.
    public static let attoweber: Self = .init(.atto)

    /// The zeptoweber unit of magnetic flux.
    public static let zeptoweber: Self = .init(.zepto)

    /// The yoctoweber unit of magnetic flux.
    public static let yoctoweber: Self = .init(.yocto)

    /// The rontoweber unit of magnetic flux.
    public static let rontoweber: Self = .init(.ronto)

    /// The quectoweber unit of magnetic flux.
    public static let quectoweber: Self = .init(.quecto)
}

// MARK: - Codable

extension MagneticFlux: Codable {}

// MARK: - Comparable

extension MagneticFlux: Comparable {}

// MARK: - Divisible

extension MagneticFlux {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter area: A unit of area.
    /// - returns: A unit of magnetic flux density.
    public func dividing(by area: Area) -> MagneticFluxDensity {
        let coefficient: Double = self.coefficient * (1 / area.coefficient)
        let symbol: String = self.symbol + "/" + area.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }

    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter electricCurrent: A unit of electric current.
    /// - returns: A unit of electrical inductance.
    public func dividing(by electricCurrent: ElectricCurrent) -> ElectricalInductance {
        let coefficient: Double = self.coefficient * (1 / electricCurrent.coefficient)
        let symbol: String = self.symbol + "/" + electricCurrent.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension MagneticFlux: Equatable {}

// MARK: - Hashable

extension MagneticFlux: Hashable {}

// MARK: - Measurable

extension MagneticFlux: Measurable {
    public static let base: Self = .weber
}

// MARK: - Sendable

extension MagneticFlux: Sendable {}
