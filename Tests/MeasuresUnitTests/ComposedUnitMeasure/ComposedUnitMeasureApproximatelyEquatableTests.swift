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
                .init(1, .meter),
                .init(100, .centimeter),
                .init(0, .meter),
                0.0,
                true
            ),
            (
                .init(100.02, .centimeter),
                .init(1, .meter),
                .init(0.5, .millimeter),
                0.0,
                true
            ),
            (
                .init(1, .meter),
                .init(100.02, .centimeter),
                .init(0.5, .millimeter),
                0.0,
                true
            ),
            (
                .init(100.02, .centimeter),
                .init(1, .meter),
                .init(0.1, .millimeter),
                0.0,
                false
            ),
            (
                .init(100, .centimeter),
                .init(1.01, .meter),
                .init(0, .meter),
                0.01,
                true
            ),
            (
                .init(100, .centimeter),
                .init(1.02, .meter),
                .init(0, .meter),
                0.01,
                false
            ),
            (
                .init(0.1 + 0.2, .meter),
                .init(0.3, .meter),
                .init(0.001, .millimeter),
                0.0,
                true
            ),
            (
                .init(0.1 + 0.2, .meter),
                .init(0.3, .meter),
                .init(0, .meter),
                0.0,
                false
            ),
            (
                .init(1, .dimensionless),
                .init(1, .dimensionless),
                .init(0, .dimensionless),
                0.0,
                true
            ),
            (
                .init(1, .dimensionless),
                .init(1.01, .dimensionless),
                .init(0.02, .dimensionless),
                0.0,
                true
            ),
            (
                .init(1, .dimensionless),
                .init(1.02, .dimensionless),
                .init(0.01, .dimensionless),
                0.0,
                false
            ),
            (
                .init(1, .dimensionless),
                .init(1, .cancelledMeters),
                .init(0, .dimensionless),
                0.0,
                true
            )
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>, Measure<ComposedUnit>, Double, Bool)>
    )
    internal func approximateEqualitySucceeds(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        absoluteTolerance: Measure<ComposedUnit>,
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

extension ComposedUnitMeasureApproximatelyEquatableTests {
    // TODO: Implement NaT tests for this suite.
}
