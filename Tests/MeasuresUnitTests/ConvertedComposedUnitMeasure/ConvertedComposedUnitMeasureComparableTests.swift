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
        isLess: Bool,
        isLessThanOrEqual _: Bool,
        isGreater _: Bool,
        isGreaterThanOrEqual _: Bool
    ) throws {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        #expect((lhsWrapper < rhsWrapper) == isLess)
        #expect(try lhsWrapper.isLess(than: rhsWrapper) == isLess)
    }

    @Test(
        "Is less than or equal",
        arguments: Self.comparisonArguments
    )
    internal func isLessThanOrEqualTo(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        isLess _: Bool,
        isLessThanOrEqual: Bool,
        isGreater _: Bool,
        isGreaterThanOrEqual _: Bool
    ) throws {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        #expect((lhsWrapper <= rhsWrapper) == isLessThanOrEqual)
        #expect(try lhsWrapper.isLessThanOrEqual(to: rhsWrapper) == isLessThanOrEqual)
    }

    @Test(
        "Is greater than",
        arguments: Self.comparisonArguments
    )
    internal func isGreaterThan(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        isLess _: Bool,
        isLessThanOrEqual _: Bool,
        isGreater: Bool,
        isGreaterThanOrEqual _: Bool
    ) throws {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        #expect((lhsWrapper > rhsWrapper) == isGreater)
        #expect(try lhsWrapper.isGreater(than: rhsWrapper) == isGreater)
    }

    @Test(
        "Is greater than or equal",
        arguments: Self.comparisonArguments
    )
    internal func isGreaterThanOrEqualTo(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        isLess _: Bool,
        isLessThanOrEqual _: Bool,
        isGreater _: Bool,
        isGreaterThanOrEqual: Bool
    ) throws {
        let lhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<ComposedUnit> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        #expect((lhsWrapper >= rhsWrapper) == isGreaterThanOrEqual)
        #expect(try lhsWrapper.isGreaterThanOrEqual(to: rhsWrapper) == isGreaterThanOrEqual)
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
        #expect(try valueWrapper.isWithin(range) == range.contains(valueWrapper))
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
        let valueIsWithinBounds: Bool = try valueWrapper.isWithin(lowerBoundWrapper, upperBoundWrapper) == true
        #expect(valueIsWithinBounds == (valueWrapper >= lowerBoundWrapper && valueWrapper <= upperBoundWrapper))
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
        let valueIsBetweenBounds: Bool = try valueWrapper.isBetween(lowerBoundWrapper, upperBoundWrapper) == true
        #expect(valueIsBetweenBounds == (valueWrapper > lowerBoundWrapper && valueWrapper < upperBoundWrapper))
    }
}

// MARK: - NaT

extension ConvertedComposedUnitMeasureComparableTests {
    // TODO: Implement NaT tests for this suite.
}
