// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Invertible Tests")
internal struct LengthMeasureInvertibleTests {
    internal init() {}

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
        "Is invertible",
        arguments: [
            .init(2.0, .meter),
            .init(-2.0, .meter),
            .init(200.0, .centimeter),
            .init(-200.0, .centimeter)
        ] as Array<Measure<Length>>
    )
    internal func isInvertible(dividend: Measure<Length>) {
        let result: Bool = dividend.isInvertible
        #expect(result == true)
    }
}

// MARK: - NaT

extension LengthMeasureInvertibleTests {
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
}

// MARK: - Negative Infinity

extension LengthMeasureInvertibleTests {
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

extension LengthMeasureInvertibleTests {
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

extension LengthMeasureInvertibleTests {
    @Test("Reciprocal of least nonzero magnitude returns nil")
    internal func reciprocalOfLeastNonzeroMagnitudeReturnsNil() {
        let value: Measure<Length> = .init(Double.leastNonzeroMagnitude, .meter)
        #expect(value.reciprocal == nil)
        #expect(value.isInvertible == false)
    }
}

// MARK: - Positive Infinity

extension LengthMeasureInvertibleTests {
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

extension LengthMeasureInvertibleTests {
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
