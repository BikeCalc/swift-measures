// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Measure Tests")
internal struct MeasureTests {
    @Test(
        "Binary integer initialization succeeds",
        arguments: [
            (-2, -2.0),
            (0, 0.0),
            (2, 2.0)
        ]
    )
    internal func binaryIntegerInitializationSucceeds(
        value: Int,
        expectedValue: Double
    ) {
        let measure: Measure<Length> = .init(value, .meter)

        #expect(measure.value == expectedValue)
        #expect(measure.unit == .meter)
    }

    @Test(
        "Binary floating-point initialization succeeds",
        arguments: [
            (Float(-1.5), -1.5),
            (Float(0), 0.0),
            (Float(1.5), 1.5)
        ]
    )
    internal func binaryFloatingPointInitializationSucceeds(
        value: Float,
        expectedValue: Double
    ) {
        let measure: Measure<Length> = .init(value, .centimeter)

        #expect(measure.value == expectedValue)
        #expect(measure.unit == .centimeter)
    }

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

    @Test(
        "Unbounded valid range succeeds",
        arguments: [
            Measure<Length>(-1, .meter),
            Measure<Length>(0, .meter),
            Measure<Length>(1, .meter)
        ]
    )
    internal func unboundedValidRangeSucceeds(measure: Measure<Length>) {
        #expect(measure.isValid)
    }

    @Test(
        "Invalid conversion makes measure invalid",
        arguments: [
            (Measure<Length>(1, .meter), true),
            (Measure<Length>(-1, .meter), true),
            (Measure<Length>(Double.infinity, .meter), false),
            (Measure<Length>(-Double.infinity, .meter), false),
            (Measure<Length>(Double.nan, .meter), false),
            (Measure<Length>(1, Length(coefficient: 0, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: -0.0, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: .infinity, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: -.infinity, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: .nan, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: 1, constant: .infinity, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: 1, constant: -.infinity, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: 1, constant: .nan, symbol: "u")), false)
        ]
    )
    internal func invalidConversionMakesMeasureInvalid(
        measure: Measure<Length>,
        result: Bool
    ) {
        #expect(measure.isValid == result)
    }
}
