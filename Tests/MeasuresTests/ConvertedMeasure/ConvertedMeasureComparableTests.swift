// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Converted Measure Comparable Tests")
internal struct ConvertedMeasureComparableTests {
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

    @Test(
        "Is less than",
        arguments: Self.comparisonArguments
    )
    internal func isLessThan(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLess: Bool,
        isLessThanOrEqual _: Bool,
        isGreater _: Bool,
        isGreaterThanOrEqual _: Bool
    ) {
        let lhsWrapper: Converted<Length> = .init(wrappedValue: lhs, to: lhs.unit)
        let rhsWrapper: Converted<Length> = .init(wrappedValue: rhs, to: rhs.unit)

        #expect((lhsWrapper < rhsWrapper) == isLess)
        #expect(lhsWrapper.isLess(than: rhsWrapper) == isLess)
    }

    @Test(
        "Is less than or equal",
        arguments: Self.comparisonArguments
    )
    internal func isLessThanOrEqualTo(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLess _: Bool,
        isLessThanOrEqual: Bool,
        isGreater _: Bool,
        isGreaterThanOrEqual _: Bool
    ) {
        let lhsWrapper: Converted<Length> = .init(wrappedValue: lhs, to: lhs.unit)
        let rhsWrapper: Converted<Length> = .init(wrappedValue: rhs, to: rhs.unit)

        #expect((lhsWrapper <= rhsWrapper) == isLessThanOrEqual)
        #expect(lhsWrapper.isLessThanOrEqual(to: rhsWrapper) == isLessThanOrEqual)
    }

    @Test(
        "Is greater than",
        arguments: Self.comparisonArguments
    )
    internal func isGreaterThan(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLess _: Bool,
        isLessThanOrEqual _: Bool,
        isGreater: Bool,
        isGreaterThanOrEqual _: Bool
    ) {
        let lhsWrapper: Converted<Length> = .init(wrappedValue: lhs, to: lhs.unit)
        let rhsWrapper: Converted<Length> = .init(wrappedValue: rhs, to: rhs.unit)

        #expect((lhsWrapper > rhsWrapper) == isGreater)
        #expect(lhsWrapper.isGreater(than: rhsWrapper) == isGreater)
    }

    @Test(
        "Is greater than or equal",
        arguments: Self.comparisonArguments
    )
    internal func isGreaterThanOrEqualTo(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLess _: Bool,
        isLessThanOrEqual _: Bool,
        isGreater _: Bool,
        isGreaterThanOrEqual: Bool
    ) {
        let lhsWrapper: Converted<Length> = .init(wrappedValue: lhs, to: lhs.unit)
        let rhsWrapper: Converted<Length> = .init(wrappedValue: rhs, to: rhs.unit)

        #expect((lhsWrapper >= rhsWrapper) == isGreaterThanOrEqual)
        #expect(lhsWrapper.isGreaterThanOrEqual(to: rhsWrapper) == isGreaterThanOrEqual)
    }

    @Test(
        "Is within closed range",
        arguments: Self.rangeArguments
    )
    internal func isWithinClosedRange(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) {
        let valueWrapper: Converted<Length> = .init(wrappedValue: value, to: value.unit)
        let lowerBoundWrapper: Converted<Length> = .init(wrappedValue: lowerBound, to: lowerBound.unit)
        let upperBoundWrapper: Converted<Length> = .init(wrappedValue: upperBound, to: upperBound.unit)
        let range: ClosedRange<Converted<Length>> = lowerBoundWrapper...upperBoundWrapper

        #expect(valueWrapper.isWithin(range) == range.contains(valueWrapper))
    }

    @Test(
        "Is within bounds",
        arguments: Self.rangeArguments
    )
    internal func isWithinBounds(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) {
        let valueWrapper: Converted<Length> = .init(wrappedValue: value, to: value.unit)
        let lowerBoundWrapper: Converted<Length> = .init(wrappedValue: lowerBound, to: lowerBound.unit)
        let upperBoundWrapper: Converted<Length> = .init(wrappedValue: upperBound, to: upperBound.unit)
        let isWithin: Bool = valueWrapper.isWithin(
            lowerBoundWrapper,
            through: upperBoundWrapper
        )

        #expect(isWithin == (valueWrapper >= lowerBoundWrapper && valueWrapper <= upperBoundWrapper))
    }

    @Test(
        "Is between bounds",
        arguments: Self.rangeArguments
    )
    internal func isBetweenBounds(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) {
        let valueWrapper: Converted<Length> = .init(wrappedValue: value, to: value.unit)
        let lowerBoundWrapper: Converted<Length> = .init(wrappedValue: lowerBound, to: lowerBound.unit)
        let upperBoundWrapper: Converted<Length> = .init(wrappedValue: upperBound, to: upperBound.unit)
        let isBetween: Bool = valueWrapper.isBetween(
            lowerBoundWrapper,
            and: upperBoundWrapper
        )

        #expect(isBetween == (valueWrapper > lowerBoundWrapper && valueWrapper < upperBoundWrapper))
    }
}
