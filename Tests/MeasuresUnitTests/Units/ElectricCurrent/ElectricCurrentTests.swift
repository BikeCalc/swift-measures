// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("ElectricCurrent Tests")
internal struct ElectricCurrentTests {
    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Multiplying by Time returns ElectricCharge",
        arguments: [
            (.milliampere, .millisecond, .init(coefficient: 1e-6, symbol: "mA·ms")),
            (.ampere, .second, .init(coefficient: 1, symbol: "A·s")),
            (.kiloampere, .kilosecond, .init(coefficient: 1e+6, symbol: "kA·ks"))
        ] as Array<(ElectricCurrent, Time, ElectricCharge)>
    )
    internal func multiplyingByTimeReturnsElectricCharge(
        lhs: ElectricCurrent,
        rhs: Time,
        expected: ElectricCharge
    ) {
        let result: ElectricCharge = lhs * rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Dividing by ElectricPotential returns ElectricConductance",
        arguments: [
            (.milliampere, .kilovolt, .init(coefficient: 1e-6, symbol: "mA/kV")),
            (.ampere, .volt, .init(coefficient: 1, symbol: "A/V")),
            (.kiloampere, .millivolt, .init(coefficient: 1e+6, symbol: "kA/mV"))
        ] as Array<(ElectricCurrent, ElectricPotential, ElectricConductance)>
    )
    internal func dividingByElectricPotentialReturnsElectricConductance(
        lhs: ElectricCurrent,
        rhs: ElectricPotential,
        expected: ElectricConductance
    ) {
        let result: ElectricConductance = lhs / rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
