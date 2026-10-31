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

import struct CoreMeasureTypes.Dimension

@testable import Measures

@Suite("Dimension Encodable Tests")
internal struct DimensionEncodableTests {
    internal init() {}

    @Test(
        "Encode to JSON succeeds",
        arguments: [
            (Dimension(), #"{}"#),
            (Dimension(length: 1), #"{"length":1}"#),
            (
                Dimension(
                    length: 1,
                    mass: 0,
                    time: 0,
                    electricCurrent: 0,
                    thermodynamicTemperature: 0,
                    substanceAmount: 0,
                    luminousIntensity: 0
                ),
                #"{"length":1}"#
            ),
            (
                Dimension(
                    length: 1,
                    mass: -2,
                    time: 3,
                    electricCurrent: -4,
                    thermodynamicTemperature: 5,
                    substanceAmount: -6,
                    luminousIntensity: 7
                ),
                """
                {"electric_current":-4,"length":1,"luminous_intensity":7,"mass":-2,"substance_amount":-6,\
                "thermodynamic_temperature":5,"time":3}
                """
            )
        ]
    )
    internal func encodeToJSONSucceeds(
        value: Dimension,
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
