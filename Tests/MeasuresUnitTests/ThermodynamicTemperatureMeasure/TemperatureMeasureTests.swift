// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ThermodynamicTemperature Measure Tests")
internal struct TemperatureMeasureTests {
    internal init() {}

    @Test(
        "Bounded valid range succeeds",
        arguments: [
            (.init(0, .kelvin), true),
            (.init(-273.15, .celsius), true),
            (.init(-459, .fahrenheit), true),
            (.init(-1, .kelvin), false),
            (.init(-273.16, .celsius), false),
            (.init(-460, .fahrenheit), false)
        ] as Array<(Measure<ThermodynamicTemperature>, Bool)>
    )
    internal func boundedValidRangeSucceeds(
        measure: Measure<ThermodynamicTemperature>,
        expected: Bool
    ) {
        #expect(measure.isValid == expected)
    }
}
