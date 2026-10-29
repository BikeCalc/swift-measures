// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

#if canImport(Foundation)
import Foundation
import Measures
import Testing

@Suite("Measure Format Style Decodable Tests")
internal struct MeasureFormatStyleDecodableTests {
    internal init() {}

    @Test("Decoding preserves configuration")
    internal func decodingPreservesConfiguration() throws {
        let locale: Locale = .init(identifier: "fr_FR")
        let numberStyle: FloatingPointFormatStyle<Double> = .number
            .precision(.significantDigits(5))
            .grouping(.never)
            .locale(locale)
        let style: MeasureFormatStyle<Length> = .init(numberFormatStyle: numberStyle)
        let encoder: JSONEncoder = .init()
        let dict: Dictionary<String, FloatingPointFormatStyle<Double>> = [
            "numberFormatStyle": style.numberFormatStyle
        ]
        let data: Data = try encoder.encode(dict)
        let decoder: JSONDecoder = .init()
        let decoded: MeasureFormatStyle<Length> = try decoder.decode(
            MeasureFormatStyle<Length>.self,
            from: data
        )
        let measure: Measure<Length> = .init(1_234.5, .meter)
        #expect(decoded == style)
        #expect(decoded.format(measure) == "1234,5\u{00A0}m")
    }
}
#endif
