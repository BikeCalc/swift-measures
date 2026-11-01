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
            (
                .init(1, .dimensionless),
                .dimensionless,
                #"{"unit":[],"value":1}"#
            )
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
    // TODO: Implement NaT tests for this suite.
}
#endif
