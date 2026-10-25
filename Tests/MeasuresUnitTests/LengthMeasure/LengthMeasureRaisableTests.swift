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
        (.init(2, .meter), 2, 4),
        (.init(1.5, .meter), 2, 2.25),
        (.init(-2, .meter), 2, 4),
        (.init(-2, .meter), 3, -8),
        (.init(2, .meter), -1, 0.5),
        (.init(-2, .meter), -1, -0.5),
        (.init(2, .meter), 0, 1),
        (.init(50, .centimeter), 2, 0.25),
        (.init(50, .centimeter), -1, 2)
    ]

    @Test(
        "Is power of succeeds",
        arguments: [
            (Measure<Length>(2, .meter), Measure<Length>(2, .meter), true),
            (Measure<Length>(4, .meter), Measure<Length>(2, .meter), false),
            (Measure<Length>(-2, .meter), Measure<Length>(-2, .meter), true),
            (Measure<Length>(-2, .meter), Measure<Length>(2, .meter), false),
            (Measure<Length>(1, .meter), Measure<Length>(100, .centimeter), true),
            (Measure<Length>(1, .meter), Measure<Length>(50, .centimeter), false)
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
