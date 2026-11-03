// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Converted ComposedUnit Measure CanonicallyEquatable Tests")
internal struct ConvertedComposedUnitMeasureCanonicallyEquatableTests {
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
            (.init(-1, .meter), .init(100, .centimeter), false),
            (.init(1, .dimensionless), .init(1, .dimensionless), true),
            (.init(1, .dimensionless), .init(2, .dimensionless), false),
            (.init(1, .cancelledMeters), .init(1, .dimensionless), true),
            (.init(1, .dimensionless), .init(1, .cancelledMeters), true)
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>, Bool)>
    )
    internal func canonicalEqualitySucceeds(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        expected: Bool
    ) {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        let result: Bool = lhsWrapper.isCanonicallyEqual(to: rhsWrapper)
        #expect(result == expected)
    }
}

// MARK: - NaT

extension ConvertedComposedUnitMeasureCanonicallyEquatableTests {
    @Test(
        "NaT is unequal",
        arguments: [
            (.nat, .init(1, .meter)),
            (.init(1, .meter), .nat),
            (.nat, .nat),
            (.invalid, .init(1, .meter)),
            (.init(1, .meter), .invalid)
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>)>
    )
    internal func natIsUnequal(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>
    ) {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: .meter
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: rhs,
            to: .meter
        )
        let result: Bool = lhsWrapper.isCanonicallyEqual(to: rhsWrapper)
        #expect(result == false)
    }
}
