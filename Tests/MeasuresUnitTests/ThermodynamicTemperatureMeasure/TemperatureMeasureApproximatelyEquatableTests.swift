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
                .init(0, .celsius),
                .init(1, .celsius),
                0.0,
                true
            ),
            (
                .init(0, .celsius),
                .init(0.5, .celsius),
                0.0,
                false
            ),
            (
                .init(0, .celsius),
                .init(1.8, .fahrenheit),
                0.0,
                true
            ),
            (
                .init(0, .celsius),
                .init(0.9, .fahrenheit),
                0.0,
                false
            ),
            (
                .init(0, .celsius),
                .init(0, .celsius),
                0.01,
                true
            ),
            (
                .init(273.15, .kelvin),
                .init(0, .celsius),
                0.01,
                true
            ),
            (
                .init(0, .celsius),
                .init(0, .celsius),
                0.001,
                false
            ),
            (
                .init(273.15, .kelvin),
                .init(0, .celsius),
                0.001,
                false
            )
        ] as Array<(Measure<ThermodynamicTemperature>, Measure<ThermodynamicTemperature>, Double, Bool)>
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
