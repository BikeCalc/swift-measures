// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure Equatable Tests")
internal struct ComposedUnitMeasureEquatableTests {
    internal init() {}

    private static let equalityArguments: [(Measure<ComposedUnit>, Measure<ComposedUnit>, Bool)] = [
        (.init(1, .meter), .init(1, .meter), true),
        (.init(1, .meter), .init(2, .meter), false),
        (.init(1, .meter), .init(100, .centimeter), false),
        (.init(1, .foot), .init(1, .foot), true),
        (.init(1, .foot), .init(2, .foot), false),
        (.init(1, .foot), .init(12, .inch), false),
        (.init(1, .dimensionless), .init(1, .dimensionless), true),
        (.init(1, .dimensionless), .init(2, .dimensionless), false),
        (.init(-1, .dimensionless), .init(-1, .dimensionless), true),
        (.init(1, .dimensionless),.init(1, .cancelledMeters), false)
    ]

    @Test(
        "Equality succeeds",
        arguments: Self.equalityArguments
    )
    internal func equalitySucceeds(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        result: Bool
    ) {
        #expect((lhs == rhs) == result)
    }

    @Test(
        "Inequality succeeds",
        arguments: Self.equalityArguments
    )
    internal func inequalitySucceeds(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        result: Bool
    ) {
        #expect((lhs != rhs) == !result)
    }

    @Test(
        "Is equal succeeds",
        arguments: Self.equalityArguments
    )
    internal func isEqualSucceeds(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        result: Bool
    ) throws {
        #expect(try lhs.isEqual(to: rhs) == result)
    }

    @Test(
        "Is unequal succeeds",
        arguments: Self.equalityArguments
    )
    internal func isUnequalSucceeds(
        lhs: Measure<ComposedUnit>,
        rhs: Measure<ComposedUnit>,
        result: Bool
    ) throws {
        #expect(try lhs.isUnequal(to: rhs) == !result)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureEquatableTests {}
