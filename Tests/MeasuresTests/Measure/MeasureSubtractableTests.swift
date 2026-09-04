// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Measure Subtractable Tests")
internal struct MeasureSubtractableTests {
    private static let subtractionArguments: [(Measure<Length>, Measure<Length>, Measure<Length>)] = [
        (Measure<Length>(3, .meter), Measure<Length>(1, .meter), Measure<Length>(2, .meter)),
        (Measure<Length>(2, .meter), Measure<Length>(50, .centimeter), Measure<Length>(1.5, .meter)),
        (Measure<Length>(200, .centimeter), Measure<Length>(1, .meter), Measure<Length>(100, .centimeter)),
        (Measure<Length>(-1, .meter), Measure<Length>(50, .centimeter), Measure<Length>(-1.5, .meter)),
        (Measure<Length>(-100, .centimeter), Measure<Length>(-50, .centimeter), Measure<Length>(-50, .centimeter))
    ]

    @Test(
        "Subtraction succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractionSucceeds(
        minuend: Measure<Length>,
        subtrahend: Measure<Length>,
        difference: Measure<Length>
    ) {
        #expect(minuend - subtrahend == difference)
    }

    @Test(
        "Subtraction equal succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractionEqualSucceeds(
        minuend: Measure<Length>,
        subtrahend: Measure<Length>,
        difference: Measure<Length>
    ) {
        var runningDifference: Measure<Length> = minuend
        runningDifference -= subtrahend
        #expect(runningDifference == difference)
    }

    @Test(
        "Subtracting succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractingSucceeds(
        minuend: Measure<Length>,
        subtrahend: Measure<Length>,
        difference: Measure<Length>
    ) {
        #expect(minuend.subtracting(subtrahend) == difference)
    }

    @Test(
        "Subtract succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractSucceeds(
        minuend: Measure<Length>,
        subtrahend: Measure<Length>,
        difference: Measure<Length>
    ) {
        var runningDifference: Measure<Length> = minuend
        runningDifference.subtract(subtrahend)
        #expect(runningDifference == difference)
    }
}

extension MeasureSubtractableTests {
    @Test(
        "Subtraction is not canonically commutative",
        arguments: Self.subtractionArguments
    )
    internal func subtractionIsNotCanonicallyCommutative(
        minuend: Measure<Length>,
        subtrahend: Measure<Length>,
        difference _: Measure<Length>
    ) {
        #expect(!(minuend - subtrahend).isCanonicallyEquatable(to: subtrahend - minuend))
    }
}
