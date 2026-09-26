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

@Suite("Measure Decodable Tests")
internal struct MeasureDecodableTests {
    @Test(
        "Decode from JSON succeeds",
        arguments: [
            (#"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":1}"#, Measure<Length>(1, .meter)),
            (#"{"unit":{"coefficient":1,"symbol":"m"},"value":1}"#, Measure<Length>(1, .meter)),
            (#"{"unit":{"coefficient":0.01,"constant":0,"symbol":"cm"},"value":100}"#, .init(100, .centimeter)),
            (#"{"unit":{"coefficient":0.9144,"constant":0,"symbol":"yd"},"value":-2}"#, .init(-2, .yard))
        ]
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
        ]
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
#endif
