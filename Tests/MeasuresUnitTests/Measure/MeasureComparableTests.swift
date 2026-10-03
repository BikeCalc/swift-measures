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
    ) throws {
        #expect((lhs < rhs) == isLess)
        #expect(try lhs.isLess(than: rhs) == isLess)
    }

    @Test("Is less than or equal", arguments: Self.comparisonArguments)
    internal func isLessThanOrEqualTo(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLess _: Bool,
        isLessThanOrEqual: Bool,
        isGreater _: Bool,
        isGreaterThanOrEqual _: Bool
    ) throws {
        #expect((lhs <= rhs) == isLessThanOrEqual)
        #expect(try lhs.isLessThanOrEqual(to: rhs) == isLessThanOrEqual)
    }

    @Test("Is greater than", arguments: Self.comparisonArguments)
    internal func isGreaterThan(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLess _: Bool,
        isLessThanOrEqual _: Bool,
        isGreater: Bool,
        isGreaterThanOrEqual _: Bool
    ) throws {
        #expect((lhs > rhs) == isGreater)
        #expect(try lhs.isGreater(than: rhs) == isGreater)
    }

    @Test("Is greater than or equal", arguments: Self.comparisonArguments)
    internal func isGreaterThanOrEqualTo(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        isLess _: Bool,
        isLessThanOrEqual _: Bool,
        isGreater _: Bool,
        isGreaterThanOrEqual: Bool
    ) throws {
        #expect((lhs >= rhs) == isGreaterThanOrEqual)
        #expect(try lhs.isGreaterThanOrEqual(to: rhs) == isGreaterThanOrEqual)
    }

    @Test("Is within closed range", arguments: Self.rangeArguments)
    internal func isWithinClosedRange(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) throws {
        let range: ClosedRange<Measure<Length>> = lowerBound ... upperBound

        #expect(try value.isWithin(range) == range.contains(value))
    }

    @Test("Is within bounds", arguments: Self.rangeArguments)
    internal func isWithinBounds(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) throws {
        let valueIsWithinBounds: Bool = try value.isWithin(lowerBound, upperBound) == true

        #expect(valueIsWithinBounds == (value >= lowerBound && value <= upperBound))
    }

    @Test("Is between bounds", arguments: Self.rangeArguments)
    internal func isBetweenBounds(
        value: Measure<Length>,
        lowerBound: Measure<Length>,
        upperBound: Measure<Length>
    ) throws {
        let valueIsBetweenBounds: Bool = try value.isBetween(lowerBound, upperBound) == true

        #expect(valueIsBetweenBounds == (value > lowerBound && value < upperBound))
    }
}
