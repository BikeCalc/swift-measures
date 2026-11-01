// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Divisible Tests")
internal struct LengthMeasureDivisibleTests {
    internal init() {}

    private static let divisionArguments: [(Measure<Length>, Measure<Length>.Divisor, Measure<Length>)] = [
        (Measure<Length>(6.0, .meter), 2.0, Measure<Length>(3.0, .meter)),
        (Measure<Length>(6.0, .meter), 3.0, Measure<Length>(2.0, .meter)),
        (Measure<Length>(-6.0, .meter), 2.0, Measure<Length>(-3.0, .meter)),
        (Measure<Length>(-6.0, .meter), -3.0, Measure<Length>(2.0, .meter)),
        (Measure<Length>(1.5, .meter), 0.5, Measure<Length>(3.0, .meter)),
        (Measure<Length>(3.75, .meter), 1.5, Measure<Length>(2.5, .meter)),
        (Measure<Length>(-1.5, .meter), 0.5, Measure<Length>(-3.0, .meter)),
        (Measure<Length>(-3.75, .meter), -1.5, Measure<Length>(2.5, .meter)),
        (Measure<Length>(600.0, .centimeter), 2.0, Measure<Length>(300.0, .centimeter)),
        (Measure<Length>(600.0, .centimeter), 3.0, Measure<Length>(200.0, .centimeter)),
        (Measure<Length>(-600.0, .centimeter), 2.0, Measure<Length>(-300.0, .centimeter)),
        (Measure<Length>(-600.0, .centimeter), -3.0, Measure<Length>(200.0, .centimeter))
    ]

    private static let remainderArguments: [(Measure<Length>, Measure<Length>.RemainderDivisor, Measure<Length>)] = [
        (Measure<Length>(4.0, .meter), 2.0, Measure<Length>(0.0, .meter)),
        (Measure<Length>(5.0, .meter), 2.0, Measure<Length>(1.0, .meter)),
        (Measure<Length>(5.0, .meter), -2.0, Measure<Length>(1.0, .meter)),
        (Measure<Length>(-5.0, .meter), 2.0, Measure<Length>(-1.0, .meter)),
        (Measure<Length>(-5.0, .meter), -2.0, Measure<Length>(-1.0, .meter)),
        (Measure<Length>(1.5, .meter), 0.5, Measure<Length>(0.0, .meter)),
        (Measure<Length>(1.75, .meter), 0.5, Measure<Length>(0.25, .meter)),
        (Measure<Length>(-1.75, .meter), 0.5, Measure<Length>(-0.25, .meter)),
        (Measure<Length>(-1.75, .meter), -0.5, Measure<Length>(-0.25, .meter)),
        (Measure<Length>(500.0, .centimeter), 200.0, Measure<Length>(100.0, .centimeter)),
        (Measure<Length>(500.0, .centimeter), -200.0, Measure<Length>(100.0, .centimeter)),
        (Measure<Length>(-500.0, .centimeter), 200.0, Measure<Length>(-100.0, .centimeter)),
        (Measure<Length>(-500.0, .centimeter), -200.0, Measure<Length>(-100.0, .centimeter))
    ]

    @Test(
        "Is divisible by",
        arguments: [
            (Measure<Length>(6.0, .meter), Measure<Length>(3.0, .meter), true),
            (Measure<Length>(7.0, .meter), Measure<Length>(3.0, .meter), false),
            (Measure<Length>(-6.0, .meter), Measure<Length>(3.0, .meter), true),
            (Measure<Length>(-7.0, .meter), Measure<Length>(3.0, .meter), false),
            (Measure<Length>(1.5, .meter), Measure<Length>(0.5, .meter), true),
            (Measure<Length>(1.5, .meter), Measure<Length>(2.5, .meter), false),
            (Measure<Length>(-1.5, .meter), Measure<Length>(0.5, .meter), true),
            (Measure<Length>(-1.5, .meter), Measure<Length>(2.5, .meter), false),
            (Measure<Length>(6.0, .meter), Measure<Length>(300.0, .centimeter), true),
            (Measure<Length>(600.0, .centimeter), Measure<Length>(3.0, .meter), true),
            (Measure<Length>(7.0, .meter), Measure<Length>(300.0, .centimeter), false),
            (Measure<Length>(700.0, .centimeter), Measure<Length>(3.0, .meter), false)
        ]
    )
    internal func isDivisibleBySucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>,
        expected: Bool
    ) {
        let result: Bool = dividend.isDivisible(by: divisor)
        #expect(result == expected)
    }

    @Test(
        "Division succeeds",
        arguments: Self.divisionArguments
    )
    internal func divisionSucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.Divisor,
        quotient: Measure<Length>
    ) {
        let result: Measure<Length> = dividend / divisor
        #expect(result == quotient)
    }

    @Test(
        "Division equal succeeds",
        arguments: Self.divisionArguments
    )
    internal func divisionEqualSucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.Divisor,
        quotient: Measure<Length>
    ) {
        var result: Measure<Length> = dividend
        result /= divisor
        #expect(result == quotient)
    }

    @Test(
        "Dividing by succeeds",
        arguments: Self.divisionArguments
    )
    internal func dividingBySucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.Divisor,
        quotient: Measure<Length>
    ) throws {
        let result: Measure<Length> = try dividend.dividing(by: divisor)
        #expect(result == quotient)
    }

    @Test(
        "Divide by succeeds",
        arguments: Self.divisionArguments
    )
    internal func divideBySucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.Divisor,
        quotient: Measure<Length>
    ) throws {
        var result: Measure<Length> = dividend
        try result.divide(by: divisor)
        #expect(result == quotient)
    }

    @Test(
        "Remainder succeeds",
        arguments: Self.remainderArguments
    )
    internal func remainderSucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.RemainderDivisor,
        remainder: Measure<Length>
    ) {
        let result: Measure<Length> = dividend % divisor
        #expect(result == remainder)
    }

    @Test(
        "Remainder equal succeeds",
        arguments: Self.remainderArguments
    )
    internal func remainderEqualSucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>.RemainderDivisor,
        remainder: Measure<Length>
    ) {
        var result: Measure<Length> = dividend
        result %= divisor
        #expect(result == remainder)
    }
}

// MARK: - NaT

extension LengthMeasureDivisibleTests {
    // TODO: Implement NaT tests for this suite.
}
