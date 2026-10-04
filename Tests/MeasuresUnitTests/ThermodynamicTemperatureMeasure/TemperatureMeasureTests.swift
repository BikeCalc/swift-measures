// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Temperature Measure Tests")
internal struct TemperatureMeasureTests {
    @Test(
        "Bounded valid range succeeds",
        arguments: [
            (Measure<ThermodynamicTemperature>(0, .kelvin), true),
            (Measure<ThermodynamicTemperature>(-273.15, .celsius), true),
            (Measure<ThermodynamicTemperature>(-459, .fahrenheit), true),
            (Measure<ThermodynamicTemperature>(-1, .kelvin), false),
            (Measure<ThermodynamicTemperature>(-273.16, .celsius), false),
            (Measure<ThermodynamicTemperature>(-460, .fahrenheit), false)
        ]
    )
    internal func boundedValidRangeSucceeds(
        measure: Measure<ThermodynamicTemperature>,
        result: Bool
    ) {
        #expect(measure.isValid == result)
    }
}
