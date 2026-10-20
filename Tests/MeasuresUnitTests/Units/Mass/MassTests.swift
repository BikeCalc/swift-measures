// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Mass Tests")
internal struct MassTests {
    internal init() {}

    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Multiplying by Acceleration returns Force",
        arguments: [
            (.gram, .init(coefficient: 1e-3, symbol: "mm/s²"), .init(coefficient: 1e-6, symbol: "g·mm/s²")),
            (.kilogram, .meterPerSquareSecond, .init(coefficient: 1, symbol: "kg·m/s²")),
            (.megagram, .init(coefficient: 1e+3, symbol: "km/s²"), .init(coefficient: 1e+6, symbol: "Mg·km/s²"))
        ] as Array<(Mass, Acceleration, Force)>
    )
    internal func multiplyingByAccelerationReturnsForce(
        lhs: Mass,
        rhs: Acceleration,
        expected: Force
    ) {
        let result: Force = lhs * rhs
        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Dividing by Area returns SurfaceDensity",
        arguments: [
            (.gram, .squareKilometer, .init(coefficient: 1e-9, symbol: "g/km²")),
            (.kilogram, .squareMeter, .init(coefficient: 1, symbol: "kg/m²")),
            (.megagram, .squareMillimeter, .init(coefficient: 1e+9, symbol: "Mg/mm²"))
        ] as Array<(Mass, Area, SurfaceDensity)>
    )
    internal func dividingByAreaReturnsSurfaceDensity(
        lhs: Mass,
        rhs: Area,
        expected: SurfaceDensity
    ) {
        let result: SurfaceDensity = lhs / rhs
        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Dividing by SubstanceAmount returns MolarMass",
        arguments: [
            (.gram, .kilomole, .init(coefficient: 1e-6, symbol: "g/kmol")),
            (.kilogram, .mole, .init(coefficient: 1, symbol: "kg/mol")),
            (.megagram, .millimole, .init(coefficient: 1e+6, symbol: "Mg/mmol"))
        ] as Array<(Mass, SubstanceAmount, MolarMass)>
    )
    internal func dividingBySubstanceAmountReturnsMolarMass(
        lhs: Mass,
        rhs: SubstanceAmount,
        expected: MolarMass
    ) {
        let result: MolarMass = lhs / rhs
        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Dividing by Volume returns Concentration",
        arguments: [
            (.gram, .cubicKilometer, .init(coefficient: 1e-12, symbol: "g/km³")),
            (.kilogram, .cubicMeter, .init(coefficient: 1, symbol: "kg/m³")),
            (.megagram, .cubicMillimeter, .init(coefficient: 1e+12, symbol: "Mg/mm³"))
        ] as Array<(Mass, Volume, Concentration)>
    )
    internal func dividingByVolumeReturnsConcentration(
        lhs: Mass,
        rhs: Volume,
        expected: Concentration
    ) {
        let result: Concentration = lhs / rhs
        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
