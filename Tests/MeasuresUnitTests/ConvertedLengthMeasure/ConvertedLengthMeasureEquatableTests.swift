// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Converted Length Measure Equatable Tests")
internal struct ConvertedLengthMeasureEquatableTests {
    internal init() {}

    private static let equalityArguments: [(Measure<Length>, Measure<Length>, Bool)] = [
        (.init(1, .meter), .init(1, .meter), true),
        (.init(1, .meter), .init(2, .meter), false),
        (.init(1, .meter), .init(100, .centimeter), false),
        (.init(1, .foot), .init(1, .foot), true),
        (.init(1, .foot), .init(2, .foot), false),
        (.init(1, .foot), .init(12, .inch), false)
    ]

    @Test(
        "Equality succeeds",
        arguments: Self.equalityArguments
    )
    internal func equalitySucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        expected: Bool
    ) {
        let lhsWrapper: Converted<Length> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<Length> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        let result: Bool = lhsWrapper == rhsWrapper
        #expect(result == expected)
    }

    @Test(
        "Inequality succeeds",
        arguments: Self.equalityArguments
    )
    internal func inequalitySucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        expected: Bool
    ) {
        let lhsWrapper: Converted<Length> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<Length> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        let result: Bool = lhsWrapper != rhsWrapper
        #expect(result == !expected)
    }

    @Test(
        "Is equal succeeds",
        arguments: Self.equalityArguments
    )
    internal func isEqualSucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        expected: Bool
    ) throws {
        let lhsWrapper: Converted<Length> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<Length> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        let result: Bool = try lhsWrapper.isEqual(to: rhsWrapper)
        #expect(result == expected)
    }

    @Test(
        "Is unequal succeeds",
        arguments: Self.equalityArguments
    )
    internal func isUnequalSucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        expected: Bool
    ) throws {
        let lhsWrapper: Converted<Length> = .init(
            wrappedValue: lhs,
            to: lhs.unit
        )
        let rhsWrapper: Converted<Length> = .init(
            wrappedValue: rhs,
            to: rhs.unit
        )
        let result: Bool = try lhsWrapper.isUnequal(to: rhsWrapper)
        #expect(result == !expected)
    }
}

// MARK: - NaT

extension ConvertedLengthMeasureEquatableTests {
    @Test(
        "NaT is unequal",
        arguments: [
            (.nat, .init(1, .meter)),
            (.init(1, .meter), .nat),
            (.nat, .nat),
            (.init(1, Length(coefficient: 0, constant: 0, symbol: "invalid")), .init(1, .meter)),
            (.init(1, .meter), .init(1, Length(coefficient: 0, constant: 0, symbol: "invalid")))
        ] as Array<(Measure<Length>, Measure<Length>)>
    )
    internal func natIsUnequal(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) {
        let lhsWrapper: Converted<Length> = .init(
            wrappedValue: lhs,
            to: .meter
        )
        let rhsWrapper: Converted<Length> = .init(
            wrappedValue: rhs,
            to: .meter
        )
        let equalityResult: Bool = lhsWrapper == rhsWrapper
        #expect(equalityResult == false)
        let inequalityResult: Bool = lhsWrapper != rhsWrapper
        #expect(inequalityResult == true)
    }
}
