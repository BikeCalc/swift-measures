// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Addable Tests")
internal struct LengthMeasureAddableTests {
    internal init() {}

    private static let additionArguments: [(Measure<Length>, Measure<Length>.Addend, Measure<Length>)] = [
        (.init(2.0, .meter), .init(3.0, .meter), .init(5.0, .meter)),
        (.init(3.0, .meter), .init(4.0, .meter), .init(7.0, .meter)),
        (.init(-2.0, .meter), .init(3.0, .meter), .init(1.0, .meter)),
        (.init(-3.0, .meter), .init(-4.0, .meter), .init(-7.0, .meter)),
        (.init(0.5, .meter), .init(1.5, .meter), .init(2.0, .meter)),
        (.init(1.5, .meter), .init(2.5, .meter), .init(4.0, .meter)),
        (.init(-0.5, .meter), .init(1.5, .meter), .init(1.0, .meter)),
        (.init(-1.5, .meter), .init(-2.5, .meter), .init(-4.0, .meter)),
        (.init(2.0, .meter), .init(300.0, .centimeter), .init(5.0, .meter)),
        (.init(200.0, .centimeter), .init(3.0, .meter), .init(500.0, .centimeter)),
        (.init(-2.0, .meter), .init(300.0, .centimeter), .init(1.0, .meter)),
        (.init(-200.0, .centimeter), .init(3.0, .meter), .init(100.0, .centimeter))
    ]

    @Test(
        "Addition succeeds",
        arguments: Self.additionArguments
    )
    internal func additionSucceeds(
        augend: Measure<Length>,
        addend: Measure<Length>.Addend,
        sum: Measure<Length>
    ) {
        let result: Measure<Length> = augend + addend
        #expect(result == sum)
    }

    @Test(
        "Addition equal succeeds",
        arguments: Self.additionArguments
    )
    internal func additionEqualSucceeds(
        augend: Measure<Length>,
        addend: Measure<Length>.Addend,
        sum: Measure<Length>
    ) {
        var result: Measure<Length> = augend
        result += addend
        #expect(result == sum)
    }

    @Test(
        "Adding succeeds",
        arguments: Self.additionArguments
    )
    internal func addingSucceeds(
        augend: Measure<Length>,
        addend: Measure<Length>.Addend,
        sum: Measure<Length>
    ) throws {
        let result: Measure<Length> = try augend.adding(addend)
        #expect(result == sum)
    }

    @Test(
        "Add succeeds",
        arguments: Self.additionArguments
    )
    internal func addSucceeds(
        augend: Measure<Length>,
        addend: Measure<Length>.Addend,
        sum: Measure<Length>
    ) throws {
        var result: Measure<Length> = augend
        try result.add(addend)
        #expect(result == sum)
    }
}

extension LengthMeasureAddableTests {
    @Test(
        "Addition is canonically commutative",
        arguments: Self.additionArguments
    )
    internal func additionIsCanonicallyCommutative(
        augend: Measure<Length>,
        addend: Measure<Length>.Addend,
        sum _: Measure<Length>
    ) {
        let result: Bool = (augend + addend).isCanonicallyEqual(to: addend + augend)
        #expect(result == true)
    }
}

// MARK: - NaT

extension LengthMeasureAddableTests {
    @Test(
        "NaT propagates through addition",
        arguments: [
            (.nat, .init(1, .meter)),
            (.init(1, .meter), .nat),
            (.nat, .nat),
            (.init(1, Length(coefficient: 0, constant: 0, symbol: "invalid")), .init(1, .meter)),
            (.init(1, .meter), .init(1, Length(coefficient: 0, constant: 0, symbol: "invalid")))
        ] as Array<(Measure<Length>, Measure<Length>)>
    )
    internal func additionPropagatesNaT(
        lhs: Measure<Length>,
        rhs: Measure<Length>
    ) {
        let result: Measure<Length> = lhs + rhs
        #expect(result.isNaT == true)
    }
}
