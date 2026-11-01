// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ThermodynamicTemperature Measure ApproximatelyEquatable Tests")
internal struct TemperatureMeasureApproximatelyEquatableTests {
    internal init() {}

    @Test(
        "Approximate equality succeeds",
        arguments: [
            (
                Measure<ThermodynamicTemperature>(0, .celsius),
                Measure<ThermodynamicTemperature>(1, .celsius),
                0,
                true
            ),
            (
                Measure<ThermodynamicTemperature>(0, .celsius),
                Measure<ThermodynamicTemperature>(0.5, .celsius),
                0,
                false
            ),
            (
                Measure<ThermodynamicTemperature>(0, .celsius),
                Measure<ThermodynamicTemperature>(1.8, .fahrenheit),
                0,
                true
            ),
            (
                Measure<ThermodynamicTemperature>(0, .celsius),
                Measure<ThermodynamicTemperature>(0.9, .fahrenheit),
                0,
                false
            ),
            (
                Measure<ThermodynamicTemperature>(0, .celsius),
                Measure<ThermodynamicTemperature>(0, .celsius),
                0.01,
                true
            ),
            (
                Measure<ThermodynamicTemperature>(273.15, .kelvin),
                Measure<ThermodynamicTemperature>(0, .celsius),
                0.01,
                true
            ),
            (
                Measure<ThermodynamicTemperature>(0, .celsius),
                Measure<ThermodynamicTemperature>(0, .celsius),
                0.001,
                false
            ),
            (
                Measure<ThermodynamicTemperature>(273.15, .kelvin),
                Measure<ThermodynamicTemperature>(0, .celsius),
                0.001,
                false
            )
        ]
    )
    internal func approximateEqualitySucceeds(
        lhs: Measure<ThermodynamicTemperature>,
        absoluteTolerance: Measure<ThermodynamicTemperature>,
        relativeTolerance: Double,
        expected: Bool
    ) {
        let rhs: Measure<ThermodynamicTemperature> = .init(274.15, .kelvin)
        let result: Bool = lhs.isApproximatelyEqual(
            to: rhs,
            absoluteTolerance: absoluteTolerance,
            relativeTolerance: relativeTolerance
        )
        #expect(result == expected)
    }
}
