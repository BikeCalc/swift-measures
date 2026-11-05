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

@Suite("Converted Length Measure Encodable Tests")
internal struct ConvertedLengthMeasureEncodableTests {
    internal init() {}

    @Test(
        "Encode to JSON succeeds",
        arguments: [
            (.init(1, .meter), #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":1}"#),
            (.init(100, .centimeter), #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":1}"#),
            (.init(1_000, .millimeter), #"{"unit":{"coefficient":1,"constant":0,"symbol":"m"},"value":1}"#)
        ] as Array<(Measure<Length>, String)>
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

// MARK: - NaT

extension ConvertedLengthMeasureEncodableTests {
    @Test(
        "Default JSON encoding rejects NaT",
        arguments: [
            .nat,
            .init(Double.nan, .meter),
            .init(Double.infinity, .meter),
            .init(Double.negativeInfinity, .meter)
        ] as Array<Measure<Length>>
    )
    internal func defaultJSONEncodingRejectsNaT(value: Measure<Length>) {
        let encoded: Converted<Length> = .init(
            wrappedValue: value,
            to: .meter
        )
        #expect(throws: EncodingError.self) {
            try JSONEncoder().encode(encoded)
        }
    }

    @Test(
        "Configured JSON encoding preserves NaT representation",
        arguments: [
            (.nat, #"{"unit":{"coefficient":"NaN","constant":"NaN","symbol":"NaT"},"value":"NaN"}"#),
            (
                .init(Double.nan, .meter),
                #"{"unit":{"coefficient":"NaN","constant":"NaN","symbol":"NaT"},"value":"NaN"}"#
            ),
            (
                .init(Double.infinity, .meter),
                #"{"unit":{"coefficient":"NaN","constant":"NaN","symbol":"NaT"},"value":"NaN"}"#
            ),
            (
                .init(Double.negativeInfinity, .meter),
                #"{"unit":{"coefficient":"NaN","constant":"NaN","symbol":"NaT"},"value":"NaN"}"#
            )
        ] as Array<(Measure<Length>, String)>
    )
    internal func configuredJSONEncodingPreservesNaT(
        value: Measure<Length>,
        json: String
    ) throws {
        let encoded: Converted<Length> = .init(
            wrappedValue: value,
            to: .meter
        )
        let encoder: JSONEncoder = .init()
        encoder.outputFormatting = .sortedKeys
        encoder.nonConformingFloatEncodingStrategy = .convertToString(
            positiveInfinity: "Infinity",
            negativeInfinity: "-Infinity",
            nan: "NaN"
        )
        let result: Data = try encoder.encode(encoded)
        let expected: Data = try #require(json.data(using: .utf8))
        #expect(result == expected)
    }
}
#endif
