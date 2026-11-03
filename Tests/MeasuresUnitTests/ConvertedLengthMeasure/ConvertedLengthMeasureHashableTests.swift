// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Converted Length Measure Hashable Tests")
internal struct ConvertedLengthMeasureHashableTests {
    internal init() {}

    @Test(
        "Equivalent representations produce equal hashes",
        arguments: [
            (.init(1, .meter), .init(100, .centimeter)),
            (.init(1, .meter), .init(1_000, .millimeter)),
            (.init(1, .meter), .init(0.001, .kilometer)),
            (.init(1, .foot), .init(12, .inch))
        ] as Array<(Measure<Length>, Measure<Length>)>
    )
    internal func equivalentRepresentationsProduceEqualHashes(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) {
        let lhsWrapper: Converted<Length> = .init(
            wrappedValue: lhs,
            to: .meter
        )
        let rhsWrapper: Converted<Length> = .init(
            wrappedValue: rhs,
            to: .meter
        )
        #expect(lhsWrapper == rhsWrapper)
        #expect(lhsWrapper.hashValue == rhsWrapper.hashValue)
        #expect(Set([lhsWrapper, rhsWrapper]).count == 1)
    }
}
