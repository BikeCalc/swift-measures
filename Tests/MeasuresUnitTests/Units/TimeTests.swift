// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Time Tests")
internal struct TimeTests {
    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Multiplying by ElectricCurrent returns ElectricCharge",
        arguments: [
            (.millisecond, .milliampere, .init(coefficient: 1e-6, symbol: "mA⋅ms")),
            (.second, .ampere, .init(coefficient: 1, symbol: "A⋅s")),
            (.kilosecond, .kiloampere, .init(coefficient: 1e+6, symbol: "kA⋅ks"))
        ] as Array<(Time, ElectricCurrent, ElectricCharge)>
    )
    internal func multiplyingByElectricCurrentReturnsElectricCharge(
        lhs: Time,
        rhs: ElectricCurrent,
        expected: ElectricCharge
    ) {
        let result: ElectricCharge = lhs * rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Multiplying by ElectricPotential returns MagneticFlux",
        arguments: [
            (.millisecond, .millivolt, .init(coefficient: 1e-6, symbol: "mV⋅ms")),
            (.second, .volt, .init(coefficient: 1, symbol: "V⋅s")),
            (.kilosecond, .kilovolt, .init(coefficient: 1e+6, symbol: "kV⋅ks"))
        ] as Array<(Time, ElectricPotential, MagneticFlux)>
    )
    internal func multiplyingByElectricPotentialReturnsMagneticFlux(
        lhs: Time,
        rhs: ElectricPotential,
        expected: MagneticFlux
    ) {
        let result: MagneticFlux = lhs * rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Multiplying by Power returns Energy",
        arguments: [
            (.millisecond, .milliwatt, .init(coefficient: 1e-6, symbol: "mW⋅ms")),
            (.second, .watt, .init(coefficient: 1, symbol: "W⋅s")),
            (.kilosecond, .kilowatt, .init(coefficient: 1e+6, symbol: "kW⋅ks"))
        ] as Array<(Time, Power, Energy)>
    )
    internal func multiplyingByPowerReturnsEnergy(
        lhs: Time,
        rhs: Power,
        expected: Energy
    ) {
        let result: Energy = lhs * rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
