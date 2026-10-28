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

@Suite("Measure Formattable Tests")
internal struct MeasureFormattableTests {
    internal init() {}

    @Test("Default formatting follows the current numeric locale")
    internal func defaultFormattingFollowsCurrentLocale() {
        let measure: Measure<Length> = .init(1_234.5, .meter)
        let formatted: String = measure.formatted()
        let expected: String = "\(measure.value.formatted(.number))\u{00A0}m"
        #expect(formatted == expected)
        #expect(measure.description == "1234.5 m")
    }

    @Test("Formatting uses a specific locale")
    internal func formattingUsesSpecificLocale() {
        let locale: Locale = .init(identifier: "fr_FR")
        let formatter: Measure<Length>.FormatStyle = .measure().locale(locale)
        let measure: Measure<Length> = .init(1_234.5, .meter)
        let formatted: String = measure.formatted(formatter)
        #expect(formatted == "1\u{202F}234,5\u{00A0}m")
    }

    @Test("Formatting uses a custom number format style")
    internal func formattingUsesCustomNumberFormatStyle() {
        let locale: Locale = .init(identifier: "fr_FR")
        let numberFormatter: FloatingPointFormatStyle<Double> = .number
            .precision(.fractionLength(2))
            .locale(locale)
        let formatter: Measure<Length>.FormatStyle = .measure(numberFormatStyle: numberFormatter)
        let measure: Measure<Length> = .init(1_234.5, .meter)
        let formatted: String = measure.formatted(formatter)
        #expect(formatted == "1\u{202F}234,50\u{00A0}m")
        #expect(measure.description == "1234.5 m")
    }
}
#endif
