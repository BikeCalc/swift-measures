// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Measure Multipliable Tests")
internal struct MeasureMultipliableTests {
    private static let multiplicationArguments: [(Measure<Length>, Measure<Length>.Multiplier, Measure<Length>)] = [
        (Measure<Length>(1, .meter), 2, Measure<Length>(2, .meter)),
        (Measure<Length>(1.5, .meter), 2, Measure<Length>(3, .meter)),
        (Measure<Length>(-1, .meter), 2, Measure<Length>(-2, .meter)),
        (Measure<Length>(-1, .meter), -2, Measure<Length>(2, .meter)),
        (Measure<Length>(50, .centimeter), 3, Measure<Length>(150, .centimeter))
    ]

    @Test(
        "Is multiple of succeeds",
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
    internal func isMultipleOfSucceeds(
        multiplicand: Measure<Length>,
        multiplier: Measure<Length>,
        result: Bool
    ) {
        #expect(multiplicand.isMultiple(of: multiplier) == result)
    }

    @Test(
        "Multiplication succeeds",
        arguments: Self.multiplicationArguments
    )
    internal func multiplicationSucceeds(
        multiplicand: Measure<Length>,
        multiplier: Measure<Length>.Multiplier,
        product: Measure<Length>
    ) {
        #expect(multiplicand * multiplier == product)
    }

    @Test(
        "Multiplication equal succeeds",
        arguments: Self.multiplicationArguments
    )
    internal func multiplicationEqualSucceeds(
        multiplicand: Measure<Length>,
        multiplier: Measure<Length>.Multiplier,
        product: Measure<Length>
    ) {
        var runningProduct: Measure<Length> = multiplicand
        runningProduct *= multiplier
        #expect(runningProduct == product)
    }

    @Test(
        "Multiplying by succeeds",
        arguments: Self.multiplicationArguments
    )
    internal func multiplyingBySucceeds(
        multiplicand: Measure<Length>,
        multiplier: Measure<Length>.Multiplier,
        product: Measure<Length>
    ) throws {
        #expect(try multiplicand.multiplying(by: multiplier) == product)
    }

    @Test(
        "Multiply by succeeds",
        arguments: Self.multiplicationArguments
    )
    internal func multiplyBySucceeds(
        multiplicand: Measure<Length>,
        multiplier: Measure<Length>.Multiplier,
        product: Measure<Length>
    ) throws {
        var runningProduct: Measure<Length> = multiplicand
        try runningProduct.multiply(by: multiplier)
        #expect(runningProduct == product)
    }
}
