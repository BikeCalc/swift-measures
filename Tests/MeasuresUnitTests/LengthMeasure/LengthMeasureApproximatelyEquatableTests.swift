// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure ApproximatelyEquatable Tests")
internal struct LengthMeasureApproximatelyEquatableTests {
    internal init() {}

    @Test(
        "Approximate equality succeeds",
        arguments: [
            (
                Measure<Length>(1, .meter),
                Measure<Length>(100, .centimeter),
                Measure<Length>(0, .meter),
                0,
                true
            ),
            (
                Measure<Length>(100.02, .centimeter),
                Measure<Length>(1, .meter),
                Measure<Length>(0.5, .millimeter),
                0,
                true
            ),
            (
                Measure<Length>(1, .meter),
                Measure<Length>(100.02, .centimeter),
                Measure<Length>(0.5, .millimeter),
                0,
                true
            ),
            (
                Measure<Length>(100.02, .centimeter),
                Measure<Length>(1, .meter),
                Measure<Length>(0.1, .millimeter),
                0,
                false
            ),
            (
                Measure<Length>(100, .centimeter),
                Measure<Length>(1.01, .meter),
                Measure<Length>(0, .meter),
                0.01,
                true
            ),
            (
                Measure<Length>(100, .centimeter),
                Measure<Length>(1.02, .meter),
                Measure<Length>(0, .meter),
                0.01,
                false
            ),
            (
                Measure<Length>(0.1 + 0.2, .meter),
                Measure<Length>(0.3, .meter),
                Measure<Length>(0.001, .millimeter),
                0,
                true
            ),
            (
                Measure<Length>(0.1 + 0.2, .meter),
                Measure<Length>(0.3, .meter),
                Measure<Length>(0, .meter),
                0,
                false
            )
        ]
    )
    internal func approximateEqualitySucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        absoluteTolerance: Measure<Length>,
        relativeTolerance: Double,
        expected: Bool
    ) {
        let result: Bool = lhs.isApproximatelyEqual(
            to: rhs,
            absoluteTolerance: absoluteTolerance,
            relativeTolerance: relativeTolerance
        )
        #expect(result == expected)
    }
}

// MARK: - NaT

extension LengthMeasureApproximatelyEquatableTests {
    // TODO: Implement NaT tests for this suite.
}
