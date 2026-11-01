// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Comparable Tests")
internal struct LengthMeasureComparableTests {
    internal init() {}

    private static let comparisonArguments: [(Measure<Length>, Measure<Length>, Bool, Bool, Bool, Bool)] = [
        (.init(1, .meter), .init(1, .meter), false, true, false, true),
        (.init(1, .meter), .init(100, .centimeter), false, true, false, true),
        (.init(1, .meter), .init(2, .meter), true, true, false, false),
        (.init(2, .meter), .init(1, .meter), false, false, true, true),
        (.init(1, .foot), .init(1, .meter), true, true, false, false),
        (.init(1, .meter), .init(1, .foot), false, false, true, true)
    ]

    private static let rangeArguments: [(Measure<Length>, Measure<Length>, Measure<Length>)] = [
        (.init(50, .centimeter), .init(1, .meter), .init(2, .meter)),
        (.init(1, .meter), .init(1, .meter), .init(2, .meter)),
        (.init(150, .centimeter), .init(1, .meter), .init(2, .meter)),
        (.init(2, .meter), .init(1, .meter), .init(2, .meter)),
        (.init(250, .centimeter), .init(1, .meter), .init(2, .meter)),
        (.init(1, .foot), .init(1, .yard), .init(2, .yard)),
        (.init(1, .yard), .init(1, .yard), .init(2, .yard)),
        (.init(5, .foot), .init(1, .yard), .init(2, .yard)),
        (.init(2, .yard), .init(1, .yard), .init(2, .yard)),
        (.init(7, .foot), .init(1, .yard), .init(2, .yard))
    ]

    @Test(
        "Is less than",
        arguments: Self.comparisonArguments
    )
    internal func isLessThan(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLessExpected: Bool,
        isLessThanOrEqualExpected _: Bool,
        isGreaterExpected _: Bool,
        isGreaterThanOrEqualExpected _: Bool
    ) throws {
        let lessThanResult: Bool = lhs < rhs
        #expect(lessThanResult == isLessExpected)
        let isLessResult: Bool = try lhs.isLess(than: rhs)
        #expect(isLessResult == isLessExpected)
    }

    @Test(
        "Is less than or equal",
        arguments: Self.comparisonArguments
    )
    internal func isLessThanOrEqualTo(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLessExpected _: Bool,
        isLessThanOrEqualExpected: Bool,
        isGreaterExpected _: Bool,
        isGreaterThanOrEqualExpected _: Bool
    ) throws {
        let lessThanOrEqualResult: Bool = lhs <= rhs
        #expect(lessThanOrEqualResult == isLessThanOrEqualExpected)
        let isLessThanOrEqualResult: Bool = try lhs.isLessThanOrEqual(to: rhs)
        #expect(isLessThanOrEqualResult == isLessThanOrEqualExpected)
    }

    @Test(
        "Is greater than",
        arguments: Self.comparisonArguments
    )
    internal func isGreaterThan(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLessExpected _: Bool,
        isLessThanOrEqualExpected _: Bool,
        isGreaterExpected: Bool,
        isGreaterThanOrEqualExpected _: Bool
    ) throws {
        let greaterThanResult: Bool = lhs > rhs
        #expect(greaterThanResult == isGreaterExpected)
        let isGreaterResult: Bool = try lhs.isGreater(than: rhs)
        #expect(isGreaterResult == isGreaterExpected)
    }

    @Test(
        "Is greater than or equal",
        arguments: Self.comparisonArguments
    )
    internal func isGreaterThanOrEqualTo(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLessExpected _: Bool,
        isLessThanOrEqualExpected _: Bool,
        isGreaterExpected _: Bool,
        isGreaterThanOrEqualExpected: Bool
    ) throws {
        let greaterThanOrEqualResult: Bool = lhs >= rhs
        #expect(greaterThanOrEqualResult == isGreaterThanOrEqualExpected)
        let isGreaterThanOrEqualResult: Bool = try lhs.isGreaterThanOrEqual(to: rhs)
        #expect(isGreaterThanOrEqualResult == isGreaterThanOrEqualExpected)
    }

    @Test(
        "Is within closed range",
        arguments: Self.rangeArguments
    )
    internal func isWithinClosedRange(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) throws {
        let range: ClosedRange<Measure<Length>> = lowerBound ... upperBound
        let result: Bool = try value.isWithin(range)
        #expect(result == range.contains(value))
    }

    @Test(
        "Is within bounds",
        arguments: Self.rangeArguments
    )
    internal func isWithinBounds(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) throws {
        let result: Bool = try value.isWithin(lowerBound, upperBound) == true
        #expect(result == (value >= lowerBound && value <= upperBound))
    }

    @Test(
        "Is between bounds",
        arguments: Self.rangeArguments
    )
    internal func isBetweenBounds(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) throws {
        let result: Bool = try value.isBetween(lowerBound, upperBound) == true
        #expect(result == (value > lowerBound && value < upperBound))
    }
}

// MARK: - NaT

extension LengthMeasureComparableTests {
    @Test(
        "NaT is unordered",
        arguments: [
            (.nat, .init(1, .meter)),
            (.init(1, .meter), .nat),
            (.nat, .nat),
            (.init(1, Length(coefficient: 0, constant: 0, symbol: "invalid")), .init(1, .meter)),
            (.init(1, .meter), .init(1, Length(coefficient: 0, constant: 0, symbol: "invalid")))
        ] as Array<(Measure<Length>, Measure<Length>)>
    )
    internal func natIsUnordered(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) throws {
        let lessThanResult: Bool = lhs < rhs
        #expect(lessThanResult == false)
        let isLessResult: Bool = try lhs.isLess(than: rhs)
        #expect(isLessResult == false)
        let lessThanOrEqualResult: Bool = lhs <= rhs
        #expect(lessThanOrEqualResult == false)
        let isLessThanOrEqualResult: Bool = try lhs.isLessThanOrEqual(to: rhs)
        #expect(isLessThanOrEqualResult == false)
        let greaterThanResult: Bool = lhs > rhs
        #expect(greaterThanResult == false)
        let isGreaterResult: Bool = try lhs.isGreater(than: rhs)
        #expect(isGreaterResult == false)
        let greaterThanOrEqualResult: Bool = lhs >= rhs
        #expect(greaterThanOrEqualResult == false)
        let isGreaterThanOrEqualResult: Bool = try lhs.isGreaterThanOrEqual(to: rhs)
        #expect(isGreaterThanOrEqualResult == false)
    }

    @Test("NaT lies outside valid bounds")
    internal func natLiesOutsideBounds() throws {
        let value: Measure<Length> = .nat
        let lowerBound: Measure<Length> = .init(0, .meter)
        let upperBound: Measure<Length> = .init(2, .meter)
        let isWithinResult: Bool = try value.isWithin(lowerBound ... upperBound)
        #expect(isWithinResult == false)
        let isWithinResult2: Bool = try value.isWithin(lowerBound, upperBound)
        #expect(isWithinResult2 == false)
        let isBetweenResult: Bool = try value.isBetween(lowerBound, upperBound)
        #expect(isBetweenResult == false)
    }
}
