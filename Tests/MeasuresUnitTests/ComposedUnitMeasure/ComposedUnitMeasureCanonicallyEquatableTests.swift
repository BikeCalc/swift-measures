// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure CanonicallyEquatable Tests")
internal struct ComposedUnitMeasureCanonicallyEquatableTests {
    internal init() {}

    @Test(
        "Canonical equality succeeds",
        arguments: [
            (Measure<ComposedUnit>(1, .meter), Measure<ComposedUnit>(1, .meter), true),
            (Measure<ComposedUnit>(1, .meter), Measure<ComposedUnit>(100, .centimeter), true),
            (Measure<ComposedUnit>(100, .centimeter), Measure<ComposedUnit>(1, .meter), true),
            (Measure<ComposedUnit>(1, .foot), Measure<ComposedUnit>(12, .inch), true),
            (Measure<ComposedUnit>(12, .inch), Measure<ComposedUnit>(1, .foot), true),
            (Measure<ComposedUnit>(-1, .meter), Measure<ComposedUnit>(-100, .centimeter), true),
            (Measure<ComposedUnit>(0, .meter), Measure<ComposedUnit>(0, .foot), true),
            (Measure<ComposedUnit>(1, .meter), Measure<ComposedUnit>(99, .centimeter), false),
            (Measure<ComposedUnit>(1, .foot), Measure<ComposedUnit>(13, .inch), false),
            (Measure<ComposedUnit>(-1, .meter), Measure<ComposedUnit>(100, .centimeter), false),
            (Measure<ComposedUnit>(1, .dimensionless), Measure<ComposedUnit>(1, .dimensionless), true),
            (Measure<ComposedUnit>(1, .dimensionless), Measure<ComposedUnit>(2, .dimensionless), false),
            (Measure<ComposedUnit>(-1, .dimensionless), Measure<ComposedUnit>(-1, .dimensionless), true),
            (Measure<ComposedUnit>(1, .dimensionless), Measure<ComposedUnit>(1, .cancelledMeters), true)
        ]
    )
    internal func canonicalEqualitySucceeds(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        result: Bool
    ) {
        #expect(lhs.isCanonicallyEqual(to: rhs) == result)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureCanonicallyEquatableTests {
    // TODO: Implement NaT tests for this suite.
}
