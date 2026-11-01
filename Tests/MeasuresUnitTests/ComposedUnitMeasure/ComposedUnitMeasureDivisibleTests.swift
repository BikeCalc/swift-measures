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
            (.init(6.0, .meter), .init(3.0, .meter), true),
            (.init(7.0, .meter), .init(3.0, .meter), false),
            (.init(-6.0, .meter), .init(3.0, .meter), true),
            (.init(-7.0, .meter), .init(3.0, .meter), false),
            (.init(1.5, .meter), .init(0.5, .meter), true),
            (.init(1.5, .meter), .init(2.5, .meter), false),
            (.init(-1.5, .meter), .init(0.5, .meter), true),
            (.init(-1.5, .meter), .init(2.5, .meter), false),
            (.init(6.0, .meter), .init(300.0, .centimeter), true),
            (.init(600.0, .centimeter), .init(3.0, .meter), true),
            (.init(7.0, .meter), .init(300.0, .centimeter), false),
            (.init(700.0, .centimeter), .init(3.0, .meter), false),
            (.init(6.0, .dimensionless), .init(3.0, .dimensionless), true),
            (.init(7.0, .dimensionless), .init(3.0, .dimensionless), false),
            (.init(-6.0, .dimensionless), .init(3.0, .dimensionless), true),
            (.init(-7.0, .dimensionless), .init(3.0, .dimensionless), false)
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>, Bool)>
    )
    internal func isDivisibleBySucceeds(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<ComposedUnit>,
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
        dividend: Measure<ComposedUnit>,
        divisor: Measure<ComposedUnit>.Divisor,
        quotient: Measure<ComposedUnit>
    ) {
        let result: Measure<ComposedUnit> = dividend / divisor
        #expect(result == quotient)
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
        var result: Measure<ComposedUnit> = dividend
        result /= divisor
        #expect(result == quotient)
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
        let result: Measure<ComposedUnit> = try dividend.dividing(by: divisor)
        #expect(result == quotient)
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
        var result: Measure<ComposedUnit> = dividend
        try result.divide(by: divisor)
        #expect(result == quotient)
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
        let result: Measure<ComposedUnit> = dividend % divisor
        #expect(result == remainder)
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
        var result: Measure<ComposedUnit> = dividend
        result %= divisor
        #expect(result == remainder)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureDivisibleTests {
    @Test(
        "NaT divisibility predicate returns false",
        arguments: [
            .init(1, .meter),
            .nat,
            .invalid
        ] as Array<Measure<ComposedUnit>>
    )
    internal func natDivisibilityPredicateReturnsFalse(other: Measure<ComposedUnit>) {
        let isDivisibleResult: Bool = Measure<ComposedUnit>.nat.isDivisible(by: other)
        #expect(isDivisibleResult == false)
        let isFactorResult: Bool = Measure<ComposedUnit>.nat.isFactor(of: other)
        #expect(isFactorResult == false)
    }

    @Test(
        "Dividing NaT by a scalar returns NaT",
        arguments: [
            (.nat, 2.0),
            (.init(Double.nan, .meter), 2.0),
            (.init(Double.infinity, .meter), 2.0),
            (.init(Double.negativeInfinity, .meter), 2.0),
            (.invalid, 2.0)
        ] as Array<(Measure<ComposedUnit>, Double)>
    )
    internal func dividingNaTByScalarReturnsNaT(
        dividend: Measure<ComposedUnit>,
        divisor: Double
    ) {
        let result: Measure<ComposedUnit> = dividend / divisor
        #expect(result.isNaT == true)
    }

    @Test(
        "Dividing by a non-finite scalar returns NaT",
        arguments: [
            (.init(1, .meter), .nan),
            (.init(1, .meter), .infinity),
            (.init(1, .meter), -.infinity)
        ] as Array<(Measure<ComposedUnit>, Double)>
    )
    internal func dividingByNonfiniteScalarReturnsNaT(
        dividend: Measure<ComposedUnit>,
        divisor: Double
    ) {
        let result: Measure<ComposedUnit> = dividend / divisor
        #expect(result.isNaT == true)
    }

    @Test(
        "Dividing by zero returns NaT",
        arguments: [
            (.init(1, .meter), 0.0)
        ] as Array<(Measure<ComposedUnit>, Double)>
    )
    internal func dividingByZeroReturnsNaT(
        dividend: Measure<ComposedUnit>,
        divisor: Double
    ) {
        let result: Measure<ComposedUnit> = dividend / divisor
        #expect(result.isNaT == true)
    }

    @Test(
        "Remainder of NaT returns NaT",
        arguments: [
            (.nat, 2.0),
            (.init(Double.nan, .meter), 2.0),
            (.init(Double.infinity, .meter), 2.0),
            (.init(Double.negativeInfinity, .meter), 2.0),
            (.invalid, 2.0)
        ] as Array<(Measure<ComposedUnit>, Double)>
    )
    internal func remainderOfNaTReturnsNaT(
        dividend: Measure<ComposedUnit>,
        divisor: Double
    ) {
        let result: Measure<ComposedUnit> = dividend % divisor
        #expect(result.isNaT == true)
    }

    @Test(
        "Remainder with a non-finite divisor returns NaT",
        arguments: [
            (.init(1, .meter), .nan),
            (.init(1, .meter), .infinity),
            (.init(1, .meter), -.infinity)
        ] as Array<(Measure<ComposedUnit>, Double)>
    )
    internal func remainderWithNonfiniteDivisorReturnsNaT(
        dividend: Measure<ComposedUnit>,
        divisor: Double
    ) {
        let result: Measure<ComposedUnit> = dividend % divisor
        #expect(result.isNaT == true)
    }

    @Test(
        "Remainder with a zero divisor returns NaT",
        arguments: [
            (.init(1, .meter), 0.0)
        ] as Array<(Measure<ComposedUnit>, Double)>
    )
    internal func remainderWithZeroDivisorReturnsNaT(
        dividend: Measure<ComposedUnit>,
        divisor: Double
    ) {
        let result: Measure<ComposedUnit> = dividend % divisor
        #expect(result.isNaT == true)
    }
}
