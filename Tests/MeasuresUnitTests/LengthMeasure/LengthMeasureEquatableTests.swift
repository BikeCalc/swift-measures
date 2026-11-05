// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Equatable Tests")
internal struct LengthMeasureEquatableTests {
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
        let result: Bool = lhs == rhs
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
        let result: Bool = lhs != rhs
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
        let result: Bool = try lhs.isEqual(to: rhs)
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
        let result: Bool = try lhs.isUnequal(to: rhs)
        #expect(result == !expected)
    }
}

// MARK: - NaT

extension LengthMeasureEquatableTests {
    @Test(
        "NaT is unequal",
        arguments: [
            (.nat, .init(1, .meter)),
            (.init(1, .meter), .nat),
            (.nat, .nat),
            (.invalid, .init(1, .meter)),
            (.init(1, .meter), .invalid)
        ] as Array<(Measure<Length>, Measure<Length>)>
    )
    internal func natIsUnequal(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) {
        let equalityResult: Bool = lhs == rhs
        #expect(equalityResult == false)
        let inequalityResult: Bool = lhs != rhs
        #expect(inequalityResult == true)
    }
}
