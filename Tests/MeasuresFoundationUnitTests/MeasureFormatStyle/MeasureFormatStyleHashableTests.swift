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

@Suite("Measure Format Style Hashable Tests")
internal struct MeasureFormatStyleHashableTests {
    internal init() {}

    @Test("A set keeps distinct formatter configurations")
    internal func setKeepsDistinctConfigurations() {
        let original: MeasureFormatStyle<Length> = .init(
            numberFormatStyle: .number.locale(Locale(identifier: "en_US"))
        )
        let equivalent: MeasureFormatStyle<Length> = .init(
            numberFormatStyle: .number.locale(Locale(identifier: "en_US"))
        )
        let localized: MeasureFormatStyle<Length> = original.locale(Locale(identifier: "fr_FR"))
        let modified: MeasureFormatStyle<Length> = .init(
            numberFormatStyle: original.numberFormatStyle.precision(.fractionLength(2))
        )
        let styles: Set<MeasureFormatStyle<Length>> = [original, equivalent, localized, modified]
        #expect(styles.count == 3)
        #expect(original == equivalent)
        #expect(original != localized)
        #expect(original != modified)
    }
}
#endif
