// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Measure CustomDebugStringConvertible Tests")
internal struct MeasureCustomDebugStringConvertibleTests {
    @Test(
        "Debug description succeeds",
        arguments: [
            (
                Measure<Length>(1, .meter),
                "Measure<Length>(1.0, CoreMeasureUnits.Length(coefficient: 1.0, constant: 0.0, symbol: \"m\"))"
            ),
            (
                Measure<Length>(-1, .meter),
                "Measure<Length>(-1.0, CoreMeasureUnits.Length(coefficient: 1.0, constant: 0.0, symbol: \"m\"))"
            ),
            (
                Measure<Length>(100, .centimeter),
                "Measure<Length>(100.0, CoreMeasureUnits.Length(coefficient: 0.01, constant: 0.0, symbol: \"cm\"))"
            )
        ]
    )
    internal func debugDescriptionSucceeds(
        value: Measure<Length>,
        result: String
    ) {
        #expect(value.debugDescription == result)
    }
}
