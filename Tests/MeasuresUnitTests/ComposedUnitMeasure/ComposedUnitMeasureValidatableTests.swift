// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure Validatable Tests")
internal struct ComposedUnitMeasureValidatableTests {
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
        let measure: Measure<ComposedUnit> = .init(value, .meter)
        #expect(measure.isValid == true)
    }

    @Test(
        "Unit conversion parameters determine validity",
        arguments: [
            (Measure<ComposedUnit>(1, .meter), true),
            (Measure<ComposedUnit>(1, ComposedUnit(coefficient: -1, symbol: "u")), false),
            (Measure<ComposedUnit>(1, ComposedUnit(coefficient: 1, constant: -1, symbol: "u")), true),
            (Measure<ComposedUnit>(1, ComposedUnit(coefficient: 0, symbol: "u")), false),
            (Measure<ComposedUnit>(1, ComposedUnit(coefficient: -0.0, symbol: "u")), false),
            (Measure<ComposedUnit>(1, ComposedUnit(coefficient: .infinity, symbol: "u")), false),
            (Measure<ComposedUnit>(1, ComposedUnit(coefficient: .negativeInfinity, symbol: "u")), false),
            (Measure<ComposedUnit>(1, ComposedUnit(coefficient: .nan, symbol: "u")), false),
            (Measure<ComposedUnit>(1, ComposedUnit(coefficient: 1, constant: .infinity, symbol: "u")), false),
            (Measure<ComposedUnit>(1, ComposedUnit(coefficient: 1, constant: .negativeInfinity, symbol: "u")), false),
            (Measure<ComposedUnit>(1, ComposedUnit(coefficient: 1, constant: .nan, symbol: "u")), false)
        ]
    )
    internal func unitConversionParametersDetermineValidity(
        measure: Measure<ComposedUnit>,
        result: Bool
    ) {
        let validatable: any Validatable = measure
        #expect(validatable.isValid == result)
    }

    @Test(
        "Captured unit conversion parameters determine validity",
        arguments: [
            (1.0, 0.0, true),
            (0.01, -1.0, true),
            (-1.0, 0.0, false),
            (0.0, 0.0, false),
            (-0.0, 0.0, false),
            (Double.infinity, 0.0, false),
            (Double.negativeInfinity, 0.0, false),
            (Double.nan, 0.0, false),
            (1.0, Double.infinity, false),
            (1.0, Double.negativeInfinity, false),
            (1.0, Double.nan, false)
        ]
    )
    internal func capturedUnitConversionParametersDetermineValidity(
        coefficient: Double,
        constant: Double,
        result: Bool
    ) {
        let namedUnit: Length = .init(
            coefficient: coefficient,
            constant: constant,
            symbol: "u"
        )
        let capturedUnit: ComposedUnit = .init(namedUnit)
        let measure: Measure<ComposedUnit> = .init(1, capturedUnit)
        #expect(measure.isValid == result)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureValidatableTests {
    @Test(
        "Nonfinite values make measures invalid",
        arguments: [
            Double.infinity,
            Double.negativeInfinity,
            Double.nan
        ]
    )
    internal func nonfiniteValuesMakeMeasuresInvalid(value: Double) {
        let measure: Measure<ComposedUnit> = .init(value, .meter)
        #expect(measure.isValid == false)
    }
}
