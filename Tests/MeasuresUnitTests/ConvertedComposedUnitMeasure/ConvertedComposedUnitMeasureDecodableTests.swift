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

@Suite("Converted ComposedUnit Measure Decodable Tests")
internal struct ConvertedComposedUnitMeasureDecodableTests {
    internal init() {}

    @Test(
        "Decode from JSON succeeds",
        arguments: [
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],"value":1}
                """,
                Measure<ComposedUnit>(1, .meter)
            ),
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":0.01,"dimension":{"length":1},"symbol":"cm"}}],\
                "value":100}
                """,
                Measure<ComposedUnit>(100, .centimeter)
            ),
            (
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":0.001,"dimension":{"length":1},"symbol":"mm"}}],\
                "value":1000}
                """,
                Measure<ComposedUnit>(1_000, .millimeter)
            ),
            (
                #"{"unit":[],"value":1}"#,
                Measure<ComposedUnit>(1, .dimensionless)
            )
        ]
    )
    internal func decodeFromJSONSucceeds(
        json: String,
        value: Measure<ComposedUnit>
    ) throws {
        let data: Data = try #require(json.data(using: .utf8))
        let result: Converted<ComposedUnit> = try JSONDecoder().decode(
            Converted<ComposedUnit>.self,
            from: data
        )
        #expect(result.wrappedValue == value)
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
        ]
    )
    internal func decodeFromJSONThrows(json: String) throws {
        let data: Data = try #require(json.data(using: .utf8))
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(
                Converted<ComposedUnit>.self,
                from: data
            )
        }
    }
}

// MARK: - NaT

extension ConvertedComposedUnitMeasureDecodableTests {
    // TODO: Implement NaT tests for this suite.
}
#endif
