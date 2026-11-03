// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure CanonicallyEquatable Tests")
internal struct LengthMeasureCanonicallyEquatableTests {
    internal init() {}

    @Test(
        "Canonical equality succeeds",
        arguments: [
            (.init(1, .meter), .init(1, .meter), true),
            (.init(1, .meter), .init(100, .centimeter), true),
            (.init(100, .centimeter), .init(1, .meter), true),
            (.init(1, .foot), .init(12, .inch), true),
            (.init(12, .inch), .init(1, .foot), true),
            (.init(-1, .meter), .init(-100, .centimeter), true),
            (.init(0, .meter), .init(0, .foot), true),
            (.init(1, .meter), .init(99, .centimeter), false),
            (.init(1, .foot), .init(13, .inch), false),
            (.init(-1, .meter), .init(100, .centimeter), false)
        ] as Array<(Measure<Length>, Measure<Length>, Bool)>
    )
    internal func canonicalEqualitySucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        expected: Bool
    ) {
        let result: Bool = lhs.isCanonicallyEqual(to: rhs)
        #expect(result == expected)
    }
}

// MARK: - NaT

extension LengthMeasureCanonicallyEquatableTests {
    @Test(
        "NaT is unequal",
        arguments: [
            (.nat, .init(1, .meter)),
            (.init(1, .meter), .nat),
            (.nat, .nat),
            (.invalid, .init(1, .meter)),
            (.init(1, .meter), .invalid)
        ] as Array<(Measure<Length>, Measure<Length>)>
    )
    internal func natIsUnequal(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) {
        let result: Bool = lhs.isCanonicallyEqual(to: rhs)
        #expect(result == false)
    }
}
