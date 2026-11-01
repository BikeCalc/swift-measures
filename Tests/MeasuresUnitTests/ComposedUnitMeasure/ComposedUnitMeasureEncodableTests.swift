// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

#if canImport(Foundation)
import Foundation
import Testing

@testable import Measures

@Suite("ComposedUnit Measure Encodable Tests")
internal struct ComposedUnitMeasureEncodableTests {
    internal init() {}

    @Test(
        "Encode to JSON succeeds",
        arguments: [
            (
                .init(1, .meter),
                #"{"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],"value":1}"#
            ),
            (
                .init(100, .centimeter),
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":0.01,"dimension":{"length":1},"symbol":"cm"}}],\
                "value":100}
                """
            ),
            (
                .init(1_000, .millimeter),
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":0.001,"dimension":{"length":1},"symbol":"mm"}}],\
                "value":1000}
                """
            ),
            (
                .init(1, .dimensionless),
                #"{"unit":[],"value":1}"#
            ),
            (
                .init(20, ComposedUnit(ThermodynamicTemperature.celsius)),
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":1,"constant":273.15,\
                "dimension":{"thermodynamic_temperature":1},"symbol":"°C"}}],"value":20}
                """
            ),
            (
                .init(10, ComposedUnit(Length.inch) / ComposedUnit(Time.minute)),
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":0.0254,"dimension":{"length":1},"symbol":"in"}},\
                {"exponent":-1,"unit":{"coefficient":60,"dimension":{"time":1},"symbol":"min"}}],"value":10}
                """
            )
        ] as Array<(Measure<ComposedUnit>, String)>
    )
    internal func encodeToJSONSucceeds(
        value: Measure<ComposedUnit>,
        json: String
    ) throws {
        let encoder: JSONEncoder = .init()
        encoder.outputFormatting = .sortedKeys
        let result: Data = try encoder.encode(value)
        let expected: Data = try #require(json.data(using: .utf8))
        #expect(result == expected)
        let decoded: Measure<ComposedUnit> = try JSONDecoder().decode(
            Measure<ComposedUnit>.self,
            from: result
        )
        #expect(decoded == value)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureEncodableTests {
    // TODO: Implement NaT tests for this suite.
}
#endif
