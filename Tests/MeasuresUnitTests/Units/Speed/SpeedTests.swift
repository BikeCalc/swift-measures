// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Speed Tests")
internal struct SpeedTests {
    internal init() {}

    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Dividing by Time returns Acceleration",
        arguments: [
            (.init(coefficient: 1e-3, symbol: "mm/s"), .kilosecond, .init(coefficient: 1e-6, symbol: "mm/s/ks")),
            (.metersPerSecond, .second, .init(coefficient: 1, symbol: "m/s/s")),
            (.init(coefficient: 1e+3, symbol: "km/s"), .millisecond, .init(coefficient: 1e+6, symbol: "km/s/ms"))
        ] as Array<(Speed, Time, Acceleration)>
    )
    internal func dividingByTimeReturnsAcceleration(
        lhs: Speed,
        rhs: Time,
        expected: Acceleration
    ) {
        let result: Acceleration = lhs / rhs
        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
