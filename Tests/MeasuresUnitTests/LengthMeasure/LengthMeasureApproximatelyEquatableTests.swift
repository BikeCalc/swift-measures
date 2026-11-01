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
            (.init(1, .meter), .init(100, .centimeter), .init(0, .meter), 0.0, true),
            (.init(100.02, .centimeter), .init(1, .meter), .init(0.5, .millimeter), 0.0, true),
            (.init(1, .meter), .init(100.02, .centimeter), .init(0.5, .millimeter), 0.0, true),
            (.init(100.02, .centimeter), .init(1, .meter), .init(0.1, .millimeter), 0.0, false),
            (.init(100, .centimeter), .init(1.01, .meter), .init(0, .meter), 0.01, true),
            (.init(100, .centimeter), .init(1.02, .meter), .init(0, .meter), 0.01, false),
            (.init(0.1 + 0.2, .meter), .init(0.3, .meter), .init(0.001, .millimeter), 0.0, true),
            (.init(0.1 + 0.2, .meter), .init(0.3, .meter), .init(0, .meter), 0.0, false)
        ] as Array<(Measure<Length>, Measure<Length>, Measure<Length>, Double, Bool)>
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
    @Test(
        "NaT is not approximately equal",
        arguments: [
            (.nat, .init(1, .meter)),
            (.init(1, .meter), .nat),
            (.nat, .nat),
            (.invalid, .init(1, .meter)),
            (.init(1, .meter), .invalid)
        ] as Array<(Measure<Length>, Measure<Length>)>
    )
    internal func natIsNotApproximatelyEqual(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) {
        let result: Bool = lhs.isApproximatelyEqual(
            to: rhs,
            absoluteTolerance: .init(1, .meter),
            relativeTolerance: 1
        )
        #expect(result == false)
    }

    @Test("NaT absolute tolerance rejects equality")
    internal func natToleranceRejectsEquality() {
        let value: Measure<Length> = .init(1, .meter)
        let result: Bool = value.isApproximatelyEqual(
            to: value,
            absoluteTolerance: .nat,
            relativeTolerance: 0
        )
        #expect(result == false)
    }
}
