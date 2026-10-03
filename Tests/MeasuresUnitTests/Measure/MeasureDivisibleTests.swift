// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Measure Divisible Tests")
internal struct MeasureDivisibleTests {
    private static let divisionArguments: [(Measure<Length>, Measure<Length>.Divisor, Measure<Length>)] = [
        (Measure<Length>(2, .meter), 2, Measure<Length>(1, .meter)),
        (Measure<Length>(3, .meter), 2, Measure<Length>(1.5, .meter)),
        (Measure<Length>(-2, .meter), 2, Measure<Length>(-1, .meter)),
        (Measure<Length>(-2, .meter), -2, Measure<Length>(1, .meter)),
        (Measure<Length>(150, .centimeter), 3, Measure<Length>(50, .centimeter))
    ]

    private static let remainderArguments: [(Measure<Length>, Measure<Length>.RemainderDivisor, Measure<Length>)] = [
        (Measure<Length>(10, .meter), 3, Measure<Length>(1, .meter)),
        (Measure<Length>(10.5, .meter), 3, Measure<Length>(1.5, .meter)),
        (Measure<Length>(-10, .meter), 3, Measure<Length>(-1, .meter)),
        (Measure<Length>(10, .meter), -3, Measure<Length>(1, .meter)),
        (Measure<Length>(150, .centimeter), 40, Measure<Length>(30, .centimeter))
    ]

    @Test(
        "Is divisible by succeeds",
        arguments: [
            (Measure<Length>(10, .meter), Measure<Length>(2, .meter), true),
            (Measure<Length>(10, .meter), Measure<Length>(3, .meter), false),
            (Measure<Length>(-10, .meter), Measure<Length>(2, .meter), true),
            (Measure<Length>(10.5, .meter), Measure<Length>(0.5, .meter), true),
            (Measure<Length>(0, .meter), Measure<Length>(2, .meter), true),
            (Measure<Length>(10, .meter), Measure<Length>(0, .meter), false),
            (Measure<Length>(100, .centimeter), Measure<Length>(2, .centimeter), true)
        ]
    )
    internal func isDivisibleBySucceeds(
        dividend: Measure<Length>,
        divisor: Measure<Length>,
        result: Bool
    ) {
        #expect(dividend.isDivisible(by: divisor) == result)
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
        #expect(dividend / divisor == quotient)
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
        var runningQuotient: Measure<Length> = dividend
        runningQuotient /= divisor
        #expect(runningQuotient == quotient)
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
        #expect(try dividend.dividing(by: divisor) == quotient)
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
        var runningQuotient: Measure<Length> = dividend
        try runningQuotient.divide(by: divisor)
        #expect(runningQuotient == quotient)
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
        #expect(dividend % divisor == remainder)
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
        var runningRemainder: Measure<Length> = dividend
        runningRemainder %= divisor
        #expect(runningRemainder == remainder)
    }
}
