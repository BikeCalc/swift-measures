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

@Suite("Converted Measure Decodable Tests")
internal struct ConvertedMeasureDecodableTests {
    @Test(
        "Decode from JSON succeeds",
        arguments: [
            (#"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":1}"#, Measure<Length>(1, .meter)),
            (#"{"unit":{"coefficient":0.01,"constant":0,"symbol":"cm"},"value":100}"#, .init(100, .centimeter)),
            (#"{"unit":{"coefficient":0.001,"constant":0,"symbol":"mm"},"value":1000}"#, .init(1_000, .millimeter))
        ]
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
        ]
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
#endif
