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

@Suite("Measure Format Style Encodable Tests")
internal struct MeasureFormatStyleEncodableTests {
    internal init() {}

    @Test("Encoding preserves configuration")
    internal func encodingPreservesConfiguration() throws {
        let locale: Locale = .init(identifier: "fr_FR")
        let numberStyle: FloatingPointFormatStyle<Double> = .number
            .precision(.significantDigits(5))
            .grouping(.never)
            .locale(locale)
        let style: MeasureFormatStyle<Length> = .init(numberFormatStyle: numberStyle)
        let encoder: JSONEncoder = .init()
        encoder.outputFormatting = .sortedKeys
        let data: Data = try encoder.encode(style)
        let dict: Dictionary<String, FloatingPointFormatStyle<Double>> = [
            "numberFormatStyle": style.numberFormatStyle
        ]
        let expected: Data = try encoder.encode(dict)
        #expect(data == expected)
    }
}
#endif
