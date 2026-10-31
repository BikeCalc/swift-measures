// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure Comparable Tests")
internal struct ComposedUnitMeasureComparableTests {
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
        (.init(1, .dimensionless), .init(1, .dimensionless), .init(2, .dimensionless)),
        (.init(2, .dimensionless), .init(1, .dimensionless), .init(2, .dimensionless)),
        (.init(3, .dimensionless), .init(1, .dimensionless), .init(2, .dimensionless))
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
        #expect((lhs < rhs) == isLess)
        #expect(try lhs.isLess(than: rhs) == isLess)
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
        #expect((lhs <= rhs) == isLessThanOrEqual)
        #expect(try lhs.isLessThanOrEqual(to: rhs) == isLessThanOrEqual)
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
        #expect((lhs > rhs) == isGreater)
        #expect(try lhs.isGreater(than: rhs) == isGreater)
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
        #expect((lhs >= rhs) == isGreaterThanOrEqual)
        #expect(try lhs.isGreaterThanOrEqual(to: rhs) == isGreaterThanOrEqual)
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
        let range: ClosedRange<Measure<ComposedUnit>> = lowerBound ... upperBound
        #expect(try value.isWithin(range) == range.contains(value))
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
        let valueIsWithinBounds: Bool = try value.isWithin(lowerBound, upperBound) == true
        #expect(valueIsWithinBounds == (value >= lowerBound && value <= upperBound))
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
        let valueIsBetweenBounds: Bool = try value.isBetween(lowerBound, upperBound) == true
        #expect(valueIsBetweenBounds == (value > lowerBound && value < upperBound))
    }
}

// MARK: - NaT

extension ComposedUnitMeasureComparableTests {}
