// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Temperature Measure ApproximatelyEquatable Tests")
internal struct TemperatureMeasureApproximatelyEquatableTests {
    private typealias TemperatureMeasure = Measure<ThermodynamicTemperature>

    @Test(
        "Approximate equality succeeds",
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
    internal func approximateEqualitySucceeds(
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
