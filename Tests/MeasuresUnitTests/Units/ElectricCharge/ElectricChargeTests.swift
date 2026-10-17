// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("ElectricCharge Tests")
internal struct ElectricChargeTests {
    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Dividing by ElectricPotential returns ElectricalCapacitance",
        arguments: [
            (.millicoulomb, .kilovolt, .init(coefficient: 1e-6, symbol: "mC/kV")),
            (.coulomb, .volt, .init(coefficient: 1, symbol: "C/V")),
            (.kilocoulomb, .millivolt, .init(coefficient: 1e+6, symbol: "kC/mV"))
        ] as Array<(ElectricCharge, ElectricPotential, ElectricalCapacitance)>
    )
    internal func dividingByElectricPotentialReturnsElectricalCapacitance(
        lhs: ElectricCharge,
        rhs: ElectricPotential,
        expected: ElectricalCapacitance
    ) {
        let result: ElectricalCapacitance = lhs / rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Dividing by Time returns ElectricCurrent",
        arguments: [
            (.millicoulomb, .kilosecond, .init(coefficient: 1e-6, symbol: "mC/ks")),
            (.coulomb, .second, .init(coefficient: 1, symbol: "C/s")),
            (.kilocoulomb, .millisecond, .init(coefficient: 1e+6, symbol: "kC/ms"))
        ] as Array<(ElectricCharge, Time, ElectricCurrent)>
    )
    internal func dividingByTimeReturnsElectricCurrent(
        lhs: ElectricCharge,
        rhs: Time,
        expected: ElectricCurrent
    ) {
        let result: ElectricCurrent = lhs / rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
