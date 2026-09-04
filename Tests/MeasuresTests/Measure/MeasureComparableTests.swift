// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Measure Comparable Tests")
internal struct MeasureComparableTests {
    private static let comparisonArguments: [(Measure<Length>, Measure<Length>, Bool, Bool, Bool, Bool)] = [
        (Measure<Length>(1, .meter), Measure<Length>(1, .meter), false, true, false, true),
        (Measure<Length>(1, .meter), Measure<Length>(100, .centimeter), false, true, false, true),
        (Measure<Length>(1, .meter), Measure<Length>(2, .meter), true, true, false, false),
        (Measure<Length>(2, .meter), Measure<Length>(1, .meter), false, false, true, true),
        (Measure<Length>(1, .foot), Measure<Length>(1, .meter), true, true, false, false),
        (Measure<Length>(1, .meter), Measure<Length>(1, .foot), false, false, true, true)
    ]

    private static let rangeArguments: [(Measure<Length>, Measure<Length>, Measure<Length>)] = [
        (Measure<Length>(50, .centimeter), Measure<Length>(1, .meter), Measure<Length>(2, .meter)),
        (Measure<Length>(1, .meter), Measure<Length>(1, .meter), Measure<Length>(2, .meter)),
        (Measure<Length>(150, .centimeter), Measure<Length>(1, .meter), Measure<Length>(2, .meter)),
        (Measure<Length>(2, .meter), Measure<Length>(1, .meter), Measure<Length>(2, .meter)),
        (Measure<Length>(250, .centimeter), Measure<Length>(1, .meter), Measure<Length>(2, .meter)),
        (Measure<Length>(1, .foot), Measure<Length>(1, .yard), Measure<Length>(2, .yard)),
        (Measure<Length>(1, .yard), Measure<Length>(1, .yard), Measure<Length>(2, .yard)),
        (Measure<Length>(5, .foot), Measure<Length>(1, .yard), Measure<Length>(2, .yard)),
        (Measure<Length>(2, .yard), Measure<Length>(1, .yard), Measure<Length>(2, .yard)),
        (Measure<Length>(7, .foot), Measure<Length>(1, .yard), Measure<Length>(2, .yard))
    ]

    @Test("Is less than", arguments: Self.comparisonArguments)
    internal func isLessThan(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLess: Bool,
        isLessThanOrEqual _: Bool,
        isGreater _: Bool,
        isGreaterThanOrEqual _: Bool
    ) {
        #expect((lhs < rhs) == isLess)
        #expect(lhs.isLess(than: rhs) == isLess)
    }

    @Test("Is less than or equal", arguments: Self.comparisonArguments)
    internal func isLessThanOrEqualTo(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLess _: Bool,
        isLessThanOrEqual: Bool,
        isGreater _: Bool,
        isGreaterThanOrEqual _: Bool
    ) {
        #expect((lhs <= rhs) == isLessThanOrEqual)
        #expect(lhs.isLessThanOrEqual(to: rhs) == isLessThanOrEqual)
    }

    @Test("Is greater than", arguments: Self.comparisonArguments)
    internal func isGreaterThan(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLess _: Bool,
        isLessThanOrEqual _: Bool,
        isGreater: Bool,
        isGreaterThanOrEqual _: Bool
    ) {
        #expect((lhs > rhs) == isGreater)
        #expect(lhs.isGreater(than: rhs) == isGreater)
    }

    @Test("Is greater than or equal", arguments: Self.comparisonArguments)
    internal func isGreaterThanOrEqualTo(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLess _: Bool,
        isLessThanOrEqual _: Bool,
        isGreater _: Bool,
        isGreaterThanOrEqual: Bool
    ) {
        #expect((lhs >= rhs) == isGreaterThanOrEqual)
        #expect(lhs.isGreaterThanOrEqual(to: rhs) == isGreaterThanOrEqual)
    }

    @Test("Is within closed range", arguments: Self.rangeArguments)
    internal func isWithinClosedRange(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) {
        let range: ClosedRange<Measure<Length>> = lowerBound...upperBound
        #expect(value.isWithin(range) == range.contains(value))
    }

    @Test("Is within bounds", arguments: Self.rangeArguments)
    internal func isWithinBounds(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) {
        let isWithin: Bool = value.isWithin(lowerBound, through: upperBound)
        #expect(isWithin == (value >= lowerBound && value <= upperBound))
    }

    @Test("Is between bounds", arguments: Self.rangeArguments)
    internal func isBetweenBounds(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) {
        let isBetween: Bool = value.isBetween(lowerBound, and: upperBound)
        #expect(isBetween == (value > lowerBound && value < upperBound))
    }
}
