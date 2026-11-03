// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Divisible Tests")
internal struct LengthMeasureDivisibleTests {
    internal init() {}

    private static let divisionArguments: [(Measure<Length>, Measure<Length>.Divisor, Measure<Length>)] = [
        (.init(6.0, .meter), 2.0, .init(3.0, .meter)),
        (.init(6.0, .meter), 3.0, .init(2.0, .meter)),
        (.init(-6.0, .meter), 2.0, .init(-3.0, .meter)),
        (.init(-6.0, .meter), -3.0, .init(2.0, .meter)),
        (.init(1.5, .meter), 0.5, .init(3.0, .meter)),
        (.init(3.75, .meter), 1.5, .init(2.5, .meter)),
        (.init(-1.5, .meter), 0.5, .init(-3.0, .meter)),
        (.init(-3.75, .meter), -1.5, .init(2.5, .meter)),
        (.init(600.0, .centimeter), 2.0, .init(300.0, .centimeter)),
        (.init(600.0, .centimeter), 3.0, .init(200.0, .centimeter)),
        (.init(-600.0, .centimeter), 2.0, .init(-300.0, .centimeter)),
        (.init(-600.0, .centimeter), -3.0, .init(200.0, .centimeter))
    ]

    private static let remainderArguments: [(Measure<Length>, Measure<Length>.RemainderDivisor, Measure<Length>)] = [
        (.init(4.0, .meter), 2.0, .init(0.0, .meter)),
        (.init(5.0, .meter), 2.0, .init(1.0, .meter)),
        (.init(5.0, .meter), -2.0, .init(1.0, .meter)),
        (.init(-5.0, .meter), 2.0, .init(-1.0, .meter)),
        (.init(-5.0, .meter), -2.0, .init(-1.0, .meter)),
        (.init(1.5, .meter), 0.5, .init(0.0, .meter)),
        (.init(1.75, .meter), 0.5, .init(0.25, .meter)),
        (.init(-1.75, .meter), 0.5, .init(-0.25, .meter)),
        (.init(-1.75, .meter), -0.5, .init(-0.25, .meter)),
        (.init(500.0, .centimeter), 200.0, .init(100.0, .centimeter)),
        (.init(500.0, .centimeter), -200.0, .init(100.0, .centimeter)),
        (.init(-500.0, .centimeter), 200.0, .init(-100.0, .centimeter)),
        (.init(-500.0, .centimeter), -200.0, .init(-100.0, .centimeter))
    ]

    @Test(
        "Reciprocal",
        arguments: [
            (.init(2.0, .meter), 0.5),
            (.init(-2.0, .meter), -0.5),
            (.init(200.0, .centimeter), 0.5),
            (.init(-200.0, .centimeter), -0.5)
        ] as Array<(Measure<Length>, Double)>
    )
    internal func reciprocal(
        value: Measure<Length>,
        expected: Double
    ) throws {
        let result: Measure<Length>.Reciprocal = try #require(value.reciprocal)
        #expect(result.value == expected)
        #expect(result.unit.dimension == .init(length: -1))
        #expect(result.unit.coefficient == 1.0)
        #expect(result.unit.constant == 0.0)
        #expect(value.isInvertible == true)
    }

