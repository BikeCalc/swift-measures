// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure CustomStringConvertible Tests")
internal struct ComposedUnitMeasureCustomStringConvertibleTests {
    internal init() {}

    @Test(
        "Description succeeds",
        arguments: [
            (Measure<ComposedUnit>(1, .meter), "1.0 m"),
            (Measure<ComposedUnit>(-1, .meter), "-1.0 m"),
            (Measure<ComposedUnit>(0, .meter), "0.0 m"),
            (Measure<ComposedUnit>(100, .centimeter), "100.0 cm"),
            (Measure<ComposedUnit>(1.5, .foot), "1.5 ft"),
            (Measure<ComposedUnit>(1, .dimensionless), "1.0")
        ]
    )
    internal func descriptionSucceeds(
        value: Measure<ComposedUnit>,
        expected: String
    ) {
        #expect(value.description == expected)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureCustomStringConvertibleTests {
    // TODO: Implement NaT tests for this suite.
}
