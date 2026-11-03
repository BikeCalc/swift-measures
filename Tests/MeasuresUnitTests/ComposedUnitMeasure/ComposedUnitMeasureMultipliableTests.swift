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

    private static let multiplicationArguments:
        [(Measure<ComposedUnit>, Measure<ComposedUnit>.Multiplier, Measure<ComposedUnit>)] = [
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
            (.init(6.0, .meter), .init(3.0, .meter), true),
            (.init(7.0, .meter), .init(3.0, .meter), false),
            (.init(-6.0, .meter), .init(3.0, .meter), true),
            (.init(-7.0, .meter), .init(3.0, .meter), false),
            (.init(1.5, .meter), .init(0.5, .meter), true),
            (.init(1.5, .meter), .init(2.5, .meter), false),
            (.init(-1.5, .meter), .init(0.5, .meter), true),
            (.init(-1.5, .meter), .init(2.5, .meter), false),
            (.init(6.0, .meter), .init(300.0, .centimeter), true),
            (.init(600.0, .centimeter), .init(3.0, .meter), true),
            (.init(7.0, .meter), .init(300.0, .centimeter), false),
            (.init(700.0, .centimeter), .init(3.0, .meter), false),
            (.init(6.0, .dimensionless), .init(3.0, .dimensionless), true),
            (.init(7.0, .dimensionless), .init(3.0, .dimensionless), false),
            (.init(-6.0, .dimensionless), .init(3.0, .dimensionless), true),
            (.init(-7.0, .dimensionless), .init(3.0, .dimensionless), false)
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>, Bool)>
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
    @Test(
        "NaT multiple predicate returns false",
        arguments: [
            .init(1, .meter),
            .nat,
            .invalid
        ] as Array<Measure<ComposedUnit>>
    )
    internal func natMultiplePredicateReturnsFalse(other: Measure<ComposedUnit>) {
        let firstResult: Bool = Measure<ComposedUnit>.nat.isMultiple(of: other)
        #expect(firstResult == false)
        let secondResult: Bool = other.isMultiple(of: .nat)
        #expect(secondResult == false)
    }

    @Test(
        "Multiplying NaT by a scalar returns NaT",
        arguments: [
            (.nat, 2.0),
            (.init(Double.nan, .meter), 2.0),
            (.init(Double.infinity, .meter), 2.0),
            (.init(Double.negativeInfinity, .meter), 2.0),
            (.invalid, 2.0)
        ] as Array<(Measure<ComposedUnit>, Double)>
    )
    internal func multiplyingNaTByScalarReturnsNaT(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Double
    ) {
        let result: Measure<ComposedUnit> = multiplicand * multiplier
        #expect(result.isNaT == true)
    }

    @Test(
        "Multiplying by a non-finite scalar returns NaT",
        arguments: [
            (.init(1, .meter), .nan),
            (.init(1, .meter), .infinity),
            (.init(1, .meter), .negativeInfinity)
        ] as Array<(Measure<ComposedUnit>, Double)>
    )
    internal func multiplyingByNonfiniteScalarReturnsNaT(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Double
    ) {
        let result: Measure<ComposedUnit> = multiplicand * multiplier
        #expect(result.isNaT == true)
    }
}
