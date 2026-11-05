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

@Suite("Converted ComposedUnit Measure Encodable Tests")
internal struct ConvertedComposedUnitMeasureEncodableTests {
    internal init() {}

    @Test(
        "Encode to JSON succeeds",
        arguments: [
            (
                .init(1, .meter),
                .meter,
                #"{"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],"value":1}"#
            ),
            (
                .init(100, .centimeter),
                .meter,
                #"{"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],"value":1}"#
            ),
            (
                .init(1_000, .millimeter),
                .meter,
                #"{"unit":[{"exponent":1,"unit":{"coefficient":1,"dimension":{"length":1},"symbol":"m"}}],"value":1}"#
            ),
            (.init(1, .dimensionless), .dimensionless, #"{"unit":[],"value":1}"#)
        ] as Array<(Measure<ComposedUnit>, ComposedUnit, String)>
    )
    internal func encodeToJSONSucceeds(
        value: Measure<ComposedUnit>,
        unit: ComposedUnit,
        json: String
    ) throws {
        @Converted(to: unit) var convertedValue: Measure<ComposedUnit> = value
        let encoder: JSONEncoder = .init()
        encoder.outputFormatting = .sortedKeys
        let result: Data = try encoder.encode(_convertedValue)
        let expected: Data = try #require(json.data(using: .utf8))
        #expect(result == expected)
    }
}

// MARK: - NaT

extension ConvertedComposedUnitMeasureEncodableTests {
    @Test(
        "Default JSON encoding rejects NaT",
        arguments: [
            .nat,
            .init(Double.nan, .meter),
            .init(Double.infinity, .meter),
            .init(Double.negativeInfinity, .meter)
        ] as Array<Measure<ComposedUnit>>
    )
    internal func defaultJSONEncodingRejectsNaT(value: Measure<ComposedUnit>) {
        let encoded: Converted<ComposedUnit> = .init(
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
            (
                .nat,
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":"NaN","constant":"NaN","dimension":{},\
                "symbol":"NaT"}}],"value":"NaN"}
                """
            ),
            (
                .init(Double.nan, .meter),
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":"NaN","constant":"NaN","dimension":{},\
                "symbol":"NaT"}}],"value":"NaN"}
                """
            ),
            (
                .init(Double.infinity, .meter),
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":"NaN","constant":"NaN","dimension":{},\
                "symbol":"NaT"}}],"value":"NaN"}
                """
            ),
            (
                .init(Double.negativeInfinity, .meter),
                """
                {"unit":[{"exponent":1,"unit":{"coefficient":"NaN","constant":"NaN","dimension":{},\
                "symbol":"NaT"}}],"value":"NaN"}
                """
            )
        ] as Array<(Measure<ComposedUnit>, String)>
    )
    internal func configuredJSONEncodingPreservesNaT(
        value: Measure<ComposedUnit>,
        json: String
    ) throws {
        let encoded: Converted<ComposedUnit> = .init(
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
