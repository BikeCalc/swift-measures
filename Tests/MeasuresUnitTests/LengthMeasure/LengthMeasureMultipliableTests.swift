// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Multipliable Tests")
internal struct LengthMeasureMultipliableTests {
    internal init() {}

    private static let multiplicationArguments: [(Measure<Length>, Measure<Length>.Multiplier, Measure<Length>)] = [
        (.init(2.0, .meter), 3.0, .init(6.0, .meter)),
        (.init(3.0, .meter), 4.0, .init(12.0, .meter)),
        (.init(-2.0, .meter), 3.0, .init(-6.0, .meter)),
        (.init(-3.0, .meter), -4.0, .init(12.0, .meter)),
        (.init(0.5, .meter), 1.5, .init(0.75, .meter)),
        (.init(1.5, .meter), 2.5, .init(3.75, .meter)),
        (.init(-0.5, .meter), 1.5, .init(-0.75, .meter)),
        (.init(-1.5, .meter), -2.5, .init(3.75, .meter)),
        (.init(200.0, .centimeter), 3.0, .init(600.0, .centimeter)),
        (.init(300.0, .centimeter), 4.0, .init(1_200.0, .centimeter)),
        (.init(-200.0, .centimeter), 3.0, .init(-600.0, .centimeter)),
        (.init(-300.0, .centimeter), -4.0, .init(1_200.0, .centimeter))
    ]

    @Test(
        "Is multiple of",
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
            (.init(700.0, .centimeter), .init(3.0, .meter), false)
        ] as Array<(Measure<Length>, Measure<Length>, Bool)>
    )
    internal func isMultipleOfSucceeds(
        multiplicand: Measure<Length>,
        multiplier: Measure<Length>,
        expected: Bool
    ) {
        let result: Bool = multiplicand.isMultiple(of: multiplier)
        #expect(result == expected)
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
        let result: Measure<Length> = multiplicand * multiplier
        #expect(result == product)
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
        var result: Measure<Length> = multiplicand
        result *= multiplier
        #expect(result == product)
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
        let result: Measure<Length> = try multiplicand.multiplying(by: multiplier)
        #expect(result == product)
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
        var result: Measure<Length> = multiplicand
        try result.multiply(by: multiplier)
        #expect(result == product)
    }
}

// MARK: - NaT

extension LengthMeasureMultipliableTests {
    // TODO: Implement NaT tests for this suite.
}