    @Test(
        "Is divisible by",
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
            (.init(700.0, .centimeter), .init(3.0, .meter), false)
        ] as Array<(Measure<Length>, Measure<Length>, Bool)>
    )
    internal func isDivisibleBySucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>,
        expected: Bool
    ) {
        let result: Bool = dividend.isDivisible(by: divisor)
        #expect(result == expected)
    }

    @Test(
        "Division succeeds",
        arguments: Self.divisionArguments
    )
    internal func divisionSucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.Divisor,
        quotient: Measure<Length>
    ) {
        let result: Measure<Length> = dividend / divisor
        #expect(result == quotient)
    }

    @Test(
        "Division equal succeeds",
        arguments: Self.divisionArguments
    )
    internal func divisionEqualSucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.Divisor,
        quotient: Measure<Length>
    ) {
        var result: Measure<Length> = dividend
        result /= divisor
        #expect(result == quotient)
    }

    @Test(
        "Dividing by succeeds",
        arguments: Self.divisionArguments
    )
    internal func dividingBySucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.Divisor,
        quotient: Measure<Length>
    ) throws {
        let result: Measure<Length> = try dividend.dividing(by: divisor)
        #expect(result == quotient)
    }

    @Test(
        "Divide by succeeds",
        arguments: Self.divisionArguments
    )
    internal func divideBySucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.Divisor,
        quotient: Measure<Length>
    ) throws {
        var result: Measure<Length> = dividend
        try result.divide(by: divisor)
        #expect(result == quotient)
    }

    @Test(
        "Remainder succeeds",
        arguments: Self.remainderArguments
    )
    internal func remainderSucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.RemainderDivisor,
        remainder: Measure<Length>
    ) {
        let result: Measure<Length> = dividend % divisor
        #expect(result == remainder)
    }

    @Test(
        "Remainder equal succeeds",
        arguments: Self.remainderArguments
    )
    internal func remainderEqualSucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.RemainderDivisor,
        remainder: Measure<Length>
    ) {
        var result: Measure<Length> = dividend
        result %= divisor
        #expect(result == remainder)
    }
}

// MARK: - NaT

extension LengthMeasureDivisibleTests {
    @Test(
        "NaT divisibility predicate returns false",
        arguments: [
            .init(1, .meter),
            .nat,
            .invalid
        ] as Array<Measure<Length>>
    )
    internal func natDivisibilityPredicateReturnsFalse(other: Measure<Length>) {
        let isDivisibleResult: Bool = Measure<Length>.nat.isDivisible(by: other)
        #expect(isDivisibleResult == false)
        let isFactorResult: Bool = Measure<Length>.nat.isFactor(of: other)
        #expect(isFactorResult == false)
    }

    @Test(
        "Reciprocal of NaT returns nil",
        arguments: [.nat, .init(Double.nan, .meter)] as Array<Measure<Length>>
    )
    internal func reciprocalOfNaTReturnsNil(value: Measure<Length>) {
        #expect(value.reciprocal == nil)
    }

    @Test(
        "NaT is not invertible",
        arguments: [.nat, .init(Double.nan, .meter)] as Array<Measure<Length>>
    )
    internal func natIsNotInvertible(value: Measure<Length>) {
        #expect(value.isInvertible == false)
    }

    @Test(
        "Dividing NaT by a scalar returns NaT",
        arguments: [
            (.nat, 2.0),
            (.init(Double.nan, .meter), 2.0),
            (.init(Double.infinity, .meter), 2.0),
            (.init(Double.negativeInfinity, .meter), 2.0),
            (.invalid, 2.0)
        ] as Array<(Measure<Length>, Double)>
    )
    internal func dividingNaTByScalarReturnsNaT(
        dividend: Measure<Length>,
        divisor: Double
    ) {
        let result: Measure<Length> = dividend / divisor
        #expect(result.isNaT == true)
    }

    @Test(
        "Dividing by a non-finite scalar returns NaT",
        arguments: [
            (.init(1, .meter), .nan),
            (.init(1, .meter), .infinity),
            (.init(1, .meter), -.infinity)
        ] as Array<(Measure<Length>, Double)>
    )
    internal func dividingByNonfiniteScalarReturnsNaT(
        dividend: Measure<Length>,
        divisor: Double
    ) {
        let result: Measure<Length> = dividend / divisor
        #expect(result.isNaT == true)
    }

    @Test(
        "Dividing by zero returns NaT",
        arguments: [
            (.init(1, .meter), 0.0)
        ] as Array<(Measure<Length>, Double)>
    )
    internal func dividingByZeroReturnsNaT(
        dividend: Measure<Length>,
        divisor: Double
    ) {
        let result: Measure<Length> = dividend / divisor
        #expect(result.isNaT == true)
    }

