// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Acceleration Tests")
internal struct AccelerationTests {
    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Multiplying by Mass returns Force",
        arguments: [
            (.init(coefficient: 1e-3, symbol: "mm/s²"), .gram, .init(coefficient: 1e-6, symbol: "g·mm/s²")),
            (.meterPerSquareSecond, .kilogram, .init(coefficient: 1, symbol: "kg·m/s²")),
            (.init(coefficient: 1e+3, symbol: "km/s²"), .megagram, .init(coefficient: 1e+6, symbol: "Mg·km/s²"))
        ] as Array<(Acceleration, Mass, Force)>
    )
    internal func multiplyingByMassReturnsForce(
        lhs: Acceleration,
        rhs: Mass,
        expected: Force
    ) {
        let result: Force = lhs * rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
