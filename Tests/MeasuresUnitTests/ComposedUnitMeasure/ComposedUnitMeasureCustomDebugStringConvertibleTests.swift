// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure CustomDebugStringConvertible Tests")
internal struct ComposedUnitMeasureCustomDebugStringConvertibleTests {
    internal init() {}

    @Test(
        "Debug description succeeds",
        arguments: [
            (
                .init(1, .meter),
                """
                Measure<ComposedUnit>(1.0, ComposedUnit(coefficient: 1.0, constant: 0.0, symbol: "m", dimension: \
                Dimension(length: 1, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
                substanceAmount: 0, luminousIntensity: 0)))
                """
            ),
            (
                .init(-1, .meter),
                """
                Measure<ComposedUnit>(-1.0, ComposedUnit(coefficient: 1.0, constant: 0.0, symbol: "m", dimension: \
                Dimension(length: 1, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
                substanceAmount: 0, luminousIntensity: 0)))
                """
            ),
            (
                .init(100, .centimeter),
                """
                Measure<ComposedUnit>(100.0, ComposedUnit(coefficient: 0.01, constant: 0.0, symbol: "cm", dimension: \
                Dimension(length: 1, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
                substanceAmount: 0, luminousIntensity: 0)))
                """
            ),
            (
                .init(1, .dimensionless),
                """
                Measure<ComposedUnit>(1.0, ComposedUnit(coefficient: 1.0, constant: 0.0, symbol: "", dimension: \
                Dimension(length: 0, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
                substanceAmount: 0, luminousIntensity: 0)))
                """
            )
        ] as Array<(Measure<ComposedUnit>, String)>
    )
    internal func debugDescriptionSucceeds(
        value: Measure<ComposedUnit>,
        expected: String
    ) {
        #expect(value.debugDescription == expected)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureCustomDebugStringConvertibleTests {
    @Test("NaT debug description preserves diagnostics")
    internal func natDebugDescriptionPreservesDiagnostics() {
        let value: Measure<ComposedUnit> = .nat
        let expected: String = """
            Measure<ComposedUnit>(nan, ComposedUnit(coefficient: nan, constant: nan, symbol: "NaT", dimension: \
            Dimension(length: 0, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
            substanceAmount: 0, luminousIntensity: 0)))
            """
        #expect(value.debugDescription == expected)
    }
}
