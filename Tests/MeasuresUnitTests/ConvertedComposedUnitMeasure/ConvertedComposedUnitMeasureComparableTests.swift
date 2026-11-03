// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Converted ComposedUnit Measure Comparable Tests")
internal struct ConvertedComposedUnitMeasureComparableTests {
    internal init() {}

    private static let comparisonArguments: [(Measure<ComposedUnit>, Measure<ComposedUnit>, Bool, Bool, Bool, Bool)] = [
        (.init(1, .meter), .init(1, .meter), false, true, false, true),
        (.init(1, .meter), .init(100, .centimeter), false, true, false, true),
        (.init(1, .meter), .init(2, .meter), true, true, false, false),
        (.init(2, .meter), .init(1, .meter), false, false, true, true),
        (.init(1, .foot), .init(1, .meter), true, true, false, false),
        (.init(1, .meter), .init(1, .foot), false, false, true, true),
        (.init(1, .dimensionless), .init(1, .dimensionless), false, true, false, true),
        (.init(1, .dimensionless), .init(2, .dimensionless), true, true, false, false),
        (.init(2, .dimensionless), .init(1, .dimensionless), false, false, true, true),
        (.init(1, .dimensionless), .init(1, .cancelledMeters), false, true, false, true)
    ]

    private static let rangeArguments: [(Measure<ComposedUnit>, Measure<ComposedUnit>, Measure<ComposedUnit>)] = [
        (.init(50, .centimeter), .init(1, .meter), .init(2, .meter)),
        (.init(1, .meter), .init(1, .meter), .init(2, .meter)),
        (.init(150, .centimeter), .init(1, .meter), .init(2, .meter)),
        (.init(2, .meter), .init(1, .meter), .init(2, .meter)),
        (.init(250, .centimeter), .init(1, .meter), .init(2, .meter)),
        (.init(1, .foot), .init(1, .yard), .init(2, .yard)),
        (.init(1, .yard), .init(1, .yard), .init(2, .yard)),
        (.init(5, .foot), .init(1, .yard), .init(2, .yard)),
        (.init(2, .yard), .init(1, .yard), .init(2, .yard)),
        (.init(7, .foot), .init(1, .yard), .init(2, .yard)),
        (.init(0, .dimensionless), .init(1, .dimensionless), .init(2, .dimensionless)),
        (.init(1, .cancelledMeters), .init(1, .dimensionless), .init(2, .dimensionless)),
        (.init(1.5, .dimensionless), .init(1, .dimensionless), .init(2, .dimensionless)),
        (.init(2, .cancelledMeters), .init(1, .dimensionless), .init(2, .dimensionless))
    ]

