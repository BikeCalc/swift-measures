// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Converted Measure Equatable Tests")
internal struct ConvertedMeasureEquatableTests {
    private static let equalityArguments: [(Measure<Length>, Measure<Length>, Bool)] = [
        (Measure<Length>(1, .meter), Measure<Length>(1, .meter), true),
        (Measure<Length>(1, .meter), Measure<Length>(2, .meter), false),
        (Measure<Length>(1, .meter), Measure<Length>(100, .centimeter), false),
        (Measure<Length>(1, .foot), Measure<Length>(1, .foot), true),
        (Measure<Length>(1, .foot), Measure<Length>(2, .foot), false),
        (Measure<Length>(1, .foot), Measure<Length>(12, .inch), false)
    ]

    @Test(
        "Equality succeeds",
        arguments: Self.equalityArguments
    )
    internal func equalitySucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        result: Bool
    ) {
        let lhsWrapper: Converted<Length> = .init(wrappedValue: lhs, to: lhs.unit)
        let rhsWrapper: Converted<Length> = .init(wrappedValue: rhs, to: rhs.unit)

        #expect((lhsWrapper == rhsWrapper) == result)
    }

    @Test(
        "Inequality succeeds",
        arguments: Self.equalityArguments
    )
    internal func inequalitySucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        result: Bool
    ) {
        let lhsWrapper: Converted<Length> = .init(wrappedValue: lhs, to: lhs.unit)
        let rhsWrapper: Converted<Length> = .init(wrappedValue: rhs, to: rhs.unit)

        #expect((lhsWrapper != rhsWrapper) == !result)
    }

    @Test(
        "Is equal succeeds",
        arguments: Self.equalityArguments
    )
    internal func isEqualSucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        result: Bool
    ) {
        let lhsWrapper: Converted<Length> = .init(wrappedValue: lhs, to: lhs.unit)
        let rhsWrapper: Converted<Length> = .init(wrappedValue: rhs, to: rhs.unit)

        #expect(lhsWrapper.isEqual(to: rhsWrapper) == result)
    }

    @Test(
        "Is unequal succeeds",
        arguments: Self.equalityArguments
    )
    internal func isUnequalSucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        result: Bool
    ) {
        let lhsWrapper: Converted<Length> = .init(wrappedValue: lhs, to: lhs.unit)
        let rhsWrapper: Converted<Length> = .init(wrappedValue: rhs, to: rhs.unit)

        #expect(lhsWrapper.isUnequal(to: rhsWrapper) == !result)
    }
}
