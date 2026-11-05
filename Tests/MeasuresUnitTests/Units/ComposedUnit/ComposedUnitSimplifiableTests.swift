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
        (.meter * .meter, [.init(Length.meter, 2)]),
        ((.meter ** 3) / .meter, [.init(Length.meter, 2)]),
        (.init(Time.second) * .meter * .init(Time.second), [.init(Time.second, 2), .init(Length.meter, 1)]),
        (.meter, [.init(Length.meter, 1)]),
        (.meter * .centimeter, [.init(Length.meter, 1), .init(Length.centimeter, 1)]),
        (.init(Time.second) * .meter, [.init(Time.second, 1), .init(Length.meter, 1)]),
        (.dimensionless, []),
        (.cancelledMeters, [])
    ]

    @Test(
        "Is simplifiable",
        arguments: [
            (.meter * .meter, true),
            (.cancelledMeters, true),
            ((.meter ** 3) / .meter, true),
            (.init(Time.second) * .meter * .init(Time.second), true),
            (.meter, true),
            (.dimensionless, true),
            (.meter * .centimeter, true),
            (.init(Time.second) * .meter, true)
        ] as Array<(ComposedUnit, Bool)>
    )
    internal func isSimplifiable(
        value: ComposedUnit,
        expected: Bool
    ) {
        #expect(value.isSimplifiable == expected)
    }

    @Test(
        "Is simplified",
        arguments: [
            (.meter * .meter, false),
            (.cancelledMeters, false),
            ((.meter ** 3) / .meter, false),
            (.init(Time.second) * .meter * .init(Time.second), false),
            (.meter, true),
            (.dimensionless, true),
            (.meter * .centimeter, true),
            (.init(Time.second) * .meter, true)
        ] as Array<(ComposedUnit, Bool)>
    )
    internal func isSimplified(
        value: ComposedUnit,
        expected: Bool
    ) {
        #expect(value.isSimplified == expected)
    }

    @Test(
        "Simplification succeeds",
        arguments: Self.simplificationArguments
    )
    internal func simplificationSucceeds(
        value: ComposedUnit,
        expected: Array<ComposedUnit.Factor>
    ) {
        let result: ComposedUnit = value.simplified()
        #expect(result.factors == expected)
    }

    @Test(
        "Simplify succeeds",
        arguments: Self.simplificationArguments
    )
    internal func simplifySucceeds(
        value: ComposedUnit,
        expected: Array<ComposedUnit.Factor>
    ) {
        var result: ComposedUnit = value
        result.simplify()
        #expect(result.factors == expected)
    }

    @Test(
        "Simplification is idempotent",
        arguments: [
            .meter * .meter,
            .cancelledMeters,
            (.meter ** 3) / .meter,
            .init(Time.second) * .meter * .init(Time.second)
        ] as Array<ComposedUnit>
    )
    internal func simplificationIsIdempotent(value: ComposedUnit) {
        let result: ComposedUnit = value.simplified().simplified()
        #expect(result == value.simplified())
    }
}