    @Test(
        "Is less than",
        arguments: Self.comparisonArguments
    )
    internal func isLessThan(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        isLessExpected: Bool,
        isLessThanOrEqualExpected _: Bool,
        isGreaterExpected _: Bool,
        isGreaterThanOrEqualExpected _: Bool
    ) throws {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
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
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        isLessExpected _: Bool,
        isLessThanOrEqualExpected: Bool,
        isGreaterExpected _: Bool,
        isGreaterThanOrEqualExpected _: Bool
    ) throws {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
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
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        isLessExpected _: Bool,
        isLessThanOrEqualExpected _: Bool,
        isGreaterExpected: Bool,
        isGreaterThanOrEqualExpected _: Bool
    ) throws {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
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
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        isLessExpected _: Bool,
        isLessThanOrEqualExpected _: Bool,
        isGreaterExpected _: Bool,
        isGreaterThanOrEqualExpected: Bool
    ) throws {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
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
        value: Measure<ComposedUnit>,
        lowerBound: Measure<ComposedUnit>,
        upperBound: Measure<ComposedUnit>
    ) throws {
        let valueWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: value,
            to: value.unit
        )
        let lowerBoundWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lowerBound,
            to: lowerBound.unit
        )
        let upperBoundWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: upperBound,
            to: upperBound.unit
        )
        let range: ClosedRange<Converted<ComposedUnit>> = lowerBoundWrapper ... upperBoundWrapper
        let result: Bool = try valueWrapper.isWithin(range)
        #expect(result == range.contains(valueWrapper))
    }

    @Test(
        "Is within bounds",
        arguments: Self.rangeArguments
    )
    internal func isWithinBounds(
        value: Measure<ComposedUnit>,
        lowerBound: Measure<ComposedUnit>,
        upperBound: Measure<ComposedUnit>
    ) throws {
        let valueWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: value,
            to: value.unit
        )
        let lowerBoundWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lowerBound,
            to: lowerBound.unit
        )
        let upperBoundWrapper: Converted<ComposedUnit> = .init(
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
        value: Measure<ComposedUnit>,
        lowerBound: Measure<ComposedUnit>,
        upperBound: Measure<ComposedUnit>
    ) throws {
        let valueWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: value,
            to: value.unit
        )
        let lowerBoundWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lowerBound,
            to: lowerBound.unit
        )
        let upperBoundWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: upperBound,
            to: upperBound.unit
        )
        let result: Bool = try valueWrapper.isBetween(lowerBoundWrapper, upperBoundWrapper) == true
        #expect(result == (valueWrapper > lowerBoundWrapper && valueWrapper < upperBoundWrapper))
    }
}

// MARK: - NaT

extension ConvertedComposedUnitMeasureComparableTests {
    @Test(
        "NaT is unordered",
        arguments: [
            (.nat, .init(1, .meter)),
            (.init(1, .meter), .nat),
            (.nat, .nat),
            (.invalid, .init(1, .meter)),
            (.init(1, .meter), .invalid)
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>)>
    )
    internal func natIsUnordered(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>
    ) throws {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: .meter
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: rhs,
            to: .meter
        )
        let lessThanResult: Bool = lhsWrapper < rhsWrapper
        #expect(lessThanResult == false)
        let isLessResult: Bool = try lhsWrapper.isLess(than: rhsWrapper)
        #expect(isLessResult == false)
        let lessThanOrEqualResult: Bool = lhsWrapper <= rhsWrapper
        #expect(lessThanOrEqualResult == false)
        let isLessThanOrEqualResult: Bool = try lhsWrapper.isLessThanOrEqual(to: rhsWrapper)
        #expect(isLessThanOrEqualResult == false)
        let greaterThanResult: Bool = lhsWrapper > rhsWrapper
        #expect(greaterThanResult == false)
        let isGreaterResult: Bool = try lhsWrapper.isGreater(than: rhsWrapper)
        #expect(isGreaterResult == false)
        let greaterThanOrEqualResult: Bool = lhsWrapper >= rhsWrapper
        #expect(greaterThanOrEqualResult == false)
        let isGreaterThanOrEqualResult: Bool = try lhsWrapper.isGreaterThanOrEqual(to: rhsWrapper)
        #expect(isGreaterThanOrEqualResult == false)
    }

    @Test("NaT lies outside valid bounds")
    internal func natLiesOutsideBounds() throws {
        let value: Converted<ComposedUnit> = .init(wrappedValue: .nat, to: .meter)
        let lowerBound: Converted<ComposedUnit> = .init(wrappedValue: .init(0, .meter), to: .meter)
        let upperBound: Converted<ComposedUnit> = .init(wrappedValue: .init(2, .meter), to: .meter)
        let isWithinResult: Bool = try value.isWithin(lowerBound ... upperBound)
        #expect(isWithinResult == false)
        let isWithinResult2: Bool = try value.isWithin(lowerBound, upperBound)
        #expect(isWithinResult2 == false)
        let isBetweenResult: Bool = try value.isBetween(lowerBound, upperBound)
        #expect(isBetweenResult == false)
    }
}
