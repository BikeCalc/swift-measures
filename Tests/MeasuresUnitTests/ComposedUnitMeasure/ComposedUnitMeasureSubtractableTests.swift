// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure Subtractable Tests")
internal struct ComposedUnitMeasureSubtractableTests {
    internal init() {}

    private static let subtractionArguments: [
        (Measure<ComposedUnit>, Measure<ComposedUnit>.Subtrahend, Measure<ComposedUnit>)
    ] = [
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
        (.init(-300.0, .centimeter), .init(2.0, .meter), .init(-500.0, .centimeter)),
        (.init(3.0, .dimensionless), .init(2.0, .dimensionless), .init(1.0, .dimensionless)),
        (.init(5.0, .dimensionless), .init(3.0, .dimensionless), .init(2.0, .dimensionless)),
        (.init(-3.0, .dimensionless), .init(2.0, .dimensionless), .init(-5.0, .dimensionless)),
        (.init(-5.0, .dimensionless), .init(-3.0, .dimensionless), .init(-2.0, .dimensionless))
    ]

    @Test(
        "Subtraction succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractionSucceeds(
        minuend: Measure<ComposedUnit>,
        subtrahend: Measure<ComposedUnit>.Subtrahend,
        difference: Measure<ComposedUnit>
    ) {
        #expect(minuend - subtrahend == difference)
    }

    @Test(
        "Subtraction equal succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractionEqualSucceeds(
        minuend: Measure<ComposedUnit>,
        subtrahend: Measure<ComposedUnit>.Subtrahend,
        difference: Measure<ComposedUnit>
    ) {
        var runningDifference: Measure<ComposedUnit> = minuend
        runningDifference -= subtrahend
        #expect(runningDifference == difference)
    }

    @Test(
        "Subtracting succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractingSucceeds(
        minuend: Measure<ComposedUnit>,
        subtrahend: Measure<ComposedUnit>.Subtrahend,
        difference: Measure<ComposedUnit>
    ) throws {
        #expect(try minuend.subtracting(subtrahend) == difference)
    }

    @Test(
        "Subtract succeeds",
        arguments: Self.subtractionArguments
    )
    internal func subtractSucceeds(
        minuend: Measure<ComposedUnit>,
        subtrahend: Measure<ComposedUnit>.Subtrahend,
        difference: Measure<ComposedUnit>
    ) throws {
        var runningDifference: Measure<ComposedUnit> = minuend
        try runningDifference.subtract(subtrahend)
        #expect(runningDifference == difference)
    }
}

extension ComposedUnitMeasureSubtractableTests {
    @Test(
        "Subtraction is not canonically commutative",
        arguments: Self.subtractionArguments
    )
    internal func subtractionIsNotCanonicallyCommutative(
        minuend: Measure<ComposedUnit>,
        subtrahend: Measure<ComposedUnit>.Subtrahend,
        difference _: Measure<ComposedUnit>
    ) {
        #expect((minuend - subtrahend).isCanonicallyEqual(to: subtrahend - minuend) == false)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureSubtractableTests {
    // TODO: Implement NaT tests for this suite.
}