    @Test(
        "Remainder of NaT returns NaT",
        arguments: [
            (.nat, 2.0),
            (.init(Double.nan, .meter), 2.0),
            (.init(Double.infinity, .meter), 2.0),
            (.init(Double.negativeInfinity, .meter), 2.0),
            (.invalid, 2.0)
        ] as Array<(Measure<Length>, Double)>
    )
    internal func remainderOfNaTReturnsNaT(
        dividend: Measure<Length>,
        divisor: Double
    ) {
        let result: Measure<Length> = dividend % divisor
        #expect(result.isNaT == true)
    }

    @Test(
        "Remainder with a non-finite divisor returns NaT",
        arguments: [
            (.init(1, .meter), .nan),
            (.init(1, .meter), .infinity),
            (.init(1, .meter), -.infinity)
        ] as Array<(Measure<Length>, Double)>
    )
    internal func remainderWithNonfiniteDivisorReturnsNaT(
        dividend: Measure<Length>,
        divisor: Double
    ) {
        let result: Measure<Length> = dividend % divisor
        #expect(result.isNaT == true)
    }

    @Test(
        "Remainder with a zero divisor returns NaT",
        arguments: [
            (.init(1, .meter), 0.0)
        ] as Array<(Measure<Length>, Double)>
    )
    internal func remainderWithZeroDivisorReturnsNaT(
        dividend: Measure<Length>,
        divisor: Double
    ) {
        let result: Measure<Length> = dividend % divisor
        #expect(result.isNaT == true)
    }
}

// MARK: - Negative Infinity

extension LengthMeasureDivisibleTests {
    @Test("Reciprocal of negative infinity returns nil")
    internal func reciprocalOfNegativeInfinityReturnsNil() {
        let value: Measure<Length> = .init(Double.negativeInfinity, .meter)
        #expect(value.reciprocal == nil)
    }

    @Test("Negative infinity is not invertible")
    internal func negativeInfinityIsNotInvertible() {
        let value: Measure<Length> = .init(Double.negativeInfinity, .meter)
        #expect(value.isInvertible == false)
    }
}

// MARK: - Negative Zero

extension LengthMeasureDivisibleTests {
    @Test("Reciprocal of negative zero returns nil")
    internal func reciprocalOfNegativeZeroReturnsNil() {
        let value: Measure<Length> = .init(-0.0, .meter)
        #expect(value.reciprocal == nil)
    }

    @Test("Negative zero is not invertible")
    internal func negativeZeroIsNotInvertible() {
        let value: Measure<Length> = .init(-0.0, .meter)
        #expect(value.isInvertible == false)
    }
}

// MARK: - Least Nonzero Magnitude

extension LengthMeasureDivisibleTests {
    @Test("Overflowing reciprocal returns nil")
    internal func overflowingReciprocalReturnsNil() {
        let value: Measure<Length> = .init(Double.leastNonzeroMagnitude, .meter)
        #expect(value.reciprocal == nil)
        #expect(value.isInvertible == false)
    }
}

// MARK: - Positive Infinity

extension LengthMeasureDivisibleTests {
    @Test("Reciprocal of positive infinity returns nil")
    internal func reciprocalOfPositiveInfinityReturnsNil() {
        let value: Measure<Length> = .init(Double.infinity, .meter)
        #expect(value.reciprocal == nil)
    }

    @Test("Positive infinity is not invertible")
    internal func positiveInfinityIsNotInvertible() {
        let value: Measure<Length> = .init(Double.infinity, .meter)
        #expect(value.isInvertible == false)
    }
}

// MARK: - Positive Zero

extension LengthMeasureDivisibleTests {
    @Test("Reciprocal of positive zero returns nil")
    internal func reciprocalOfPositiveZeroReturnsNil() {
        let value: Measure<Length> = .init(0.0, .meter)
        #expect(value.reciprocal == nil)
    }

    @Test("Positive zero is not invertible")
    internal func positiveZeroIsNotInvertible() {
        let value: Measure<Length> = .init(0.0, .meter)
        #expect(value.isInvertible == false)
    }
}
