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

@Suite("Converted Length Measure Decodable Tests")
internal struct ConvertedLengthMeasureDecodableTests {
    internal init() {}

    @Test(
        "Decode from JSON succeeds",
        arguments: [
            (#"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":1}"#, .init(1, .meter)),
            (#"{"unit":{"coefficient":0.01,"constant":0,"symbol":"cm"},"value":100}"#, .init(100, .centimeter)),
            (#"{"unit":{"coefficient":0.001,"constant":0,"symbol":"mm"},"value":1000}"#, .init(1_000, .millimeter))
        ] as Array<(String, Measure<Length>)>
    )
    internal func decodeFromJSONSucceeds(
        json: String,
        value: Measure<Length>
    ) throws {
        let data: Data = try #require(json.data(using: .utf8))
        let result: Converted<Length> = try JSONDecoder().decode(
            Converted<Length>.self,
            from: data
        )
        #expect(result.wrappedValue == value)
    }

    @Test(
        "Decode from JSON throws",
        arguments: [
            #"{"value":1}"#,
            #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"}}"#,
            #"{"unit":"m","value":1}"#,
            #"[1,"m"]"#,
            #"true"#
        ] as Array<String>
    )
    internal func decodeFromJSONThrows(json: String) throws {
        let data: Data = try #require(json.data(using: .utf8))
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(
                Converted<Length>.self,
                from: data
            )
        }
    }
}

// MARK: - NaT

extension ConvertedLengthMeasureDecodableTests {
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
                Converted<Length>.self,
                from: data
            )
        }
    }

    @Test(
        "Configured JSON decoding produces the NaT sentinel",
        arguments: [
            #"{"unit":{"coefficient":"NaN","constant":"NaN","symbol":"NaT"},"value":"NaN"}"#,
            #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":"NaN"}"#,
            #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":"Infinity"}"#,
            #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":"-Infinity"}"#
        ] as Array<String>
    )
    internal func configuredJSONDecodingPreservesNaT(json: String) throws {
        let data: Data = try #require(json.data(using: .utf8))
        let decoder: JSONDecoder = .init()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(
            positiveInfinity: "Infinity",
            negativeInfinity: "-Infinity",
            nan: "NaN"
        )
        let result: Converted<Length> = try decoder.decode(
            Converted<Length>.self,
            from: data
        )
        #expect(result.wrappedValue.isNaT == true)
        #expect(result.wrappedValue.value.isNaN == true)
        #expect(result.wrappedValue.unit.coefficient.isNaN == true)
        #expect(result.wrappedValue.unit.constant.isNaN == true)
        #expect(result.wrappedValue.unit.symbol == "NaT")
    }
}
#endif
