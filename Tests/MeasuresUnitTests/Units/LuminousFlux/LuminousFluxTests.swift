// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("LuminousFlux Tests")
internal struct LuminousFluxTests {
    // TODO: Use Double.isApproximatelyEqual when Numerics Extended provides its conformance.
    private let accuracy: Double = 1e-12

    @Test(
        "Dividing by Area returns Illuminance",
        arguments: [
            (.millilumen, .squareKilometer, .init(coefficient: 1e-9, symbol: "mlm/km²")),
            (.lumen, .squareMeter, .init(coefficient: 1, symbol: "lm/m²")),
            (.kilolumen, .squareMillimeter, .init(coefficient: 1e+9, symbol: "klm/mm²"))
        ] as Array<(LuminousFlux, Area, Illuminance)>
    )
    internal func dividingByAreaReturnsIlluminance(
        lhs: LuminousFlux,
        rhs: Area,
        expected: Illuminance
    ) {
        let result: Illuminance = lhs / rhs

        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
