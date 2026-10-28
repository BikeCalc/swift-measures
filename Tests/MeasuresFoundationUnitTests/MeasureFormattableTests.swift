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

    @Test(
        "Formatting uses a specific locale",
        arguments: [
            ("en_US", "1,234.5\u{00A0}m"),
            ("de_DE", "1.234,5\u{00A0}m"),
            ("fr_FR", "1\u{202F}234,5\u{00A0}m"),
            ("ar_EG@numbers=arab", "١٬٢٣٤٫٥\u{00A0}m")
        ]
    )
    internal func formattingUsesSpecificLocale(
        identifier: String,
        expected: String
    ) {
        let locale: Locale = .init(identifier: identifier)
        let formatter: Measure<Length>.FormatStyle = .measure().locale(locale)
        let measure: Measure<Length> = .init(1_234.5, .meter)
        let formatted: String = measure.formatted(formatter)
        #expect(formatted == expected)
        #expect(measure.description == "1234.5 m")
    }

    @Test(
        "Formatting uses a custom number format style",
        arguments: [
            (.number.precision(.fractionLength(2)), "1,234.50\u{00A0}m"),
            (.number.grouping(.never), "1234.5\u{00A0}m"),
            (.number.rounded(rule: .down).precision(.fractionLength(0)), "1,234\u{00A0}m"),
            (.number.rounded(rule: .up).precision(.fractionLength(0)), "1,235\u{00A0}m"),
            (.number.sign(strategy: .always()), "+1,234.5\u{00A0}m")
        ] as [(FloatingPointFormatStyle<Double>, String)]
    )
    internal func formattingUsesCustomNumberFormatStyle(
        numberFormatStyle: FloatingPointFormatStyle<Double>,
        expected: String
    ) {
        let locale: Locale = .init(identifier: "en_US")
        let formatter: Measure<Length>.FormatStyle = .measure(numberFormatStyle: numberFormatStyle).locale(locale)
        let measure: Measure<Length> = .init(1_234.5, .meter)
        let formatted: String = measure.formatted(formatter)
        #expect(formatted == expected)
        #expect(measure.description == "1234.5 m")
    }
}

// MARK: - NaT

extension MeasureFormattableTests {
    @Test(
        "Formatting NaT produces only NaT",
        arguments: [
            Measure<Length>.nat,
            Measure<Length>(Double.nan, .meter),
            Measure<Length>(Double.infinity, .meter),
            Measure<Length>(Double.negativeInfinity, .meter)
        ]
    )
    internal func formattingNaT(measure: Measure<Length>) {
        #expect(measure.formatted() == "NaT")
        #expect(measure.description == "NaT")
    }

    @Test(
        "Formatting invalid unit conversion parameters produce only NaT",
        arguments: [
            (Double.nan, 0.0),
            (Double.infinity, 0.0),
            (0.0, 0.0),
            (-1.0, 0.0),
            (1.0, Double.nan),
            (1.0, Double.infinity)
        ]
    )
    internal func formattingInvalidUnit(
        coefficient: Double,
        constant: Double
    ) {
        let unit: Length = .init(
            coefficient: coefficient,
            constant: constant,
            symbol: ""
        )
        let measure: Measure<Length> = .init(12, unit)
        #expect(measure.isNaT == true)
        #expect(measure.formatted() == "NaT")
        #expect(measure.description == "NaT")
    }
}
#endif
