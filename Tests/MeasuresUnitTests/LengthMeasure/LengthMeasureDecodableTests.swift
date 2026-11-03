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

@Suite("Length Measure Decodable Tests")
internal struct LengthMeasureDecodableTests {
    internal init() {}

    @Test(
        "Decode from JSON succeeds",
        arguments: [
            (#"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":1}"#, .init(1, .meter)),
            (#"{"unit":{"coefficient":1,"symbol":"m"},"value":1}"#, .init(1, .meter)),
            (#"{"unit":{"coefficient":0.01,"constant":0,"symbol":"cm"},"value":100}"#, .init(100, .centimeter)),
            (#"{"unit":{"coefficient":0.9144,"constant":0,"symbol":"yd"},"value":-2}"#, .init(-2, .yard))
        ] as Array<(String, Measure<Length>)>
    )
    internal func decodeFromJSONSucceeds(
        json: String,
        value: Measure<Length>
    ) throws {
        let data: Data = try #require(json.data(using: .utf8))
        let result: Measure<Length> = try JSONDecoder().decode(
            Measure<Length>.self,
            from: data
        )
        #expect(result == value)
    }

    @Test(
        "Decode from JSON throws",
        arguments: [
            #"{"value":1}"#,
            #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"}}"#,
            #"{"unit":{"constant":0,"symbol":"m"},"value":1}"#,
            #"{"unit":{"coefficient":1,"constant":0},"value":1}"#,
            #"{"unit":"m","value":1}"#,
            #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":"1"}"#,
            #"[1,"m"]"#,
            #"true"#
        ] as Array<String>
    )
    internal func decodeFromJSONThrows(json: String) throws {
        let data: Data = try #require(json.data(using: .utf8))
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(
                Measure<Length>.self,
                from: data
            )
        }
    }
}

// MARK: - NaT

extension LengthMeasureDecodableTests {
    @Test(
        "Default JSON decoding rejects nonfinite strings",
        arguments: [
            #"{"unit":{"coefficient":"NaN","constant":"NaN","symbol":"NaT"},"value":"NaN"}"#,
            #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":"NaN"}"#,
            #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":"Infinity"}"#,
            #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":"-Infinity"}"#
        ] as Array<String>
    )
    internal func defaultJSONDecodingRejectsNonfiniteStrings(json: String) throws {
        let data: Data = try #require(json.data(using: .utf8))
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(
                Measure<Length>.self,
                from: data
            )
        }
    }

    @Test(
        "Configured JSON decoding preserves NaT representation",
        arguments: [
            (
                #"{"unit":{"coefficient":"NaN","constant":"NaN","symbol":"NaT"},"value":"NaN"}"#,
                .nat
            ),
            (
                #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":"NaN"}"#,
                .init(Double.nan, .meter)
            ),
            (
                #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":"Infinity"}"#,
                .init(Double.infinity, .meter)
            ),
            (
                #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":"-Infinity"}"#,
                .init(Double.negativeInfinity, .meter)
            )
        ] as Array<(String, Measure<Length>)>
    )
    internal func configuredJSONDecodingPreservesNaT(
        json: String,
        expected: Measure<Length>
    ) throws {
        let data: Data = try #require(json.data(using: .utf8))
        let decoder: JSONDecoder = .init()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(
            positiveInfinity: "Infinity",
            negativeInfinity: "-Infinity",
            nan: "NaN"
        )
        let result: Measure<Length> = try decoder.decode(
            Measure<Length>.self,
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
    }
}
#endif
