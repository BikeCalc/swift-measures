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

@Suite("Converted Measure Encodable Tests")
internal struct ConvertedMeasureEncodableTests {
    @Test(
        "Encode to JSON succeeds",
        arguments: [
            (Measure<Length>(1, .meter), #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":1}"#),
            (Measure<Length>(100, .centimeter), #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":1}"#),
            (Measure<Length>(1_000, .millimeter), #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":1}"#)
        ]
    )
    internal func encodeToJSONSucceeds(
        value: Measure<Length>,
        json: String
    ) throws {
        @Converted(to: .meter) var convertedValue: Measure<Length> = value
        let encoder: JSONEncoder = .init()
        encoder.outputFormatting = .sortedKeys

        let result: Data = try encoder.encode(_convertedValue)
        let expected: Data = try #require(json.data(using: .utf8))

        #expect(result == expected)
    }
}
#endif
