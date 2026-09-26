// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Measure Addable Tests")
internal struct MeasureAddableTests {
    private static let additionArguments: [(Measure<Length>, Measure<Length>, Measure<Length>)] = [
        (Measure<Length>(1, .meter), Measure<Length>(2, .meter), Measure<Length>(3, .meter)),
        (Measure<Length>(1, .meter), Measure<Length>(100, .centimeter), Measure<Length>(2, .meter)),
        (Measure<Length>(100, .centimeter), Measure<Length>(1, .meter), Measure<Length>(200, .centimeter)),
        (Measure<Length>(-1, .meter), Measure<Length>(50, .centimeter), Measure<Length>(-0.5, .meter)),
        (Measure<Length>(-100, .centimeter), Measure<Length>(-1, .meter), Measure<Length>(-200, .centimeter))
    ]

    @Test(
        "Addition succeeds",
        arguments: Self.additionArguments
    )
    internal func additionSucceeds(
        augend: Measure<Length>,
        addend: Measure<Length>,
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
        addend: Measure<Length>,
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
        addend: Measure<Length>,
        sum: Measure<Length>
    ) {
        #expect(augend.adding(addend) == sum)
    }

    @Test(
        "Add succeeds",
        arguments: Self.additionArguments
    )
    internal func addSucceeds(
        augend: Measure<Length>,
        addend: Measure<Length>,
        sum: Measure<Length>
    ) {
        var runningSum: Measure<Length> = augend
        runningSum.add(addend)
        #expect(runningSum == sum)
    }
}

extension MeasureAddableTests {
    @Test(
        "Addition is canonically commutative",
        arguments: Self.additionArguments
    )
    internal func additionIsCanonicallyCommutative(
        augend: Measure<Length>,
        addend: Measure<Length>,
        sum _: Measure<Length>
    ) {
        #expect((augend + addend).isCanonicallyEquatable(to: addend + augend))
    }
}
