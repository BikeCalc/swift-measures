// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Validatable Tests")
internal struct LengthMeasureValidatableTests {
    internal init() {}

    @Test(
        "Unbounded valid range succeeds",
        arguments: [
            -1,
             0,
             1
        ]
    )
    internal func unboundedValidRangeSucceeds(value: Int) {
        let measure: Measure<Length> = .init(value, .meter)
        #expect(measure.isValid == true)
    }

    @Test(
        "Unit conversion parameters determine validity",
        arguments: [
            (Measure<Length>(1, .meter), true),
            (Measure<Length>(1, Length(coefficient: -1, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: 1, constant: -1, symbol: "u")), true),
            (Measure<Length>(1, Length(coefficient: 0, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: -0.0, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: .infinity, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: .negativeInfinity, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: .nan, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: 1, constant: .infinity, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: 1, constant: .negativeInfinity, symbol: "u")), false),
            (Measure<Length>(1, Length(coefficient: 1, constant: .nan, symbol: "u")), false)
        ]
    )
    internal func unitConversionParametersDetermineValidity(
        measure: Measure<Length>,
        result: Bool
    ) {
        let validatable: any Validatable = measure
        #expect(validatable.isValid == result)
    }
}

// MARK: - NaT

extension LengthMeasureValidatableTests {
    @Test(
        "Nonfinite values make measures invalid",
        arguments: [
            Double.infinity,
            Double.negativeInfinity,
            Double.nan
        ]
    )
    internal func nonfiniteValuesMakeMeasuresInvalid(value: Double) {
        let measure: Measure<Length> = .init(value, .meter)
        #expect(measure.isValid == false)
    }
}
