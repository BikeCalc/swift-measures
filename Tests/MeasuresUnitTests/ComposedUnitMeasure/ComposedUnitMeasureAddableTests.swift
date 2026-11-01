// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure Addable Tests")
internal struct ComposedUnitMeasureAddableTests {
    internal init() {}

    private static let additionArguments: [
        (Measure<ComposedUnit>, Measure<ComposedUnit>.Addend, Measure<ComposedUnit>)
    ] = [
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
        (.init(-200.0, .centimeter), .init(3.0, .meter), .init(100.0, .centimeter)),
        (.init(2.0, .dimensionless), .init(3.0, .dimensionless), .init(5.0, .dimensionless)),
        (.init(3.0, .dimensionless), .init(4.0, .dimensionless), .init(7.0, .dimensionless)),
        (.init(-2.0, .dimensionless), .init(3.0, .dimensionless), .init(1.0, .dimensionless)),
        (.init(-3.0, .dimensionless), .init(-4.0, .dimensionless), .init(-7.0, .dimensionless))
    ]

    @Test(
        "Addition succeeds",
        arguments: Self.additionArguments
    )
    internal func additionSucceeds(
        augend: Measure<ComposedUnit>,
        addend: Measure<ComposedUnit>.Addend,
        sum: Measure<ComposedUnit>
    ) {
        let result: Measure<ComposedUnit> = augend + addend
        #expect(result == sum)
    }

    @Test(
        "Addition equal succeeds",
        arguments: Self.additionArguments
    )
    internal func additionEqualSucceeds(
        augend: Measure<ComposedUnit>,
        addend: Measure<ComposedUnit>.Addend,
        sum: Measure<ComposedUnit>
    ) {
        var result: Measure<ComposedUnit> = augend
        result += addend
        #expect(result == sum)
    }

    @Test(
        "Adding succeeds",
        arguments: Self.additionArguments
    )
    internal func addingSucceeds(
        augend: Measure<ComposedUnit>,
        addend: Measure<ComposedUnit>.Addend,
        sum: Measure<ComposedUnit>
    ) throws {
        let result: Measure<ComposedUnit> = try augend.adding(addend)
        #expect(result == sum)
    }

    @Test(
        "Add succeeds",
        arguments: Self.additionArguments
    )
    internal func addSucceeds(
        augend: Measure<ComposedUnit>,
        addend: Measure<ComposedUnit>.Addend,
        sum: Measure<ComposedUnit>
    ) throws {
        var result: Measure<ComposedUnit> = augend
        try result.add(addend)
        #expect(result == sum)
    }
}

extension ComposedUnitMeasureAddableTests {
    @Test(
        "Addition is canonically commutative",
        arguments: Self.additionArguments
    )
    internal func additionIsCanonicallyCommutative(
        augend: Measure<ComposedUnit>,
        addend: Measure<ComposedUnit>.Addend,
        sum _: Measure<ComposedUnit>
    ) {
        let result: Bool = (augend + addend).isCanonicallyEqual(to: addend + augend)
        #expect(result == true)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureAddableTests {
    // TODO: Implement NaT tests for this suite.
}
