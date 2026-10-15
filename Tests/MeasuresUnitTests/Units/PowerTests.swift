// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Power Tests")
internal struct PowerTests {
    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Multiplying by Time returns Energy",
        arguments: [
            (.milliwatt, .millisecond, .init(coefficient: 1e-6, symbol: "mW⋅ms")),
            (.watt, .second, .init(coefficient: 1, symbol: "W⋅s")),
            (.kilowatt, .kilosecond, .init(coefficient: 1e+6, symbol: "kW⋅ks"))
        ] as Array<(Power, Time, Energy)>
    )
    internal func multiplyingByTimeReturnsEnergy(
        lhs: Power,
        rhs: Time,
        expected: Energy
    ) {
        let result: Energy = lhs * rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Dividing by ElectricCurrent returns ElectricPotential",
        arguments: [
            (.milliwatt, .kiloampere, .init(coefficient: 1e-6, symbol: "mW/kA")),
            (.watt, .ampere, .init(coefficient: 1, symbol: "W/A")),
            (.kilowatt, .milliampere, .init(coefficient: 1e+6, symbol: "kW/mA"))
        ] as Array<(Power, ElectricCurrent, ElectricPotential)>
    )
    internal func dividingByElectricCurrentReturnsElectricPotential(
        lhs: Power,
        rhs: ElectricCurrent,
        expected: ElectricPotential
    ) {
        let result: ElectricPotential = lhs / rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
