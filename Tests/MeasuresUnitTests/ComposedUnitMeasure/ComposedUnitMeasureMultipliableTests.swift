// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure Multipliable Tests")
internal struct ComposedUnitMeasureMultipliableTests {
    internal init() {}

    private static let multiplicationArguments: [
        (Measure<ComposedUnit>, Measure<ComposedUnit>.Multiplier, Measure<ComposedUnit>)
    ] = [
        (.init(2.0, .meter), 3.0, .init(6.0, .meter)),
        (.init(3.0, .meter), 4.0, .init(12.0, .meter)),
        (.init(-2.0, .meter), 3.0, .init(-6.0, .meter)),
        (.init(-3.0, .meter), -4.0, .init(12.0, .meter)),
        (.init(0.5, .meter), 1.5, .init(0.75, .meter)),
        (.init(1.5, .meter), 2.5, .init(3.75, .meter)),
        (.init(-0.5, .meter), 1.5, .init(-0.75, .meter)),
        (.init(-1.5, .meter), -2.5, .init(3.75, .meter)),
        (.init(200.0, .centimeter), 3.0, .init(600.0, .centimeter)),
        (.init(300.0, .centimeter), 4.0, .init(1_200.0, .centimeter)),
        (.init(-200.0, .centimeter), 3.0, .init(-600.0, .centimeter)),
        (.init(-300.0, .centimeter), -4.0, .init(1_200.0, .centimeter)),
        (.init(2.0, .dimensionless), 3.0, .init(6.0, .dimensionless)),
        (.init(3.0, .dimensionless), 4.0, .init(12.0, .dimensionless)),
        (.init(-2.0, .dimensionless), 3.0, .init(-6.0, .dimensionless)),
        (.init(-3.0, .dimensionless), -4.0, .init(12.0, .dimensionless))
    ]

    @Test(
        "Is multiple of",
        arguments: [
            (Measure<ComposedUnit>(6.0, .meter), Measure<ComposedUnit>(3.0, .meter), true),
            (Measure<ComposedUnit>(7.0, .meter), Measure<ComposedUnit>(3.0, .meter), false),
            (Measure<ComposedUnit>(-6.0, .meter), Measure<ComposedUnit>(3.0, .meter), true),
            (Measure<ComposedUnit>(-7.0, .meter), Measure<ComposedUnit>(3.0, .meter), false),
            (Measure<ComposedUnit>(1.5, .meter), Measure<ComposedUnit>(0.5, .meter), true),
            (Measure<ComposedUnit>(1.5, .meter), Measure<ComposedUnit>(2.5, .meter), false),
            (Measure<ComposedUnit>(-1.5, .meter), Measure<ComposedUnit>(0.5, .meter), true),
            (Measure<ComposedUnit>(-1.5, .meter), Measure<ComposedUnit>(2.5, .meter), false),
            (Measure<ComposedUnit>(6.0, .meter), Measure<ComposedUnit>(300.0, .centimeter), true),
            (Measure<ComposedUnit>(600.0, .centimeter), Measure<ComposedUnit>(3.0, .meter), true),
            (Measure<ComposedUnit>(7.0, .meter), Measure<ComposedUnit>(300.0, .centimeter), false),
            (Measure<ComposedUnit>(700.0, .centimeter), Measure<ComposedUnit>(3.0, .meter), false),
            (Measure<ComposedUnit>(6.0, .dimensionless), Measure<ComposedUnit>(3.0, .dimensionless), true),
            (Measure<ComposedUnit>(7.0, .dimensionless), Measure<ComposedUnit>(3.0, .dimensionless), false),
            (Measure<ComposedUnit>(-6.0, .dimensionless), Measure<ComposedUnit>(3.0, .dimensionless), true),
            (Measure<ComposedUnit>(-7.0, .dimensionless), Measure<ComposedUnit>(3.0, .dimensionless), false)
        ]
    )
    internal func isMultipleOfSucceeds(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Measure<ComposedUnit>,
        expected: Bool
    ) {
        let result: Bool = multiplicand.isMultiple(of: multiplier)
        #expect(result == expected)
    }

    @Test(
        "Multiplication succeeds",
        arguments: Self.multiplicationArguments
    )
    internal func multiplicationSucceeds(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Measure<ComposedUnit>.Multiplier,
        product: Measure<ComposedUnit>
    ) {
        let result: Measure<ComposedUnit> = multiplicand * multiplier
        #expect(result == product)
    }

    @Test(
        "Multiplication equal succeeds",
        arguments: Self.multiplicationArguments
    )
    internal func multiplicationEqualSucceeds(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Measure<ComposedUnit>.Multiplier,
        product: Measure<ComposedUnit>
    ) {
        var result: Measure<ComposedUnit> = multiplicand
        result *= multiplier
        #expect(result == product)
    }

    @Test(
        "Multiplying by succeeds",
        arguments: Self.multiplicationArguments
    )
    internal func multiplyingBySucceeds(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Measure<ComposedUnit>.Multiplier,
        product: Measure<ComposedUnit>
    ) throws {
        let result: Measure<ComposedUnit> = try multiplicand.multiplying(by: multiplier)
        #expect(result == product)
    }

    @Test(
        "Multiply by succeeds",
        arguments: Self.multiplicationArguments
    )
    internal func multiplyBySucceeds(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Measure<ComposedUnit>.Multiplier,
        product: Measure<ComposedUnit>
    ) throws {
        var result: Measure<ComposedUnit> = multiplicand
        try result.multiply(by: multiplier)
        #expect(result == product)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureMultipliableTests {
    // TODO: Implement NaT tests for this suite.
}
