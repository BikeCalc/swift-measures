// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Subtractable Tests")
internal struct LengthMeasureSubtractableTests {
    internal init() {}

    private static let subtractionArguments: [(Measure<Length>, Measure<Length>.Subtrahend, Measure<Length>)] = [
        (.init(3.0, .meter), .init(2.0, .meter), .init(1.0, .meter)),
        (.init(5.0, .meter), .init(3.0, .meter), .init(2.0, .meter)),
        (.init(-3.0, .meter), .init(2.0, .meter), .init(-5.0, .meter)),
        (.init(-5.0, .meter), .init(-3.0, .meter), .init(-2.0, .meter)),
        (.init(1.5, .meter), .init(0.5, .meter), .init(1.0, .meter)),
        (.init(3.5, .meter), .init(1.5, .meter), .init(2.0, .meter)),
        (.init(-1.5, .meter), .init(0.5, .meter), .init(-2.0, .meter)),
        (.init(-3.5, .meter), .init(-1.5, .meter), .init(-2.0, .meter)),
        (.init(3.0, .meter), .init(200.0, .centimeter), .init(1.0, .meter)),
        (.init(300.0, .centimeter), .init(2.0, .meter), .init(100.0, .centimeter)),
        (.init(-3.0, .meter), .init(200.0, .centimeter), .init(-5.0, .meter)),
        (.init(-300.0, .centimeter), .init(2.0, .meter), .init(-500.0, .centimeter))
    ]

    @Test(
        "Subtraction succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractionSucceeds(
        minuend: Measure<Length>,
        subtrahend: Measure<Length>.Subtrahend,
        difference: Measure<Length>
    ) {
        let result: Measure<Length> = minuend - subtrahend
        #expect(result == difference)
    }

    @Test(
        "Subtraction equal succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractionEqualSucceeds(
        minuend: Measure<Length>,
        subtrahend: Measure<Length>.Subtrahend,
        difference: Measure<Length>
    ) {
        var result: Measure<Length> = minuend
        result -= subtrahend
        #expect(result == difference)
    }

    @Test(
        "Subtracting succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractingSucceeds(
        minuend: Measure<Length>,
        subtrahend: Measure<Length>.Subtrahend,
        difference: Measure<Length>
    ) throws {
        let result: Measure<Length> = try minuend.subtracting(subtrahend)
        #expect(result == difference)
    }

    @Test(
        "Subtract succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractSucceeds(
        minuend: Measure<Length>,
        subtrahend: Measure<Length>.Subtrahend,
        difference: Measure<Length>
    ) throws {
        var result: Measure<Length> = minuend
        try result.subtract(subtrahend)
        #expect(result == difference)
    }
}

extension LengthMeasureSubtractableTests {
    @Test(
        "Subtraction is not canonically commutative",
        arguments: Self.subtractionArguments
    )
    internal func subtractionIsNotCanonicallyCommutative(
        minuend: Measure<Length>,
        subtrahend: Measure<Length>.Subtrahend,
        difference _: Measure<Length>
    ) {
        let result: Bool = (minuend - subtrahend).isCanonicallyEqual(to: subtrahend - minuend)
        #expect(result == false)
    }
}

// MARK: - NaT

extension LengthMeasureSubtractableTests {
    @Test(
        "NaT propagates through subtraction",
        arguments: [
            (.nat, .init(1, .meter)),
            (.init(1, .meter), .nat),
            (.nat, .nat),
            (.init(1, Length(coefficient: 0, constant: 0, symbol: "invalid")), .init(1, .meter)),
            (.init(1, .meter), .init(1, Length(coefficient: 0, constant: 0, symbol: "invalid")))
        ] as Array<(Measure<Length>, Measure<Length>)>
    )
    internal func subtractionPropagatesNaT(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) {
        let result: Measure<Length> = lhs - rhs
        #expect(result.isNaT == true)
    }
}
