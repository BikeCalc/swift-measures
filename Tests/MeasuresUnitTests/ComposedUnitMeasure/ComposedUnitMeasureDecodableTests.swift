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

@testable import CoreMeasureUnits
@testable import Measures

@Suite("ComposedUnit Measure Decodable Tests")
internal struct ComposedUnitMeasureDecodableTests {
    internal init() {}

    @Test(
        "Decode from JSON succeeds",
        arguments: [
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],"value":1}
                """,
                .init(1, .meter)
            ),
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":0.01,"dimension":{"length":1},"symbol":"cm"}}],\
                "value":100}
                """,
                .init(100, .centimeter)
            ),
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":0.001,"dimension":{"length":1},"symbol":"mm"}}],\
                "value":1000}
                """,
                .init(1_000, .millimeter)
            ),
            (#"{"unit":[],"value":1}"#, .init(1, .dimensionless)),
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":1,"constant":273.15,\
                "dimension":{"thermodynamic_temperature":1},"symbol":"°C"}}],"value":20}
                """,
                .init(20, ComposedUnit(ThermodynamicTemperature.celsius))
            ),
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":0.0254,"dimension":{"length":1},"symbol":"in"}},\
                {"exponent":-1,"unit":{"coefficient":60,"dimension":{"time":1},"symbol":"min"}}],"value":10}
                """,
                .init(10, ComposedUnit(Length.inch) / ComposedUnit(Time.minute))
            )
        ] as Array<(String, Measure<ComposedUnit>)>
    )
    internal func decodeFromJSONSucceeds(
        json: String,
        value: Measure<ComposedUnit>
    ) throws {
        let data: Data = try #require(json.data(using: .utf8))
        let result: Measure<ComposedUnit> = try JSONDecoder().decode(
            Measure<ComposedUnit>.self,
            from: data
        )
        #expect(result == value)
    }

    @Test(
        "Decode from JSON throws",
        arguments: [
            #"{"value":1}"#,
            #"{"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}]}"#,
            #"{"unit":[{"exponent":1,"unit":{"dimension":{"length":1},"symbol":"m"}}],"value":1}"#,
            #"{"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1}}}],"value":1}"#,
            #"{"unit":[{"exponent":1,"unit":{"coefficient":1,"symbol":"m"}}],"value":1}"#,
            #"{"unit":[{"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],"value":1}"#,
            #"{"unit":"m","value":1}"#,
            #"{"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],"value":"1"}"#,
            #"[1,"m"]"#,
            #"true"#,
            """
            {"unit":[{"exponent":1,"unit":{"coefficient":0,"constant":0,\
            "dimension":{"thermodynamic_temperature":1},"symbol":"K"}}],"value":1}
            """,
            """
            {"unit":[{"exponent":1,"unit":{"coefficient":-1,"constant":0,\
            "dimension":{"thermodynamic_temperature":1},"symbol":"K"}}],"value":1}
            """,
            """
            {"unit":[{"exponent":2,"unit":{"coefficient":1,"constant":273.15,\
            "dimension":{"thermodynamic_temperature":1},"symbol":"K"}}],"value":1}
            """,
            """
            {"unit":[{"exponent":-1,"unit":{"coefficient":1,"constant":273.15,\
            "dimension":{"thermodynamic_temperature":1},"symbol":"K"}}],"value":1}
            """,
            """
            {"unit":[{"exponent":1,"unit":{"coefficient":1,"constant":273.15,\
            "dimension":{"thermodynamic_temperature":1},"symbol":"K"}},\
            {"exponent":1,"unit":{"coefficient":1,\
            "dimension":{"length":1},"symbol":"m"}}],"value":1}
            """,
            """
            {"unit":[{"exponent":0,"unit":{"coefficient":0,"constant":0,\
            "dimension":{"thermodynamic_temperature":1},"symbol":"K"}}],"value":1}
            """,
            """
            {"unit":[{"exponent":1,"unit":{"coefficient":1,"constant":"0","dimension":{"length":1},\
            "symbol":"m"}}],"value":1}
            """,
            """
            {"unit":[{"exponent":1,"unit":{"coefficient":1,"constant":null,"dimension":{"length":1},\
            "symbol":"m"}}],"value":1}
            """,
            #"{"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":"1"},"symbol":"m"}}],"value":1}"#,
            #"{"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":null},"symbol":"m"}}],"value":1}"#,
            #"{"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":0.5},"symbol":"m"}}],"value":1}"#
        ] as Array<String>
    )
    internal func decodeFromJSONThrows(json: String) throws {
        let data: Data = try #require(json.data(using: .utf8))
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(
                Measure<ComposedUnit>.self,
                from: data
            )
        }
    }
}

// MARK: - NaT

extension ComposedUnitMeasureDecodableTests {
    @Test(
        "Default JSON decoding rejects nonfinite strings",
        arguments: [
            """
            {"unit":[{"exponent":1,"unit":{"coefficient":"NaN","constant":"NaN","dimension":{},\
            "symbol":"NaT"}}],"value":"NaN"}
            """,
            """
            {"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],\
            "value":"NaN"}
            """,
            """
            {"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],\
            "value":"Infinity"}
            """,
            """
            {"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],\
            "value":"-Infinity"}
            """
        ] as Array<String>
    )
    internal func defaultJSONDecodingRejectsNonfiniteStrings(json: String) throws {
        let data: Data = try #require(json.data(using: .utf8))
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(
                Measure<ComposedUnit>.self,
                from: data
            )
        }
    }

    @Test(
        "Configured JSON decoding preserves NaT representation",
        arguments: [
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":"NaN","constant":"NaN","dimension":{},\
                "symbol":"NaT"}}],"value":"NaN"}
                """,
                .nat
            ),
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],\
                "value":"NaN"}
                """,
                .init(Double.nan, .meter)
            ),
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],\
                "value":"Infinity"}
                """,
                .init(Double.infinity, .meter)
            ),
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],\
                "value":"-Infinity"}
                """,
                .init(Double.negativeInfinity, .meter)
            )
        ] as Array<(String, Measure<ComposedUnit>)>
    )
    internal func configuredJSONDecodingPreservesNaT(
        json: String,
        expected: Measure<ComposedUnit>
    ) throws {
        let data: Data = try #require(json.data(using: .utf8))
        let decoder: JSONDecoder = .init()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(
            positiveInfinity: "Infinity",
            negativeInfinity: "-Infinity",
            nan: "NaN"
        )
        let result: Measure<ComposedUnit> = try decoder.decode(
            Measure<ComposedUnit>.self,
            from: data
        )
        #expect(result.isNaT == true)

        if expected.value.isNaN == true {
            #expect(result.value.isNaN == true)
        } else {
            #expect(result.value == expected.value)
        }

        if expected.unit.coefficient.isNaN == true {
            #expect(result.unit.coefficient.isNaN == true)
            #expect(result.unit.constant.isNaN == true)
            #expect(result.unit.symbol == expected.unit.symbol)
        } else {
            #expect(result.unit == expected.unit)
        }

        #expect(result.unit.factors.count == expected.unit.factors.count)
        #expect(result.unit.factors.first?.exponent == expected.unit.factors.first?.exponent)
        #expect(result.unit.dimension == expected.unit.dimension)
    }
}
#endif
