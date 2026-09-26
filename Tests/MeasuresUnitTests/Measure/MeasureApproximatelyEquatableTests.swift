// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Measure ApproximatelyEquatable Tests")
internal struct MeasureApproximatelyEquatableTests {
    private typealias LengthMeasure = Measure<Length>
    private typealias TemperatureMeasure = Measure<ThermodynamicTemperature>

    @Test(
        "Approximate equality with lengths succeeds",
        arguments: [
            (LengthMeasure(1, .meter), LengthMeasure(100, .centimeter), LengthMeasure(0, .meter), 0, true),
            (LengthMeasure(100.02, .centimeter), LengthMeasure(1, .meter), LengthMeasure(0.5, .millimeter), 0, true),
            (LengthMeasure(1, .meter), LengthMeasure(100.02, .centimeter), LengthMeasure(0.5, .millimeter), 0, true),
            (LengthMeasure(100.02, .centimeter), LengthMeasure(1, .meter), LengthMeasure(0.1, .millimeter), 0, false),
            (LengthMeasure(100, .centimeter), LengthMeasure(1.01, .meter), LengthMeasure(0, .meter), 0.01, true),
            (LengthMeasure(100, .centimeter), LengthMeasure(1.02, .meter), LengthMeasure(0, .meter), 0.01, false),
            (LengthMeasure(0.1 + 0.2, .meter), LengthMeasure(0.3, .meter), LengthMeasure(0.001, .millimeter), 0, true),
            (LengthMeasure(0.1 + 0.2, .meter), LengthMeasure(0.3, .meter), LengthMeasure(0, .meter), 0, false)
        ]
    )
    internal func approximateEqualityWithLengthsSucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        absoluteTolerance: Measure<Length>,
        relativeTolerance: Double,
        result: Bool
    ) {
        #expect(
            lhs.isApproximatelyEqual(
                to: rhs,
                absoluteTolerance: absoluteTolerance,
                relativeTolerance: relativeTolerance
            ) == result
        )
    }

    @Test(
        "Approximate equality with temperatures succeeds",
        arguments: [
            (TemperatureMeasure(0, .celsius), TemperatureMeasure(1, .celsius), 0, true),
            (TemperatureMeasure(0, .celsius), TemperatureMeasure(0.5, .celsius), 0, false),
            (TemperatureMeasure(0, .celsius), TemperatureMeasure(1.8, .fahrenheit), 0, true),
            (TemperatureMeasure(0, .celsius), TemperatureMeasure(0.9, .fahrenheit), 0, false),
            (TemperatureMeasure(0, .celsius), TemperatureMeasure(0, .celsius), 0.01, true),
            (TemperatureMeasure(273.15, .kelvin), TemperatureMeasure(0, .celsius), 0.01, true),
            (TemperatureMeasure(0, .celsius), TemperatureMeasure(0, .celsius), 0.001, false),
            (TemperatureMeasure(273.15, .kelvin), TemperatureMeasure(0, .celsius), 0.001, false)
        ]
    )
    internal func approximateEqualityWithTemperaturesSucceeds(
        lhs: Measure<ThermodynamicTemperature>,
        absoluteTolerance: Measure<ThermodynamicTemperature>,
        relativeTolerance: Double,
        result: Bool
    ) {
        let rhs: Measure<ThermodynamicTemperature> = .init(274.15, .kelvin)

        #expect(
            lhs.isApproximatelyEqual(
                to: rhs,
                absoluteTolerance: absoluteTolerance,
                relativeTolerance: relativeTolerance
            ) == result
        )
    }
}
