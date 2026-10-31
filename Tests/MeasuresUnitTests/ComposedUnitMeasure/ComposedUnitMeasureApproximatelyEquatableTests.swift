// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure ApproximatelyEquatable Tests")
internal struct ComposedUnitMeasureApproximatelyEquatableTests {
    internal init() {}

    @Test(
        "Approximate equality succeeds",
        arguments: [
            (
                Measure<ComposedUnit>(1, .meter),
                Measure<ComposedUnit>(100, .centimeter),
                Measure<ComposedUnit>(0, .meter),
                0,
                true
            ),
            (
                Measure<ComposedUnit>(100.02, .centimeter),
                Measure<ComposedUnit>(1, .meter),
                Measure<ComposedUnit>(0.5, .millimeter),
                0,
                true
            ),
            (
                Measure<ComposedUnit>(1, .meter),
                Measure<ComposedUnit>(100.02, .centimeter),
                Measure<ComposedUnit>(0.5, .millimeter),
                0,
                true
            ),
            (
                Measure<ComposedUnit>(100.02, .centimeter),
                Measure<ComposedUnit>(1, .meter),
                Measure<ComposedUnit>(0.1, .millimeter),
                0,
                false
            ),
            (
                Measure<ComposedUnit>(100, .centimeter),
                Measure<ComposedUnit>(1.01, .meter),
                Measure<ComposedUnit>(0, .meter),
                0.01,
                true
            ),
            (
                Measure<ComposedUnit>(100, .centimeter),
                Measure<ComposedUnit>(1.02, .meter),
                Measure<ComposedUnit>(0, .meter),
                0.01,
                false
            ),
            (
                Measure<ComposedUnit>(0.1 + 0.2, .meter),
                Measure<ComposedUnit>(0.3, .meter),
                Measure<ComposedUnit>(0.001, .millimeter),
                0,
                true
            ),
            (
                Measure<ComposedUnit>(0.1 + 0.2, .meter),
                Measure<ComposedUnit>(0.3, .meter),
                Measure<ComposedUnit>(0, .meter),
                0,
                false
            ),
            (
                Measure<ComposedUnit>(1, .dimensionless),
                Measure<ComposedUnit>(1, .dimensionless),
                Measure<ComposedUnit>(0, .dimensionless),
                0,
                true
            ),
            (
                Measure<ComposedUnit>(1, .dimensionless),
                Measure<ComposedUnit>(1.01, .dimensionless),
                Measure<ComposedUnit>(0.02, .dimensionless),
                0,
                true
            ),
            (
                Measure<ComposedUnit>(1, .dimensionless),
                Measure<ComposedUnit>(1.02, .dimensionless),
                Measure<ComposedUnit>(0.01, .dimensionless),
                0,
                false
            ),
            (
                Measure<ComposedUnit>(1, .dimensionless),
                Measure<ComposedUnit>(1, .cancelledMeters),
                Measure<ComposedUnit>(0, .dimensionless),
                0,
                true
            )
        ]
    )
    internal func approximateEqualitySucceeds(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        absoluteTolerance: Measure<ComposedUnit>,
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
}

// MARK: - NaT

extension ComposedUnitMeasureApproximatelyEquatableTests {
    // TODO: Implement NaT tests for this suite.
}
