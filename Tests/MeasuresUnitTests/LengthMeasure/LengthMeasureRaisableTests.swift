// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Raisable Tests")
internal struct LengthMeasureRaisableTests {
    internal init() {}

    private static let exponentiationArguments: [(Measure<Length>, Measure<Length>.Exponent, Double)] = [
        (.init(2.0, .meter), 2, 4.0),
        (.init(2.0, .meter), 3, 8.0),
        (.init(2.0, .meter), -2, 0.25),
        (.init(2.0, .meter), -3, 0.125),
        (.init(-2.0, .meter), 2, 4.0),
        (.init(-2.0, .meter), 3, -8.0),
        (.init(-2.0, .meter), -2, 0.25),
        (.init(-2.0, .meter), -3, -0.125),
        (.init(1.0, .meter), -2, 1.0),
        (.init(1.0, .meter), -3, 1.0),
        (.init(-1.0, .meter), -2, 1.0),
        (.init(-1.0, .meter), -3, -1.0),
        (.init(0.5, .meter), 2, 0.25),
        (.init(0.5, .meter), 3, 0.125),
        (.init(0.5, .meter), -2, 4.0),
        (.init(0.5, .meter), -3, 8.0),
        (.init(-0.5, .meter), 2, 0.25),
        (.init(-0.5, .meter), 3, -0.125),
        (.init(-0.5, .meter), -2, 4.0),
        (.init(-0.5, .meter), -3, -8.0),
        (.init(200.0, .centimeter), 2, 4.0),
        (.init(200.0, .centimeter), 3, 8.0),
        (.init(-200.0, .centimeter), 2, 4.0),
        (.init(-200.0, .centimeter), 3, -8.0)
    ]

    @Test(
        "Is power of",
        arguments: [
            (Measure<Length>(4.0, .meter), Measure<Length>(2.0, .meter), false),
            (Measure<Length>(6.0, .meter), Measure<Length>(2.0, .meter), false),
            (Measure<Length>(8.0, .meter), Measure<Length>(2.0, .meter), false),
            (Measure<Length>(9.0, .meter), Measure<Length>(2.0, .meter), false),
            (Measure<Length>(4.0, .meter), Measure<Length>(-2.0, .meter), false),
            (Measure<Length>(-8.0, .meter), Measure<Length>(-2.0, .meter), false),
            (Measure<Length>(6.0, .meter), Measure<Length>(-2.0, .meter), false),
            (Measure<Length>(0.25, .meter), Measure<Length>(2.0, .meter), false),
            (Measure<Length>(4.0, .meter), Measure<Length>(0.5, .meter), false),
            (Measure<Length>(-0.125, .meter), Measure<Length>(-2.0, .meter), false),
            (Measure<Length>(0.2, .meter), Measure<Length>(2.0, .meter), false),
            (Measure<Length>(2.0, .meter), Measure<Length>(200.0, .centimeter), true),
            (Measure<Length>(200.0, .centimeter), Measure<Length>(2.0, .meter), true),
            (Measure<Length>(4.0, .meter), Measure<Length>(200.0, .centimeter), false),
            (Measure<Length>(400.0, .centimeter), Measure<Length>(2.0, .meter), false)
        ]
    )
    internal func isPowerOfSucceeds(
        measure: Measure<Length>,
        base: Measure<Length>,
        result: Bool
    ) {
        #expect(measure.isPower(of: base) == result)
    }

    @Test(
        "Exponentiation succeeds",
        arguments: Self.exponentiationArguments
    )
    internal func exponentiationSucceeds(
        base: Measure<Length>,
        exponent: Measure<Length>.Exponent,
        value: Double
    ) {
        let power: Measure<ComposedUnit> = base ** exponent
        #expect(power.isNaT == false)
        #expect(power.value == value)
        #expect(power.unit.dimension == Dimension(length: exponent))
        #expect(power.unit.coefficient == 1)
        #expect(power.unit.constant == 0)
    }

    @Test(
        "Raising to succeeds",
        arguments: Self.exponentiationArguments
    )
    internal func raisingToSucceeds(
        base: Measure<Length>,
        exponent: Measure<Length>.Exponent,
        value: Double
    ) throws {
        let power: Measure<ComposedUnit> = try base.raising(to: exponent)
        #expect(power.isNaT == false)
        #expect(power.value == value)
        #expect(power.unit.dimension == Dimension(length: exponent))
        #expect(power.unit.coefficient == 1)
        #expect(power.unit.constant == 0)
    }
}

// MARK: - NaT

extension LengthMeasureRaisableTests {}
