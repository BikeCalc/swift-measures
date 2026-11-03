// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure CustomDebugStringConvertible Tests")
internal struct LengthMeasureCustomDebugStringConvertibleTests {
    internal init() {}

    @Test(
        "Debug description succeeds",
        arguments: [
            (
                .init(1, .meter),
                """
                Measure<Length>(1.0, Length(coefficient: 1.0, constant: 0.0, symbol: "m", dimension: \
                Dimension(length: 1, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
                substanceAmount: 0, luminousIntensity: 0)))
                """
            ),
            (
                .init(-1, .meter),
                """
                Measure<Length>(-1.0, Length(coefficient: 1.0, constant: 0.0, symbol: "m", dimension: \
                Dimension(length: 1, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
                substanceAmount: 0, luminousIntensity: 0)))
                """
            ),
            (
                .init(100, .centimeter),
                """
                Measure<Length>(100.0, Length(coefficient: 0.01, constant: 0.0, symbol: "cm", dimension: \
                Dimension(length: 1, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
                substanceAmount: 0, luminousIntensity: 0)))
                """
            )
        ] as Array<(Measure<Length>, String)>
    )
    internal func debugDescriptionSucceeds(
        value: Measure<Length>,
        expected: String
    ) {
        #expect(value.debugDescription == expected)
    }
}

// MARK: - NaT

extension LengthMeasureCustomDebugStringConvertibleTests {
    @Test("NaT debug description preserves diagnostics")
    internal func natDebugDescriptionPreservesDiagnostics() {
        let value: Measure<Length> = .nat
        let expected: String = """
            Measure<Length>(nan, Length(coefficient: nan, constant: nan, symbol: "NaT", dimension: \
            Dimension(length: 1, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
            substanceAmount: 0, luminousIntensity: 0)))
            """
        #expect(value.debugDescription == expected)
    }
}
