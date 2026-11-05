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
        (.init(Time.second) * .meter, [.init(Length.meter, 1), .init(Time.second, 1)]),
        (.meter * .centimeter, [.init(Length.centimeter, 1), .init(Length.meter, 1)]),
        (.meter * (.meter ** -1) * .meter, [.init(Length.meter, -1), .init(Length.meter, 1), .init(Length.meter, 1)]),
        (.meter, [.init(Length.meter, 1)]),
        (.meter * .init(Time.second), [.init(Length.meter, 1), .init(Time.second, 1)]),
        (.centimeter * .meter, [.init(Length.centimeter, 1), .init(Length.meter, 1)]),
        (.cancelledMeters, [.init(Length.meter, -1), .init(Length.meter, 1)]),
        (.dimensionless, [])
    ]

    @Test(
        "Is normalizable",
        arguments: [
            (.init(Time.second) * .meter, true),
            (.meter * .centimeter, true),
            (.meter * (.meter ** -1) * .meter, true),
            (.meter, true),
            (.dimensionless, true),
            (.meter * .init(Time.second), true),
            (.centimeter * .meter, true),
            (.cancelledMeters, true)
        ] as Array<(ComposedUnit, Bool)>
    )
    internal func isNormalizable(
        value: ComposedUnit,
        expected: Bool
    ) {
        #expect(value.isNormalizable == expected)
    }

    @Test(
        "Is normalized",
        arguments: [
            (.init(Time.second) * .meter, false),
            (.meter * .centimeter, false),
            (.meter * (.meter ** -1) * .meter, false),
            (.meter, true),
            (.dimensionless, true),
            (.meter * .init(Time.second), true),
            (.centimeter * .meter, true),
            (.cancelledMeters, false)
        ] as Array<(ComposedUnit, Bool)>
    )
    internal func isNormalized(
        value: ComposedUnit,
        expected: Bool
    ) {
        #expect(value.isNormalized == expected)
    }

    @Test(
        "Normalization succeeds",
        arguments: Self.normalizationArguments
    )
    internal func normalizationSucceeds(
        value: ComposedUnit,
        expected: Array<ComposedUnit.Factor>
    ) {
        let result: ComposedUnit = value.normalized()
        #expect(result.factors == expected)
    }

    @Test(
        "Normalize succeeds",
        arguments: Self.normalizationArguments
    )
    internal func normalizeSucceeds(
        value: ComposedUnit,
        expected: Array<ComposedUnit.Factor>
    ) {
        var result: ComposedUnit = value
        result.normalize()
        #expect(result.factors == expected)
    }

    @Test(
        "Normalization is idempotent",
        arguments: [
            .init(Time.second) * .meter,
            .meter * .centimeter,
            .meter * (.meter ** -1) * .meter,
            .meter
        ] as Array<ComposedUnit>
    )
    internal func normalizationIsIdempotent(value: ComposedUnit) {
        let result: ComposedUnit = value.normalized().normalized()
        #expect(result == value.normalized())
    }
}
