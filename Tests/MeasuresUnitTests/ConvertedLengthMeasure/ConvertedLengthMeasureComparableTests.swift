// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Converted Length Measure Comparable Tests")
internal struct ConvertedLengthMeasureComparableTests {
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
        let lhsWrapper: Converted<Length> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<Length> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        let lessThanResult: Bool = lhsWrapper < rhsWrapper
        #expect(lessThanResult == isLessExpected)
        let isLessResult: Bool = try lhsWrapper.isLess(than: rhsWrapper)
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
        let lhsWrapper: Converted<Length> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<Length> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        let lessThanOrEqualResult: Bool = lhsWrapper <= rhsWrapper
        #expect(lessThanOrEqualResult == isLessThanOrEqualExpected)
        let isLessThanOrEqualResult: Bool = try lhsWrapper.isLessThanOrEqual(to: rhsWrapper)
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
        let lhsWrapper: Converted<Length> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<Length> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        let greaterThanResult: Bool = lhsWrapper > rhsWrapper
        #expect(greaterThanResult == isGreaterExpected)
        let isGreaterResult: Bool = try lhsWrapper.isGreater(than: rhsWrapper)
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
        let lhsWrapper: Converted<Length> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<Length> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        let greaterThanOrEqualResult: Bool = lhsWrapper >= rhsWrapper
        #expect(greaterThanOrEqualResult == isGreaterThanOrEqualExpected)
        let isGreaterThanOrEqualResult: Bool = try lhsWrapper.isGreaterThanOrEqual(to: rhsWrapper)
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
        let valueWrapper: Converted<Length> = .init(
            wrappedValue: value,
            to: value.unit
        )
        let lowerBoundWrapper: Converted<Length> = .init(
            wrappedValue: lowerBound,
            to: lowerBound.unit
        )
        let upperBoundWrapper: Converted<Length> = .init(
            wrappedValue: upperBound,
            to: upperBound.unit
        )
        let range: ClosedRange<Converted<Length>> = lowerBoundWrapper ... upperBoundWrapper
        let result: Bool = try valueWrapper.isWithin(range)
        #expect(result == range.contains(valueWrapper))
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
        let valueWrapper: Converted<Length> = .init(
            wrappedValue: value,
            to: value.unit
        )
        let lowerBoundWrapper: Converted<Length> = .init(
            wrappedValue: lowerBound,
            to: lowerBound.unit
        )
        let upperBoundWrapper: Converted<Length> = .init(
            wrappedValue: upperBound,
            to: upperBound.unit
        )
        let result: Bool = try valueWrapper.isWithin(lowerBoundWrapper, upperBoundWrapper) == true
        #expect(result == (valueWrapper >= lowerBoundWrapper && valueWrapper <= upperBoundWrapper))
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
        let valueWrapper: Converted<Length> = .init(
            wrappedValue: value,
            to: value.unit
        )
        let lowerBoundWrapper: Converted<Length> = .init(
            wrappedValue: lowerBound,
            to: lowerBound.unit
        )
        let upperBoundWrapper: Converted<Length> = .init(
            wrappedValue: upperBound,
            to: upperBound.unit
        )
        let result: Bool = try valueWrapper.isBetween(lowerBoundWrapper, upperBoundWrapper) == true
        #expect(result == (valueWrapper > lowerBoundWrapper && valueWrapper < upperBoundWrapper))
    }
}

// MARK: - NaT

extension ConvertedLengthMeasureComparableTests {
    // TODO: Implement NaT tests for this suite.
}
