// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Raisable Tests")
internal struct LengthMeasureRaisableTests {
    internal init() {}

    private static let exponentiationArguments: [(Measure<Length>, Measure<Length>.Exponent, Double, Dimension)] = [
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
        (.init(-200.0, .centimeter), 3, -8.0, .init(length: 3))
    ]

    @Test(
        "Is power of",
        arguments: [
            (.init(4.0, .meter), .init(2.0, .meter), false),
            (.init(6.0, .meter), .init(2.0, .meter), false),
            (.init(8.0, .meter), .init(2.0, .meter), false),
            (.init(9.0, .meter), .init(2.0, .meter), false),
            (.init(4.0, .meter), .init(-2.0, .meter), false),
            (.init(-8.0, .meter), .init(-2.0, .meter), false),
            (.init(6.0, .meter), .init(-2.0, .meter), false),
            (.init(0.25, .meter), .init(2.0, .meter), false),
            (.init(4.0, .meter), .init(0.5, .meter), false),
            (.init(-0.125, .meter), .init(-2.0, .meter), false),
            (.init(0.2, .meter), .init(2.0, .meter), false),
            (.init(2.0, .meter), .init(200.0, .centimeter), true),
            (.init(200.0, .centimeter), .init(2.0, .meter), true),
            (.init(4.0, .meter), .init(200.0, .centimeter), false),
            (.init(400.0, .centimeter), .init(2.0, .meter), false)
        ] as Array<(Measure<Length>, Measure<Length>, Bool)>
    )
    internal func isPowerOfSucceeds(
        measure: Measure<Length>,
        base: Measure<Length>,
        expected: Bool
    ) {
        let result: Bool = measure.isPower(of: base)
        #expect(result == expected)
    }

    @Test(
        "Exponentiation succeeds",
        arguments: Self.exponentiationArguments
    )
    internal func exponentiationSucceeds(
        base: Measure<Length>,
        exponent: Measure<Length>.Exponent,
        value: Double,
        dimension: Dimension
    ) {
        let result: Measure<ComposedUnit> = base ** exponent
        #expect(result.isNaT == false)
        #expect(result.value == value)
        #expect(result.unit.dimension == dimension)
        #expect(result.unit.coefficient == 1)
        #expect(result.unit.constant == 0)
    }

    @Test(
        "Raising to succeeds",
        arguments: Self.exponentiationArguments
    )
    internal func raisingToSucceeds(
        base: Measure<Length>,
        exponent: Measure<Length>.Exponent,
        value: Double,
        dimension: Dimension
    ) throws {
        let result: Measure<ComposedUnit> = try base.raising(to: exponent)
        #expect(result.isNaT == false)
        #expect(result.value == value)
        #expect(result.unit.dimension == dimension)
        #expect(result.unit.coefficient == 1)
        #expect(result.unit.constant == 0)
    }
}

// MARK: - NaT

extension LengthMeasureRaisableTests {
    @Test(
        "NaT power predicate returns false",
        arguments: [
            .init(1, .meter),
            .nat,
            .invalid
        ] as Array<Measure<Length>>
    )
    internal func natPowerPredicateReturnsFalse(other: Measure<Length>) {
        let firstResult: Bool = Measure<Length>.nat.isPower(of: other)
        #expect(firstResult == false)
        let secondResult: Bool = other.isPower(of: Measure<Length>.nat)
        #expect(secondResult == false)
    }

    @Test(
        "Raising NaT returns NaT",
        arguments: [
            (.nat, -1),
            (.nat, 0),
            (.nat, 1),
            (.nat, 2),
            (.invalid, -1),
            (.invalid, 0),
            (.invalid, 1),
            (.invalid, 2)
        ] as Array<(Measure<Length>, Int)>
    )
    internal func raisingNaTReturnsNaT(
        base: Measure<Length>,
        exponent: Int
    ) {
        let result: Measure<ComposedUnit> = base ** exponent
        #expect(result.isNaT == true)
    }
}
