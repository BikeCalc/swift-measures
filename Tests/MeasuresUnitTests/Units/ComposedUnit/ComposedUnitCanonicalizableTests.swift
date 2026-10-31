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
        (
            ComposedUnit(Time.second) * ComposedUnit.meter * ComposedUnit.meter,
            [.init(Length.meter, 2), .init(Time.second, 1)]
        ),
        (
            ComposedUnit.meter * ComposedUnit(Time.second) * ComposedUnit.meter,
            [.init(Length.meter, 2), .init(Time.second, 1)]
        ),
        (
            ComposedUnit.meter,
            [.init(Length.meter, 1)]
        ),
        (
            ComposedUnit.meter * ComposedUnit.centimeter,
            [.init(Length.centimeter, 1), .init(Length.meter, 1)]
        ),
        (
            ComposedUnit.centimeter * ComposedUnit.meter,
            [.init(Length.centimeter, 1), .init(Length.meter, 1)]
        ),
        (
            ComposedUnit(Time.second) * ComposedUnit.meter,
            [.init(Length.meter, 1), .init(Time.second, 1)]
        ),
        (ComposedUnit.dimensionless, []),
        (ComposedUnit.cancelledMeters, [])
    ]

    @Test(
        "Is canonicalizable",
        arguments: [
            (ComposedUnit(Time.second) * ComposedUnit.meter * ComposedUnit.meter, true),
            (ComposedUnit.meter * ComposedUnit(Time.second) * ComposedUnit.meter, true),
            (ComposedUnit.cancelledMeters, true),
            (ComposedUnit.meter, true),
            (ComposedUnit.dimensionless, true),
            (ComposedUnit.meter * ComposedUnit.centimeter, true),
            (ComposedUnit.centimeter * ComposedUnit.meter, true),
            (ComposedUnit(Time.second) * ComposedUnit.meter, true)
        ]
    )
    internal func isCanonicalizable(
        value: ComposedUnit,
        result: Bool
    ) {
        #expect(value.isCanonicalizable == result)
    }

    @Test(
        "Is canonicalized",
        arguments: [
            (ComposedUnit(Time.second) * ComposedUnit.meter * ComposedUnit.meter, false),
            (ComposedUnit.meter * ComposedUnit(Time.second) * ComposedUnit.meter, false),
            (ComposedUnit.cancelledMeters, false),
            (ComposedUnit.meter, true),
            (ComposedUnit.dimensionless, true),
            (ComposedUnit.meter * ComposedUnit.centimeter, false),
            (ComposedUnit.centimeter * ComposedUnit.meter, true),
            (ComposedUnit(Time.second) * ComposedUnit.meter, false)
        ]
    )
    internal func isCanonicalized(
        value: ComposedUnit,
        result: Bool
    ) {
        #expect(value.isCanonicalized == result)
    }

    @Test(
        "Canonicalization succeeds",
        arguments: Self.canonicalizationArguments
    )
    internal func canonicalizationSucceeds(
        value: ComposedUnit,
        result: Array<ComposedUnit.Factor>
    ) {
        #expect(value.canonicalized().factors == result)
    }

    @Test(
        "Canonicalize succeeds",
        arguments: Self.canonicalizationArguments
    )
    internal func canonicalizeSucceeds(
        value: ComposedUnit,
        result: Array<ComposedUnit.Factor>
    ) {
        var runningValue: ComposedUnit = value
        runningValue.canonicalize()
        #expect(runningValue.factors == result)
    }

    @Test(
        "Canonicalization is idempotent",
        arguments: [
            ComposedUnit(Time.second) * ComposedUnit.meter * ComposedUnit.meter,
            ComposedUnit.meter * ComposedUnit(Time.second) * ComposedUnit.meter,
            ComposedUnit.cancelledMeters,
            ComposedUnit.meter
        ]
    )
    internal func canonicalizationIsIdempotent(value: ComposedUnit) {
        let result: ComposedUnit = value.canonicalized().canonicalized()
        #expect(result == value.canonicalized())
    }
}
