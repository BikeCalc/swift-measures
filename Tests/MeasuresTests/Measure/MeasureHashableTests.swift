// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Measure Hashable Tests")
internal struct MeasureHashableTests {
    @Test(
        "Equal stored values produce equal hashes",
        arguments: [
            (Measure<Length>(1, .meter), Measure<Length>(1, .meter)),
            (Measure<Length>(-1, .meter), Measure<Length>(-1, .meter)),
            (Measure<Length>(100, .centimeter), Measure<Length>(100, .centimeter)),
            (Measure<Length>(1, .foot), Measure<Length>(1, .foot))
        ]
    )
    internal func equalStoredValuesProduceEqualHashes(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) {
        #expect(lhs == rhs)
        #expect(lhs.hashValue == rhs.hashValue)
        #expect(Set([lhs, rhs]).count == 1)
    }

    @Test(
        "Equivalent representations remain distinct hash keys",
        arguments: [
            (Measure<Length>(1, .meter), Measure<Length>(100, .centimeter)),
            (Measure<Length>(1, .meter), Measure<Length>(1_000, .millimeter)),
            (Measure<Length>(1, .meter), Measure<Length>(0.001, .kilometer)),
            (Measure<Length>(1, .foot), Measure<Length>(12, .inch))
        ]
    )
    internal func equivalentRepresentationsRemainDistinctHashKeys(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) {
        #expect(lhs != rhs)
        #expect(Set([lhs, rhs]).count == 2)
    }
}
