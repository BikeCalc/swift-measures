// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Length Measure ApproximatelyEquatable Tests")
internal struct LengthMeasureApproximatelyEquatableTests {
    private typealias LengthMeasure = Measure<Length>

    @Test(
        "Approximate equality succeeds",
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
    internal func approximateEqualitySucceeds(
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
}
