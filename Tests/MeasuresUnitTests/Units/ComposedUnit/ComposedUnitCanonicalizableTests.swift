// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import CoreMeasureUnits
@testable import Measures

@Suite("ComposedUnit Canonicalizable Tests")
internal struct ComposedUnitCanonicalizableTests {
    internal init() {}

    private static let canonicalizationArguments: [(ComposedUnit, Array<ComposedUnit.Factor>)] = [
        (.init(Time.second) * .meter * .meter, [.init(Length.meter, 2), .init(Time.second, 1)]),
        (.meter * .init(Time.second) * .meter, [.init(Length.meter, 2), .init(Time.second, 1)]),
        (.meter, [.init(Length.meter, 1)]),
        (.meter * .centimeter, [.init(Length.centimeter, 1), .init(Length.meter, 1)]),
        (.centimeter * .meter, [.init(Length.centimeter, 1), .init(Length.meter, 1)]),
        (.init(Time.second) * .meter, [.init(Length.meter, 1), .init(Time.second, 1)]),
        (.dimensionless, []),
        (.cancelledMeters, [])
    ]

    @Test(
        "Is canonicalizable",
        arguments: [
            (.init(Time.second) * .meter * .meter, true),
            (.meter * .init(Time.second) * .meter, true),
            (.cancelledMeters, true),
            (.meter, true),
            (.dimensionless, true),
            (.meter * .centimeter, true),
            (.centimeter * .meter, true),
            (.init(Time.second) * .meter, true)
        ] as Array<(ComposedUnit, Bool)>
    )
    internal func isCanonicalizable(
        value: ComposedUnit,
        expected: Bool
    ) {
        #expect(value.isCanonicalizable == expected)
    }

    @Test(
        "Is canonicalized",
        arguments: [
            (.init(Time.second) * .meter * .meter, false),
            (.meter * .init(Time.second) * .meter, false),
            (.cancelledMeters, false),
            (.meter, true),
            (.dimensionless, true),
            (.meter * .centimeter, false),
            (.centimeter * .meter, true),
            (.init(Time.second) * .meter, false)
        ] as Array<(ComposedUnit, Bool)>
    )
    internal func isCanonicalized(
        value: ComposedUnit,
        expected: Bool
    ) {
        #expect(value.isCanonicalized == expected)
    }

    @Test(
        "Canonicalization succeeds",
        arguments: Self.canonicalizationArguments
    )
    internal func canonicalizationSucceeds(
        value: ComposedUnit,
        expected: Array<ComposedUnit.Factor>
    ) {
        let result: ComposedUnit = value.canonicalized()
        #expect(result.factors == expected)
    }

    @Test(
        "Canonicalize succeeds",
        arguments: Self.canonicalizationArguments
    )
    internal func canonicalizeSucceeds(
        value: ComposedUnit,
        expected: Array<ComposedUnit.Factor>
    ) {
        var result: ComposedUnit = value
        result.canonicalize()
        #expect(result.factors == expected)
    }

    @Test(
        "Canonicalization is idempotent",
        arguments: [
            .init(Time.second) * .meter * .meter,
            .meter * .init(Time.second) * .meter,
            .cancelledMeters,
            .meter
        ] as Array<ComposedUnit>
    )
    internal func canonicalizationIsIdempotent(value: ComposedUnit) {
        let result: ComposedUnit = value.canonicalized().canonicalized()
        #expect(result == value.canonicalized())
    }
}
