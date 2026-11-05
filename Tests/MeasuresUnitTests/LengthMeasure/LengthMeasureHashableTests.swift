// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Hashable Tests")
internal struct LengthMeasureHashableTests {
    internal init() {}

    @Test(
        "Equal stored values produce equal hashes",
        arguments: [
            (.init(1, .meter), .init(1, .meter)),
            (.init(-1, .meter), .init(-1, .meter)),
            (.init(100, .centimeter), .init(100, .centimeter)),
            (.init(1, .foot), .init(1, .foot))
        ] as Array<(Measure<Length>, Measure<Length>)>
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
            (.init(1, .meter), .init(100, .centimeter)),
            (.init(1, .meter), .init(1_000, .millimeter)),
            (.init(1, .meter), .init(0.001, .kilometer)),
            (.init(1, .foot), .init(12, .inch))
        ] as Array<(Measure<Length>, Measure<Length>)>
    )
    internal func equivalentRepresentationsRemainDistinctHashKeys(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) {
        #expect(lhs != rhs)
        #expect(Set([lhs, rhs]).count == 2)
    }
}
