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

@Suite("ComposedUnit Normalizable Tests")
internal struct ComposedUnitNormalizableTests {
    internal init() {}

    private static let normalizationArguments: [(ComposedUnit, Array<ComposedUnit.Factor>)] = [
        (
            ComposedUnit(Time.second) * ComposedUnit.meter,
            [
                .init(Length.meter, 1),
                .init(Time.second, 1)
            ]
        ),
        (
            ComposedUnit.meter * ComposedUnit.centimeter,
            [
                .init(Length.centimeter, 1),
                .init(Length.meter, 1)
            ]
        ),
        (
            ComposedUnit.meter * (ComposedUnit.meter ** -1) * ComposedUnit.meter,
            [
                .init(Length.meter, -1),
                .init(Length.meter, 1),
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
            ComposedUnit.meter * ComposedUnit(Time.second),
            [
                .init(Length.meter, 1),
                .init(Time.second, 1)
            ]
        ),
        (
            ComposedUnit.centimeter * ComposedUnit.meter,
            [
                .init(Length.centimeter, 1),
                .init(Length.meter, 1)
            ]
        ),
        (
            ComposedUnit.cancelledMeters,
            [
                .init(Length.meter, -1),
                .init(Length.meter, 1)
            ]
        ),
        (ComposedUnit.dimensionless, [])
    ]

    @Test(
        "Is normalizable",
        arguments: [
            (ComposedUnit(Time.second) * ComposedUnit.meter, true),
            (ComposedUnit.meter * ComposedUnit.centimeter, true),
            (ComposedUnit.meter * (ComposedUnit.meter ** -1) * ComposedUnit.meter, true),
            (ComposedUnit.meter, true),
            (ComposedUnit.dimensionless, true),
            (ComposedUnit.meter * ComposedUnit(Time.second), true),
            (ComposedUnit.centimeter * ComposedUnit.meter, true),
            (ComposedUnit.cancelledMeters, true)
        ]
    )
    internal func isNormalizable(
        value: ComposedUnit,
        result: Bool
    ) {
        #expect(value.isNormalizable == result)
    }

    @Test(
        "Is normalized",
        arguments: [
            (ComposedUnit(Time.second) * ComposedUnit.meter, false),
            (ComposedUnit.meter * ComposedUnit.centimeter, false),
            (ComposedUnit.meter * (ComposedUnit.meter ** -1) * ComposedUnit.meter, false),
            (ComposedUnit.meter, true),
            (ComposedUnit.dimensionless, true),
            (ComposedUnit.meter * ComposedUnit(Time.second), true),
            (ComposedUnit.centimeter * ComposedUnit.meter, true),
            (ComposedUnit.cancelledMeters, false)
        ]
    )
    internal func isNormalized(
        value: ComposedUnit,
        result: Bool
    ) {
        #expect(value.isNormalized == result)
    }

    @Test(
        "Normalization succeeds",
        arguments: Self.normalizationArguments
    )
    internal func normalizationSucceeds(
        value: ComposedUnit,
        result: Array<ComposedUnit.Factor>
    ) {
        #expect(value.normalized().factors == result)
    }

    @Test(
        "Normalize succeeds",
        arguments: Self.normalizationArguments
    )
    internal func normalizeSucceeds(
        value: ComposedUnit,
        result: Array<ComposedUnit.Factor>
    ) {
        var runningValue: ComposedUnit = value
        runningValue.normalize()
        #expect(runningValue.factors == result)
    }

    @Test(
        "Normalization is idempotent",
        arguments: [
            ComposedUnit(Time.second) * ComposedUnit.meter,
            ComposedUnit.meter * ComposedUnit.centimeter,
            ComposedUnit.meter * (ComposedUnit.meter ** -1) * ComposedUnit.meter,
            ComposedUnit.meter
        ]
    )
    internal func normalizationIsIdempotent(value: ComposedUnit) {
        let result: ComposedUnit = value.normalized().normalized()
        #expect(result == value.normalized())
    }
}
