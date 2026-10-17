// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Length Tests")
internal struct LengthTests {
    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Multiplying by Force returns Energy",
        arguments: [
            (.millimeter, .millinewton, .init(coefficient: 1e-6, symbol: "mN·mm")),
            (.meter, .newton, .init(coefficient: 1, symbol: "N·m")),
            (.kilometer, .kilonewton, .init(coefficient: 1e+6, symbol: "kN·km"))
        ] as Array<(Length, Force, Energy)>
    )
    internal func multiplyingByForceReturnsEnergy(
        lhs: Length,
        rhs: Force,
        expected: Energy
    ) {
        let result: Energy = lhs * rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Dividing by Time returns Speed",
        arguments: [
            (.millimeter, .kilosecond, .init(coefficient: 1e-6, symbol: "mm/ks")),
            (.meter, .second, .init(coefficient: 1, symbol: "m/s")),
            (.kilometer, .millisecond, .init(coefficient: 1e+6, symbol: "km/ms"))
        ] as Array<(Length, Time, Speed)>
    )
    internal func dividingByTimeReturnsSpeed(
        lhs: Length,
        rhs: Time,
        expected: Speed
    ) {
        let result: Speed = lhs / rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
