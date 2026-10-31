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

@Suite("ComposedUnit Simplifiable Tests")
internal struct ComposedUnitSimplifiableTests {
    internal init() {}

    private static let simplificationArguments: [(ComposedUnit, Array<ComposedUnit.Factor>)] = [
        (
            ComposedUnit.meter * ComposedUnit.meter,
            [
                .init(Length.meter, 2)
            ]
        ),
        (
            (ComposedUnit.meter ** 3) / ComposedUnit.meter,
            [
                .init(Length.meter, 2)
            ]
        ),
        (
            ComposedUnit(Time.second) * ComposedUnit.meter * ComposedUnit(Time.second),
            [
                .init(Time.second, 2),
                .init(Length.meter, 1)
            ]
        ),
        (
            ComposedUnit.meter,
            [
                .init(Length.meter, 1)
            ]
        ),
        (
            ComposedUnit.meter * ComposedUnit.centimeter,
            [
                .init(Length.meter, 1),
                .init(Length.centimeter, 1)
            ]
        ),
        (
            ComposedUnit(Time.second) * ComposedUnit.meter,
            [
                .init(Time.second, 1),
                .init(Length.meter, 1)
            ]
        ),
        (ComposedUnit.dimensionless, []),
        (ComposedUnit.cancelledMeters, [])
    ]

    @Test(
        "Is simplifiable",
        arguments: [
            (ComposedUnit.meter * ComposedUnit.meter, true),
            (ComposedUnit.cancelledMeters, true),
            ((ComposedUnit.meter ** 3) / ComposedUnit.meter, true),
            (ComposedUnit(Time.second) * ComposedUnit.meter * ComposedUnit(Time.second), true),
            (ComposedUnit.meter, true),
            (ComposedUnit.dimensionless, true),
            (ComposedUnit.meter * ComposedUnit.centimeter, true),
            (ComposedUnit(Time.second) * ComposedUnit.meter, true)
        ]
    )
    internal func isSimplifiable(
        value: ComposedUnit,
        result: Bool
    ) {
        #expect(value.isSimplifiable == result)
    }

    @Test(
        "Is simplified",
        arguments: [
            (ComposedUnit.meter * ComposedUnit.meter, false),
            (ComposedUnit.cancelledMeters, false),
            ((ComposedUnit.meter ** 3) / ComposedUnit.meter, false),
            (ComposedUnit(Time.second) * ComposedUnit.meter * ComposedUnit(Time.second), false),
            (ComposedUnit.meter, true),
            (ComposedUnit.dimensionless, true),
            (ComposedUnit.meter * ComposedUnit.centimeter, true),
            (ComposedUnit(Time.second) * ComposedUnit.meter, true)
        ]
    )
    internal func isSimplified(
        value: ComposedUnit,
        result: Bool
    ) {
        #expect(value.isSimplified == result)
    }

    @Test(
        "Simplification succeeds",
        arguments: Self.simplificationArguments
    )
    internal func simplificationSucceeds(
        value: ComposedUnit,
        result: Array<ComposedUnit.Factor>
    ) {
        #expect(value.simplified().factors == result)
    }

    @Test(
        "Simplify succeeds",
        arguments: Self.simplificationArguments
    )
    internal func simplifySucceeds(
        value: ComposedUnit,
        result: Array<ComposedUnit.Factor>
    ) {
        var runningValue: ComposedUnit = value
        runningValue.simplify()
        #expect(runningValue.factors == result)
    }

    @Test(
        "Simplification is idempotent",
        arguments: [
            ComposedUnit.meter * ComposedUnit.meter,
            ComposedUnit.cancelledMeters,
            (ComposedUnit.meter ** 3) / ComposedUnit.meter,
            ComposedUnit(Time.second) * ComposedUnit.meter * ComposedUnit(Time.second)
        ]
    )
    internal func simplificationIsIdempotent(value: ComposedUnit) {
        let result: ComposedUnit = value.simplified().simplified()
        #expect(result == value.simplified())
    }
}
