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
    private static let divisionArguments: [(Measure<Length>, Double, Measure<Length>)] = [
        (Measure<Length>(2, .meter), 2, Measure<Length>(1, .meter)),
        (Measure<Length>(3, .meter), 2, Measure<Length>(1.5, .meter)),
        (Measure<Length>(-2, .meter), 2, Measure<Length>(-1, .meter)),
        (Measure<Length>(-2, .meter), -2, Measure<Length>(1, .meter)),
        (Measure<Length>(150, .centimeter), 3, Measure<Length>(50, .centimeter))
    ]

    private static let halvingArguments: [(Measure<Length>, Measure<Length>)] = [
        (Measure<Length>(2, .meter), Measure<Length>(1, .meter)),
        (Measure<Length>(3, .meter), Measure<Length>(1.5, .meter)),
        (Measure<Length>(-2, .meter), Measure<Length>(-1, .meter)),
        (Measure<Length>(100, .centimeter), Measure<Length>(50, .centimeter))
    ]

    @Test(
        "Is divisible by succeeds",
        arguments: [
            (Measure<Length>(10, .meter), 2, true),
            (Measure<Length>(10, .meter), 3, false),
            (Measure<Length>(-10, .meter), 2, true),
            (Measure<Length>(10.5, .meter), 0.5, true),
            (Measure<Length>(0, .meter), 2, true),
            (Measure<Length>(10, .meter), 0, false),
            (Measure<Length>(100, .centimeter), 2, true)
        ]
    )
    internal func isDivisibleBySucceeds(
        dividend: Measure<Length>,
        divisor: Double,
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
        divisor: Double,
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
        divisor: Double,
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
        divisor: Double,
        quotient: Measure<Length>
    ) {
        #expect(dividend.dividing(by: divisor) == quotient)
    }

    @Test(
        "Divide by succeeds",
        arguments: Self.divisionArguments
    )
    internal func divideBySucceeds(
        dividend: Measure<Length>,
        divisor: Double,
        quotient: Measure<Length>
    ) {
        var runningQuotient: Measure<Length> = dividend
        runningQuotient.divide(by: divisor)
        #expect(runningQuotient == quotient)
    }

    @Test(
        "Halved succeeds",
        arguments: Self.halvingArguments
    )
    internal func halvedSucceeds(
        dividend: Measure<Length>,
        quotient: Measure<Length>
    ) {
        #expect(dividend.halved() == quotient)
    }

    @Test(
        "Halve succeeds",
        arguments: Self.halvingArguments
    )
    internal func halveSucceeds(
        dividend: Measure<Length>,
        quotient: Measure<Length>
    ) {
        var runningQuotient: Measure<Length> = dividend
        runningQuotient.halve()
        #expect(runningQuotient == quotient)
    }
}
