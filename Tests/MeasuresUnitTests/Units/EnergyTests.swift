// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Energy Tests")
internal struct EnergyTests {
    internal init() {}

    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Dividing by Mass returns AbsorbedDose",
        arguments: [
            (.millijoule, .megagram, .init(coefficient: 1e-6, symbol: "mJ/Mg")),
            (.joule, .kilogram, .init(coefficient: 1, symbol: "J/kg")),
            (.kilojoule, .gram, .init(coefficient: 1e+6, symbol: "kJ/g"))
        ] as Array<(Energy, Mass, AbsorbedDose)>
    )
    internal func dividingByMassReturnsAbsorbedDose(
        lhs: Energy,
        rhs: Mass,
        expected: AbsorbedDose
    ) {
        let result: AbsorbedDose = lhs / rhs
        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Dividing by Time returns Power",
        arguments: [
            (.millijoule, .kilosecond, .init(coefficient: 1e-6, symbol: "mJ/ks")),
            (.joule, .second, .init(coefficient: 1, symbol: "J/s")),
            (.kilojoule, .millisecond, .init(coefficient: 1e+6, symbol: "kJ/ms"))
        ] as Array<(Energy, Time, Power)>
    )
    internal func dividingByTimeReturnsPower(
        lhs: Energy,
        rhs: Time,
        expected: Power
    ) {
        let result: Power = lhs / rhs
        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
