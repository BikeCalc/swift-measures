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
    private static let multipleArguments: [(Measure<Length>, Double, Bool)] = [
        (Measure<Length>(10, .meter), 2, true),
        (Measure<Length>(10, .meter), 3, false),
        (Measure<Length>(-10, .meter), 2, true),
        (Measure<Length>(10.5, .meter), 0.5, true),
        (Measure<Length>(0, .meter), 2, true),
        (Measure<Length>(10, .meter), 0, false),
        (Measure<Length>(100, .centimeter), 2, true)
    ]

    private static let multiplicationArguments: [(Measure<Length>, Double, Measure<Length>)] = [
        (Measure<Length>(1, .meter), 2, Measure<Length>(2, .meter)),
        (Measure<Length>(1.5, .meter), 2, Measure<Length>(3, .meter)),
        (Measure<Length>(-1, .meter), 2, Measure<Length>(-2, .meter)),
        (Measure<Length>(-1, .meter), -2, Measure<Length>(2, .meter)),
        (Measure<Length>(50, .centimeter), 3, Measure<Length>(150, .centimeter))
    ]

    private static let doublingArguments: [(Measure<Length>, Measure<Length>)] = [
        (Measure<Length>(1, .meter), Measure<Length>(2, .meter)),
        (Measure<Length>(1.5, .meter), Measure<Length>(3, .meter)),
        (Measure<Length>(-1, .meter), Measure<Length>(-2, .meter)),
        (Measure<Length>(50, .centimeter), Measure<Length>(100, .centimeter))
    ]

    @Test(
        "Is multiple of succeeds",
        arguments: Self.multipleArguments
    )
    internal func isMultipleOfSucceeds(
        multiplicand: Measure<Length>,
        multiplier: Double,
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
        multiplier: Double,
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
        multiplier: Double,
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
        multiplier: Double,
        product: Measure<Length>
    ) {
        #expect(multiplicand.multiplying(by: multiplier) == product)
    }

    @Test(
        "Multiply by succeeds",
        arguments: Self.multiplicationArguments
    )
    internal func multiplyBySucceeds(
        multiplicand: Measure<Length>,
        multiplier: Double,
        product: Measure<Length>
    ) {
        var runningProduct: Measure<Length> = multiplicand
        runningProduct.multiply(by: multiplier)
        #expect(runningProduct == product)
    }

    @Test(
        "Doubled succeeds",
        arguments: Self.doublingArguments
    )
    internal func doubledSucceeds(
        multiplicand: Measure<Length>,
        product: Measure<Length>
    ) {
        #expect(multiplicand.doubled() == product)
    }

    @Test(
        "Double succeeds",
        arguments: Self.doublingArguments
    )
    internal func doubleSucceeds(
        multiplicand: Measure<Length>,
        product: Measure<Length>
    ) {
        var runningProduct: Measure<Length> = multiplicand
        runningProduct.double()
        #expect(runningProduct == product)
    }
}

extension MeasureMultipliableTests {
    @Test(
        "Multiplication is commutative",
        arguments: Self.multiplicationArguments
    )
    internal func multiplicationIsCommutative(
        multiplicand: Measure<Length>,
        multiplier: Double,
        product _: Measure<Length>
    ) {
        #expect(multiplicand * multiplier == multiplier * multiplicand)
    }
}
