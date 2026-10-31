// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure Raisable Tests")
internal struct ComposedUnitMeasureRaisableTests {
    internal init() {}

    private static let exponentiationArguments: [
        (Measure<ComposedUnit>, Measure<ComposedUnit>.Exponent, Double, Dimension)
    ] = [
        (.init(2.0, .meter), 2, 4.0, .init(length: 2)),
        (.init(2.0, .meter), 3, 8.0, .init(length: 3)),
        (.init(2.0, .meter), -2, 0.25, .init(length: -2)),
        (.init(2.0, .meter), -3, 0.125, .init(length: -3)),
        (.init(-2.0, .meter), 2, 4.0, .init(length: 2)),
        (.init(-2.0, .meter), 3, -8.0, .init(length: 3)),
        (.init(-2.0, .meter), -2, 0.25, .init(length: -2)),
        (.init(-2.0, .meter), -3, -0.125, .init(length: -3)),
        (.init(1.0, .meter), -2, 1.0, .init(length: -2)),
        (.init(1.0, .meter), -3, 1.0, .init(length: -3)),
        (.init(-1.0, .meter), -2, 1.0, .init(length: -2)),
        (.init(-1.0, .meter), -3, -1.0, .init(length: -3)),
        (.init(0.5, .meter), 2, 0.25, .init(length: 2)),
        (.init(0.5, .meter), 3, 0.125, .init(length: 3)),
        (.init(0.5, .meter), -2, 4.0, .init(length: -2)),
        (.init(0.5, .meter), -3, 8.0, .init(length: -3)),
        (.init(-0.5, .meter), 2, 0.25, .init(length: 2)),
        (.init(-0.5, .meter), 3, -0.125, .init(length: 3)),
        (.init(-0.5, .meter), -2, 4.0, .init(length: -2)),
        (.init(-0.5, .meter), -3, -8.0, .init(length: -3)),
        (.init(200.0, .centimeter), 2, 4.0, .init(length: 2)),
        (.init(200.0, .centimeter), 3, 8.0, .init(length: 3)),
        (.init(-200.0, .centimeter), 2, 4.0, .init(length: 2)),
        (.init(-200.0, .centimeter), 3, -8.0, .init(length: 3)),
        (.init(2.0, .dimensionless), 2, 4.0, .init()),
        (.init(2.0, .dimensionless), 3, 8.0, .init()),
        (.init(2.0, .dimensionless), -2, 0.25, .init()),
        (.init(2.0, .dimensionless), -3, 0.125, .init())
    ]

    @Test(
        "Is power of",
        arguments: [
            (Measure<ComposedUnit>(4.0, .meter), Measure<ComposedUnit>(2.0, .meter), false),
            (Measure<ComposedUnit>(6.0, .meter), Measure<ComposedUnit>(2.0, .meter), false),
            (Measure<ComposedUnit>(8.0, .meter), Measure<ComposedUnit>(2.0, .meter), false),
            (Measure<ComposedUnit>(9.0, .meter), Measure<ComposedUnit>(2.0, .meter), false),
            (Measure<ComposedUnit>(4.0, .meter), Measure<ComposedUnit>(-2.0, .meter), false),
            (Measure<ComposedUnit>(-8.0, .meter), Measure<ComposedUnit>(-2.0, .meter), false),
            (Measure<ComposedUnit>(6.0, .meter), Measure<ComposedUnit>(-2.0, .meter), false),
            (Measure<ComposedUnit>(0.25, .meter), Measure<ComposedUnit>(2.0, .meter), false),
            (Measure<ComposedUnit>(4.0, .meter), Measure<ComposedUnit>(0.5, .meter), false),
            (Measure<ComposedUnit>(-0.125, .meter), Measure<ComposedUnit>(-2.0, .meter), false),
            (Measure<ComposedUnit>(0.2, .meter), Measure<ComposedUnit>(2.0, .meter), false),
            (Measure<ComposedUnit>(2.0, .meter), Measure<ComposedUnit>(200.0, .centimeter), true),
            (Measure<ComposedUnit>(200.0, .centimeter), Measure<ComposedUnit>(2.0, .meter), true),
            (Measure<ComposedUnit>(4.0, .meter), Measure<ComposedUnit>(200.0, .centimeter), false),
            (Measure<ComposedUnit>(400.0, .centimeter), Measure<ComposedUnit>(2.0, .meter), false),
            (Measure<ComposedUnit>(4.0, .dimensionless), Measure<ComposedUnit>(2.0, .dimensionless), true),
            (Measure<ComposedUnit>(6.0, .dimensionless), Measure<ComposedUnit>(2.0, .dimensionless), false),
            (Measure<ComposedUnit>(8.0, .dimensionless), Measure<ComposedUnit>(2.0, .dimensionless), true),
            (Measure<ComposedUnit>(9.0, .dimensionless), Measure<ComposedUnit>(2.0, .dimensionless), false)
        ]
    )
    internal func isPowerOfSucceeds(
        measure: Measure<ComposedUnit>,
        base: Measure<ComposedUnit>,
        result: Bool
    ) {
        #expect(measure.isPower(of: base) == result)
    }

    @Test(
        "Exponentiation succeeds",
        arguments: Self.exponentiationArguments
    )
    internal func exponentiationSucceeds(
        base: Measure<ComposedUnit>,
        exponent: Measure<ComposedUnit>.Exponent,
        value: Double,
        dimension: Dimension
    ) {
        let power: Measure<ComposedUnit> = base ** exponent
        #expect(power.isNaT == false)
        #expect(power.value == value)
        #expect(power.unit.dimension == dimension)
        #expect(power.unit.coefficient == 1)
        #expect(power.unit.constant == 0)
    }

    @Test(
        "Raising to succeeds",
        arguments: Self.exponentiationArguments
    )
    internal func raisingToSucceeds(
        base: Measure<ComposedUnit>,
        exponent: Measure<ComposedUnit>.Exponent,
        value: Double,
        dimension: Dimension
    ) throws {
        let power: Measure<ComposedUnit> = try base.raising(to: exponent)
        #expect(power.isNaT == false)
        #expect(power.value == value)
        #expect(power.unit.dimension == dimension)
        #expect(power.unit.coefficient == 1)
        #expect(power.unit.constant == 0)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureRaisableTests {}
