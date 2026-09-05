// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import MeasuresMacro

/// A unit of measure for pressure.
@MetricUnits(name: "pascal", symbol: "Pa")
public struct Pressure {
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

    /// The pounds per square inch unit of pressure.
    public static let poundsPerSquareInch: Self = .init(
        coefficient: Force.poundForce.coefficient / Area.squareInch.coefficient,
        symbol: "psi"
    )

    /// The pounds per square foot unit of pressure.
    public static let poundsPerSquareFoot: Self = Force.poundForce.dividing(by: .squareFoot)

    /// The newtons per square meter unit of pressure.
    public static let newtonsPerSquareMeter: Self = Force.newton.dividing(by: .squareMeter)

    // MARK: Other Metric Units

    /// The bar unit of energy.
    public static let bar: Self = .init(
        coefficient: 1e+5,
        symbol: "bar"
    )

    /// The millibar unit of energy.
    public static let millibar: Self = .init(
        coefficient: 1e+2,
        symbol: "mbar"
    )

    // MARK: Other Units

    /// The atmosphere unit of energy.
    public static let atmosphere: Self = .init(
        coefficient: 1.01325e+5,
        symbol: "atm"
    )

    /// The bar unit of energy.
    public static let torr: Self = .init(
        coefficient: Self.atmosphere.coefficient / 760,
        symbol: "Torr"
    )

    /// The millitorr unit of energy.
    public static let millitorr: Self = .init(
        coefficient: Self.torr.coefficient * 1e-3,
        symbol: "mTorr"
    )
}

// MARK: - Codable

extension Pressure: Codable {}

// MARK: - Comparable

extension Pressure: Comparable {}

// MARK: - Equatable

extension Pressure: Equatable {}

// MARK: - Hashable

extension Pressure: Hashable {}

// MARK: - Measurable

extension Pressure: Measurable {
    public static let base: Self = .pascal
}

// MARK: - Sendable

extension Pressure: Sendable {}
