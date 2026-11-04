// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ThermodynamicTemperature Measure Invertible Tests")
internal struct TemperatureMeasureInvertibleTests {
    internal init() {}

    @Test(
        "Reciprocal applies the temperature offset before inversion",
        arguments: [
            (.init(0.0, .celsius), 1.0 / 273.15),
            (.init(273.15, .kelvin), 1.0 / 273.15),
            (.init(0.0, .kelvin), nil),
            (.init(-273.15, .celsius), nil),
            (.init(-1.0, .kelvin), -1.0)
        ] as Array<(Measure<ThermodynamicTemperature>, Double?)>
    )
    internal func reciprocalUsesCoherentTemperature(
        value: Measure<ThermodynamicTemperature>,
        expected: Double?
    ) {
        let result: Measure<ThermodynamicTemperature>.Reciprocal? = value.reciprocal
        #expect(result?.value == expected)
        #expect(value.isInvertible == (expected != nil))

        if let result {
            #expect(result.unit.dimension == .init(thermodynamicTemperature: -1))
            #expect(result.unit.coefficient == 1.0)
            #expect(result.unit.constant == 0.0)
        }
    }

    @Test(
        "Is invertible",
        arguments: [
            (.init(0.0, .celsius), true),
            (.init(273.15, .kelvin), true),
            (.init(0.0, .kelvin), false),
            (.init(-273.15, .celsius), false),
            (.init(-1.0, .kelvin), true)
        ] as Array<(Measure<ThermodynamicTemperature>, Bool)>
    )
    internal func isInvertible(
        dividend: Measure<ThermodynamicTemperature>,
        expected: Bool
    ) {
        let result: Bool = dividend.isInvertible
        #expect(result == expected)
    }
}
