// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure Tests")
internal struct ComposedUnitMeasureTests {
    internal init() {}

    @Test(
        "Binary integer initialization succeeds",
        arguments: [
            (-2, -2.0),
            (0, 0.0),
            (2, 2.0)
        ] as Array<(Int, Double)>
    )
    internal func binaryIntegerInitializationSucceeds(
        value: Int,
        expectedValue: Double
    ) {
        let measure: Measure<ComposedUnit> = .init(value, .meter)
        #expect(measure.value == expectedValue)
        #expect(measure.unit == .meter)
    }

    @Test(
        "Binary floating-point initialization succeeds",
        arguments: [
            (.init(-1.5), -1.5),
            (.init(0), 0.0),
            (.init(1.5), 1.5)
        ] as Array<(Float, Double)>
    )
    internal func binaryFloatingPointInitializationSucceeds(
        value: Float,
        expectedValue: Double
    ) {
        let measure: Measure<ComposedUnit> = .init(value, .centimeter)
        #expect(measure.value == expectedValue)
        #expect(measure.unit == .centimeter)
    }
}
