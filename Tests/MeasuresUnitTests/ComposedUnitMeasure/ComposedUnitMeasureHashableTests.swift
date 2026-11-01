// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure Hashable Tests")
internal struct ComposedUnitMeasureHashableTests {
    internal init() {}

    @Test(
        "Equal stored values produce equal hashes",
        arguments: [
            (.init(1, .meter), .init(1, .meter)),
            (.init(-1, .meter), .init(-1, .meter)),
            (.init(100, .centimeter), .init(100, .centimeter)),
            (.init(1, .foot), .init(1, .foot)),
            (.init(1, .dimensionless), .init(1, .dimensionless)),
            (.init(-1, .dimensionless), .init(-1, .dimensionless)),
            (.init(0, .dimensionless), .init(0, .dimensionless)),
            (.init(0.5, .dimensionless), .init(0.5, .dimensionless))
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>)>
    )
    internal func equalStoredValuesProduceEqualHashes(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>
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
            (.init(1, .foot), .init(12, .inch)),
            (.init(1, .dimensionless), .init(1, .cancelledMeters))
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>)>
    )
    internal func equivalentRepresentationsRemainDistinctHashKeys(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>
    ) {
        #expect(lhs != rhs)
        #expect(Set([lhs, rhs]).count == 2)
    }
}
