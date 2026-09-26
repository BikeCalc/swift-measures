// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Converted Measure Hashable Tests")
internal struct ConvertedMeasureHashableTests {
    @Test(
        "Equivalent representations produce equal hashes",
        arguments: [
            (Measure<Length>(1, .meter), Measure<Length>(100, .centimeter)),
            (Measure<Length>(1, .meter), Measure<Length>(1_000, .millimeter)),
            (Measure<Length>(1, .meter), Measure<Length>(0.001, .kilometer)),
            (Measure<Length>(1, .foot), Measure<Length>(12, .inch))
        ]
    )
    internal func equivalentRepresentationsProduceEqualHashes(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) {
        let lhsWrapper: Converted<Length> = .init(wrappedValue: lhs, to: .meter)
        let rhsWrapper: Converted<Length> = .init(wrappedValue: rhs, to: .meter)

        #expect(lhsWrapper == rhsWrapper)
        #expect(lhsWrapper.hashValue == rhsWrapper.hashValue)
        #expect(Set([lhsWrapper, rhsWrapper]).count == 1)
    }
}
