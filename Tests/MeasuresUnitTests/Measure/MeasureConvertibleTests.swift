// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Measure Convertible Tests")
internal struct MeasureConvertibleTests {
    @Test("Identical conversions preserve the value and use the destination unit")
    internal func identicalConversionsPreserveValue() {
        let sourceUnit = Length(
            coefficient: 0.01,
            constant: 1e20,
            symbol: "source"
        )
        let destinationUnit = Length(
            coefficient: 0.01,
            constant: 1e20,
            symbol: "destination"
        )
        let source: Measure<Length> = .init(1, sourceUnit)
        let converted = source.converted(to: destinationUnit)
        var mutated = source
        mutated.convert(to: destinationUnit)

        #expect(converted.value == 1)
        #expect(converted.unit == destinationUnit)
        #expect(mutated == converted)
        #expect((source + converted).value == 2)
        #expect((source - converted).value == 0)
    }

    @Test(
        "Length conversion succeeds",
        arguments: [
            (Measure<Length>(1, .meter), .centimeter, Measure<Length>(100, .centimeter)),
            (Measure<Length>(100, .centimeter), .meter, Measure<Length>(1, .meter)),
            (Measure<Length>(1, .foot), .inch, Measure<Length>(12, .inch)),
            (Measure<Length>(1, .yard), .foot, Measure<Length>(3, .foot)),
            (Measure<Length>(1, .kilometer), .meter, Measure<Length>(1_000, .meter))
        ] as Array<(Measure<Length>, Length, Measure<Length>)>
    )
    internal func lengthConversionSucceeds(
        source: Measure<Length>,
        unit: Length,
        expected: Measure<Length>
    ) {
        let converted: Measure<Length> = source.converted(to: unit)
        var mutated: Measure<Length> = source
        mutated.convert(to: unit)

        #expect(abs(converted.value - expected.value) < 1e-10)
        #expect(converted.unit == expected.unit)
        #expect(abs(mutated.value - expected.value) < 1e-10)
        #expect(mutated.unit == expected.unit)
    }

    @Test(
        "Speed conversion succeeds",
        arguments: [
            (Measure<Speed>(36, .kilometersPerHour), .metersPerSecond, Measure<Speed>(10, .metersPerSecond)),
            (Measure<Speed>(10, .metersPerSecond), .kilometersPerHour, Measure<Speed>(36, .kilometersPerHour))
        ] as Array<(Measure<Speed>, Speed, Measure<Speed>)>
    )
    internal func speedConversionSucceeds(
        source: Measure<Speed>,
        unit: Speed,
        expected: Measure<Speed>
    ) {
        let converted: Measure<Speed> = source.converted(to: unit)
        var mutated: Measure<Speed> = source
        mutated.convert(to: unit)

        #expect(abs(converted.value - expected.value) < 1e-10)
        #expect(converted.unit == expected.unit)
        #expect(abs(mutated.value - expected.value) < 1e-10)
        #expect(mutated.unit == expected.unit)
    }

    @Test(
        "Thermodynamic temperature conversion succeeds",
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
    internal func thermodynamicTemperatureConversionSucceeds(
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

    @Test("Frequency converts to time")
    internal func frequencyConvertsToTime() {
        let frequency: Measure<Frequency> = .init(2, .hertz)
        let time: Measure<Time> = frequency.converted(to: .second)

        #expect(time.value == 0.5)
        #expect(time.unit == .second)
    }
}
