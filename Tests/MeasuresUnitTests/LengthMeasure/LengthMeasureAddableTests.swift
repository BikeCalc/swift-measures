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
        (Measure<Length>(2.0, .meter), Measure<Length>(3.0, .meter), Measure<Length>(5.0, .meter)),
        (Measure<Length>(3.0, .meter), Measure<Length>(4.0, .meter), Measure<Length>(7.0, .meter)),
        (Measure<Length>(-2.0, .meter), Measure<Length>(3.0, .meter), Measure<Length>(1.0, .meter)),
        (Measure<Length>(-3.0, .meter), Measure<Length>(-4.0, .meter), Measure<Length>(-7.0, .meter)),
        (Measure<Length>(0.5, .meter), Measure<Length>(1.5, .meter), Measure<Length>(2.0, .meter)),
        (Measure<Length>(1.5, .meter), Measure<Length>(2.5, .meter), Measure<Length>(4.0, .meter)),
        (Measure<Length>(-0.5, .meter), Measure<Length>(1.5, .meter), Measure<Length>(1.0, .meter)),
        (Measure<Length>(-1.5, .meter), Measure<Length>(-2.5, .meter), Measure<Length>(-4.0, .meter)),
        (Measure<Length>(2.0, .meter), Measure<Length>(300.0, .centimeter), Measure<Length>(5.0, .meter)),
        (Measure<Length>(200.0, .centimeter), Measure<Length>(3.0, .meter), Measure<Length>(500.0, .centimeter)),
        (Measure<Length>(-2.0, .meter), Measure<Length>(300.0, .centimeter), Measure<Length>(1.0, .meter)),
        (Measure<Length>(-200.0, .centimeter), Measure<Length>(3.0, .meter), Measure<Length>(100.0, .centimeter))
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
        #expect(augend + addend == sum)
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
        var runningSum: Measure<Length> = augend
        runningSum += addend
        #expect(runningSum == sum)
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
        #expect(try augend.adding(addend) == sum)
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
        var runningSum: Measure<Length> = augend
        try runningSum.add(addend)
        #expect(runningSum == sum)
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
        #expect((augend + addend).isCanonicallyEqual(to: addend + augend) == true)
    }
}

// MARK: - NaT

extension LengthMeasureAddableTests {}
