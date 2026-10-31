// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Converted ComposedUnit Measure Hashable Tests")
internal struct ConvertedComposedUnitMeasureHashableTests {
    internal init() {}

    @Test(
        "Equivalent representations produce equal hashes",
        arguments: [
            (.init(1, .meter), .init(100, .centimeter), .meter),
            (.init(1, .meter), .init(1_000, .millimeter), .meter),
            (.init(1, .meter), .init(0.001, .kilometer), .meter),
            (.init(1, .foot), .init(12, .inch), .meter),
            (.init(1, .dimensionless), .init(1, .dimensionless), .dimensionless),
            (.init(1, .dimensionless), .init(1, .cancelledMeters), .dimensionless),
            (.init(1, .cancelledMeters), .init(1, .dimensionless), .cancelledMeters),
            (.init(1, .cancelledMeters), .init(1, .cancelledMeters), .cancelledMeters)
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>, ComposedUnit)>
    )
    internal func equivalentRepresentationsProduceEqualHashes(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        unit: ComposedUnit
    ) {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: unit
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: rhs,
            to: unit
        )
        #expect(lhsWrapper == rhsWrapper)
        #expect(lhsWrapper.hashValue == rhsWrapper.hashValue)
        #expect(Set([lhsWrapper, rhsWrapper]).count == 1)
    }
}

// MARK: - NaT

extension ConvertedComposedUnitMeasureHashableTests {
    // TODO: Implement NaT tests for this suite.
}
