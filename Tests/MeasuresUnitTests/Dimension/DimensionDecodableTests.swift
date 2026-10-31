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

@Suite("Dimension Decodable Tests")
internal struct DimensionDecodableTests {
    internal init() {}

    @Test(
        "Decode from JSON succeeds",
        arguments: [
            (#"{}"#, Dimension()),
            (
                """
                {"electric_current":0,"length":0,"luminous_intensity":0,"mass":0,"substance_amount":0,\
                "thermodynamic_temperature":0,"time":0}
                """,
                Dimension()
            ),
            (#"{"length":1}"#, Dimension(length: 1)),
            (
                """
                {"electric_current":0,"length":1,"luminous_intensity":0,"mass":0,"substance_amount":0,\
                "thermodynamic_temperature":0,"time":0}
                """,
                Dimension(length: 1)
            ),
            (
                """
                {"electric_current":-4,"length":1,"luminous_intensity":7,"mass":-2,"substance_amount":-6,\
                "thermodynamic_temperature":5,"time":3}
                """,
                Dimension(
                    length: 1,
                    mass: -2,
                    time: 3,
                    electricCurrent: -4,
                    thermodynamicTemperature: 5,
                    substanceAmount: -6,
                    luminousIntensity: 7
                )
            )
        ]
    )
    internal func decodeFromJSONSucceeds(
        json: String,
        value: Dimension
    ) throws {
        let data: Data = try #require(json.data(using: .utf8))
        let result: Dimension = try JSONDecoder().decode(
            Dimension.self,
            from: data
        )
        #expect(result == value)
    }

    @Test(
        "Decode from JSON throws",
        arguments: [
            #"{"length":null}"#,
            #"{"length":"1"}"#,
            #"{"mass":null}"#,
            #"{"mass":"1"}"#,
            #"{"time":null}"#,
            #"{"time":"1"}"#,
            #"{"electric_current":null}"#,
            #"{"electric_current":"1"}"#,
            #"{"thermodynamic_temperature":null}"#,
            #"{"thermodynamic_temperature":"1"}"#,
            #"{"substance_amount":null}"#,
            #"{"substance_amount":"1"}"#,
            #"{"luminous_intensity":null}"#,
            #"{"luminous_intensity":"1"}"#,
            #"{"length":0.5}"#,
            #"[]"#,
            #"true"#
        ]
    )
    internal func decodeFromJSONThrows(json: String) throws {
        let data: Data = try #require(json.data(using: .utf8))
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(
                Dimension.self,
                from: data
            )
        }
    }
}
#endif
