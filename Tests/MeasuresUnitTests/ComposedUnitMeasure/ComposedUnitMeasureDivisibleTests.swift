// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure Divisible Tests")
internal struct ComposedUnitMeasureDivisibleTests {
    internal init() {}

    private static let divisionArguments: [
        (Measure<ComposedUnit>, Measure<ComposedUnit>.Divisor, Measure<ComposedUnit>)
    ] = [
        (.init(6.0, .meter), 2.0, .init(3.0, .meter)),
        (.init(6.0, .meter), 3.0, .init(2.0, .meter)),
        (.init(-6.0, .meter), 2.0, .init(-3.0, .meter)),
        (.init(-6.0, .meter), -3.0, .init(2.0, .meter)),
        (.init(1.5, .meter), 0.5, .init(3.0, .meter)),
        (.init(3.75, .meter), 1.5, .init(2.5, .meter)),
        (.init(-1.5, .meter), 0.5, .init(-3.0, .meter)),
        (.init(-3.75, .meter), -1.5, .init(2.5, .meter)),
        (.init(600.0, .centimeter), 2.0, .init(300.0, .centimeter)),
        (.init(600.0, .centimeter), 3.0, .init(200.0, .centimeter)),
        (.init(-600.0, .centimeter), 2.0, .init(-300.0, .centimeter)),
        (.init(-600.0, .centimeter), -3.0, .init(200.0, .centimeter)),
        (.init(6.0, .dimensionless), 2.0, .init(3.0, .dimensionless)),
        (.init(6.0, .dimensionless), 3.0, .init(2.0, .dimensionless)),
        (.init(-6.0, .dimensionless), 2.0, .init(-3.0, .dimensionless)),
        (.init(-6.0, .dimensionless), -3.0, .init(2.0, .dimensionless))
    ]

    private static let remainderArguments: [
        (Measure<ComposedUnit>, Measure<ComposedUnit>.RemainderDivisor, Measure<ComposedUnit>)
    ] = [
        (.init(4.0, .meter), 2.0, .init(0.0, .meter)),
        (.init(5.0, .meter), 2.0, .init(1.0, .meter)),
        (.init(5.0, .meter), -2.0, .init(1.0, .meter)),
        (.init(-5.0, .meter), 2.0, .init(-1.0, .meter)),
        (.init(-5.0, .meter), -2.0, .init(-1.0, .meter)),
        (.init(1.5, .meter), 0.5, .init(0.0, .meter)),
        (.init(1.75, .meter), 0.5, .init(0.25, .meter)),
        (.init(-1.75, .meter), 0.5, .init(-0.25, .meter)),
        (.init(-1.75, .meter), -0.5, .init(-0.25, .meter)),
        (.init(500.0, .centimeter), 200.0, .init(100.0, .centimeter)),
        (.init(500.0, .centimeter), -200.0, .init(100.0, .centimeter)),
        (.init(-500.0, .centimeter), 200.0, .init(-100.0, .centimeter)),
        (.init(-500.0, .centimeter), -200.0, .init(-100.0, .centimeter)),
        (.init(4.0, .dimensionless), 2.0, .init(0.0, .dimensionless)),
        (.init(5.0, .dimensionless), 2.0, .init(1.0, .dimensionless)),
        (.init(5.0, .dimensionless), -2.0, .init(1.0, .dimensionless)),
        (.init(-5.0, .dimensionless), 2.0, .init(-1.0, .dimensionless))
    ]

