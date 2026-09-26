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

@Suite("Measure Encodable Tests")
internal struct MeasureEncodableTests {
    @Test(
        "Encode to JSON succeeds",
        arguments: [
            (
                Measure<Length>(1, .meter),
                #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":1}"#
            ),
            (
                Measure<Length>(100, .centimeter),
                #"{"unit":{"coefficient":0.01,"constant":0,"symbol":"cm"},"value":100}"#
            ),
            (
                Measure<Length>(-2, .yard),
                #"{"unit":{"coefficient":0.9144,"constant":0,"symbol":"yd"},"value":-2}"#
            )
        ]
    )
    internal func encodeToJSONSucceeds(
        value: Measure<Length>,
        json: String
    ) throws {
        let encoder: JSONEncoder = .init()
        encoder.outputFormatting = .sortedKeys

        let result: Data = try encoder.encode(value)
        let expected: Data = try #require(json.data(using: .utf8))

        #expect(result == expected)
    }
}
#endif
