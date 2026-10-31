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
            (Measure<ComposedUnit>(1, .meter), Measure<ComposedUnit>(1, .meter)),
            (Measure<ComposedUnit>(-1, .meter), Measure<ComposedUnit>(-1, .meter)),
            (Measure<ComposedUnit>(100, .centimeter), Measure<ComposedUnit>(100, .centimeter)),
            (Measure<ComposedUnit>(1, .foot), Measure<ComposedUnit>(1, .foot)),
            (Measure<ComposedUnit>(1, .dimensionless), Measure<ComposedUnit>(1, .dimensionless)),
            (Measure<ComposedUnit>(-1, .dimensionless), Measure<ComposedUnit>(-1, .dimensionless)),
            (Measure<ComposedUnit>(0, .dimensionless), Measure<ComposedUnit>(0, .dimensionless)),
            (Measure<ComposedUnit>(0.5, .dimensionless), Measure<ComposedUnit>(0.5, .dimensionless))
        ]
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
            (Measure<ComposedUnit>(1, .meter), Measure<ComposedUnit>(100, .centimeter)),
            (Measure<ComposedUnit>(1, .meter), Measure<ComposedUnit>(1_000, .millimeter)),
            (Measure<ComposedUnit>(1, .meter), Measure<ComposedUnit>(0.001, .kilometer)),
            (Measure<ComposedUnit>(1, .foot), Measure<ComposedUnit>(12, .inch)),
            (Measure<ComposedUnit>(1, .dimensionless), Measure<ComposedUnit>(1, .cancelledMeters))
        ]
    )
    internal func equivalentRepresentationsRemainDistinctHashKeys(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>
    ) {
        #expect(lhs != rhs)
        #expect(Set([lhs, rhs]).count == 2)
    }
}