    @Test(
        "Is divisible by",
        arguments: [
            (Measure<ComposedUnit>(6.0, .meter), Measure<ComposedUnit>(3.0, .meter), true),
            (Measure<ComposedUnit>(7.0, .meter), Measure<ComposedUnit>(3.0, .meter), false),
            (Measure<ComposedUnit>(-6.0, .meter), Measure<ComposedUnit>(3.0, .meter), true),
            (Measure<ComposedUnit>(-7.0, .meter), Measure<ComposedUnit>(3.0, .meter), false),
            (Measure<ComposedUnit>(1.5, .meter), Measure<ComposedUnit>(0.5, .meter), true),
            (Measure<ComposedUnit>(1.5, .meter), Measure<ComposedUnit>(2.5, .meter), false),
            (Measure<ComposedUnit>(-1.5, .meter), Measure<ComposedUnit>(0.5, .meter), true),
            (Measure<ComposedUnit>(-1.5, .meter), Measure<ComposedUnit>(2.5, .meter), false),
            (Measure<ComposedUnit>(6.0, .meter), Measure<ComposedUnit>(300.0, .centimeter), true),
            (Measure<ComposedUnit>(600.0, .centimeter), Measure<ComposedUnit>(3.0, .meter), true),
            (Measure<ComposedUnit>(7.0, .meter), Measure<ComposedUnit>(300.0, .centimeter), false),
            (Measure<ComposedUnit>(700.0, .centimeter), Measure<ComposedUnit>(3.0, .meter), false),
            (Measure<ComposedUnit>(6.0, .dimensionless), Measure<ComposedUnit>(3.0, .dimensionless), true),
            (Measure<ComposedUnit>(7.0, .dimensionless), Measure<ComposedUnit>(3.0, .dimensionless), false),
            (Measure<ComposedUnit>(-6.0, .dimensionless), Measure<ComposedUnit>(3.0, .dimensionless), true),
            (Measure<ComposedUnit>(-7.0, .dimensionless), Measure<ComposedUnit>(3.0, .dimensionless), false)
        ]
    )
    internal func isDivisibleBySucceeds(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<ComposedUnit>,
        result: Bool
    ) {
        #expect(dividend.isDivisible(by: divisor) == result)
    }

    @Test(
        "Division succeeds",
        arguments: Self.divisionArguments
    )
    internal func divisionSucceeds(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<ComposedUnit>.Divisor,
        quotient: Measure<ComposedUnit>
    ) {
        #expect(dividend / divisor == quotient)
    }

    @Test(
        "Division equal succeeds",
        arguments: Self.divisionArguments
    )
    internal func divisionEqualSucceeds(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<ComposedUnit>.Divisor,
        quotient: Measure<ComposedUnit>
    ) {
        var runningQuotient: Measure<ComposedUnit> = dividend
        runningQuotient /= divisor
        #expect(runningQuotient == quotient)
    }

    @Test(
        "Dividing by succeeds",
        arguments: Self.divisionArguments
    )
    internal func dividingBySucceeds(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<ComposedUnit>.Divisor,
        quotient: Measure<ComposedUnit>
    ) throws {
        #expect(try dividend.dividing(by: divisor) == quotient)
    }

    @Test(
        "Divide by succeeds",
        arguments: Self.divisionArguments
    )
    internal func divideBySucceeds(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<ComposedUnit>.Divisor,
        quotient: Measure<ComposedUnit>
    ) throws {
        var runningQuotient: Measure<ComposedUnit> = dividend
        try runningQuotient.divide(by: divisor)
        #expect(runningQuotient == quotient)
    }

    @Test(
        "Remainder succeeds",
        arguments: Self.remainderArguments
    )
    internal func remainderSucceeds(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<ComposedUnit>.RemainderDivisor,
        remainder: Measure<ComposedUnit>
    ) {
        #expect(dividend % divisor == remainder)
    }

    @Test(
        "Remainder equal succeeds",
        arguments: Self.remainderArguments
    )
    internal func remainderEqualSucceeds(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<ComposedUnit>.RemainderDivisor,
        remainder: Measure<ComposedUnit>
    ) {
        var runningRemainder: Measure<ComposedUnit> = dividend
        runningRemainder %= divisor
        #expect(runningRemainder == remainder)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureDivisibleTests {}
