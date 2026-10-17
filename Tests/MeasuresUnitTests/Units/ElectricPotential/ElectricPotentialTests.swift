// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("ElectricPotential Tests")
internal struct ElectricPotentialTests {
    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Multiplying by Time returns MagneticFlux",
        arguments: [
            (.millivolt, .millisecond, .init(coefficient: 1e-6, symbol: "mV·ms")),
            (.volt, .second, .init(coefficient: 1, symbol: "V·s")),
            (.kilovolt, .kilosecond, .init(coefficient: 1e+6, symbol: "kV·ks"))
        ] as Array<(ElectricPotential, Time, MagneticFlux)>
    )
    internal func multiplyingByTimeReturnsMagneticFlux(
        lhs: ElectricPotential,
        rhs: Time,
        expected: MagneticFlux
    ) {
        let result: MagneticFlux = lhs * rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Dividing by ElectricCurrent returns ElectricalResistance",
        arguments: [
            (.millivolt, .kiloampere, .init(coefficient: 1e-6, symbol: "mV/kA")),
            (.volt, .ampere, .init(coefficient: 1, symbol: "V/A")),
            (.kilovolt, .milliampere, .init(coefficient: 1e+6, symbol: "kV/mA"))
        ] as Array<(ElectricPotential, ElectricCurrent, ElectricalResistance)>
    )
    internal func dividingByElectricCurrentReturnsElectricalResistance(
        lhs: ElectricPotential,
        rhs: ElectricCurrent,
        expected: ElectricalResistance
    ) {
        let result: ElectricalResistance = lhs / rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
