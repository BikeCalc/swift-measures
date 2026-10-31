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
                Measure<ComposedUnit>(1, .meter),
                """
                Measure<ComposedUnit>(1.0, ComposedUnit(coefficient: 1.0, constant: 0.0, symbol: "m", dimension: \
                Dimension(length: 1, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
                substanceAmount: 0, luminousIntensity: 0)))
                """
            ),
            (
                Measure<ComposedUnit>(-1, .meter),
                """
                Measure<ComposedUnit>(-1.0, ComposedUnit(coefficient: 1.0, constant: 0.0, symbol: "m", dimension: \
                Dimension(length: 1, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
                substanceAmount: 0, luminousIntensity: 0)))
                """
            ),
            (
                Measure<ComposedUnit>(100, .centimeter),
                """
                Measure<ComposedUnit>(100.0, ComposedUnit(coefficient: 0.01, constant: 0.0, symbol: "cm", dimension: \
                Dimension(length: 1, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
                substanceAmount: 0, luminousIntensity: 0)))
                """
            ),
            (
                Measure<ComposedUnit>(1, .dimensionless),
                """
                Measure<ComposedUnit>(1.0, ComposedUnit(coefficient: 1.0, constant: 0.0, symbol: "", dimension: \
                Dimension(length: 0, mass: 0, time: 0, electricCurrent: 0, thermodynamicTemperature: 0, \
                substanceAmount: 0, luminousIntensity: 0)))
                """
            )
        ]
    )
    internal func debugDescriptionSucceeds(
        value: Measure<ComposedUnit>,
        result: String
    ) {
        #expect(value.debugDescription == result)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureCustomDebugStringConvertibleTests {}
