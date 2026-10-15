// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Force Tests")
internal struct ForceTests {
    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Multiplying by Length returns Energy",
        arguments: [
            (.millinewton, .millimeter, .init(coefficient: 1e-6, symbol: "mN⋅mm")),
            (.newton, .meter, .init(coefficient: 1, symbol: "N⋅m")),
            (.kilonewton, .kilometer, .init(coefficient: 1e+6, symbol: "kN⋅km"))
        ] as Array<(Force, Length, Energy)>
    )
    internal func multiplyingByLengthReturnsEnergy(
        lhs: Force,
        rhs: Length,
        expected: Energy
    ) {
        let result: Energy = lhs * rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }

    @Test(
        "Dividing by Area returns Pressure",
        arguments: [
            (.millinewton, .squareKilometer, .init(coefficient: 1e-9, symbol: "mN/km²")),
            (.newton, .squareMeter, .init(coefficient: 1, symbol: "N/m²")),
            (.kilonewton, .squareMillimeter, .init(coefficient: 1e+9, symbol: "kN/mm²"))
        ] as Array<(Force, Area, Pressure)>
    )
    internal func dividingByAreaReturnsPressure(
        lhs: Force,
        rhs: Area,
        expected: Pressure
    ) {
        let result: Pressure = lhs / rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
