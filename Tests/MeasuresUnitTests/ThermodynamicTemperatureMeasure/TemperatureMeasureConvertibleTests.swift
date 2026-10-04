// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Temperature Measure Convertible Tests")
internal struct TemperatureMeasureConvertibleTests {
    @Test(
        "Conversion succeeds",
        arguments: [
            (
                Measure<ThermodynamicTemperature>(0, .celsius),
                .kelvin,
                Measure<ThermodynamicTemperature>(273.15, .kelvin)
            ),
            (
                Measure<ThermodynamicTemperature>(273.15, .kelvin),
                .celsius,
                Measure<ThermodynamicTemperature>(0, .celsius)
            ),
            (
                Measure<ThermodynamicTemperature>(32, .fahrenheit),
                .celsius,
                Measure<ThermodynamicTemperature>(0, .celsius)
            )
        ] as Array<(Measure<ThermodynamicTemperature>, ThermodynamicTemperature, Measure<ThermodynamicTemperature>)>
    )
    internal func conversionSucceeds(
        source: Measure<ThermodynamicTemperature>,
        unit: ThermodynamicTemperature,
        expected: Measure<ThermodynamicTemperature>
    ) {
        let converted: Measure<ThermodynamicTemperature> = source.converted(to: unit)
        var mutated: Measure<ThermodynamicTemperature> = source
        mutated.convert(to: unit)

        #expect(abs(converted.value - expected.value) < 1e-10)
        #expect(converted.unit == expected.unit)
        #expect(abs(mutated.value - expected.value) < 1e-10)
        #expect(mutated.unit == expected.unit)
    }
}
