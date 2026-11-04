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
        ] as Array<Int>
    )
    internal func unboundedValidRangeSucceeds(value: Int) {
        let measure: Measure<ComposedUnit> = .init(value, .meter)
        #expect(measure.isValid == true)
    }

    @Test(
        "Unit conversion parameters determine validity",
        arguments: [
            (.init(1, .meter), true),
            (.init(1, ComposedUnit(coefficient: -1, symbol: "w")), false),
            (.init(1, ComposedUnit(coefficient: 1, constant: -1, symbol: "w")), true),
            (.init(1, ComposedUnit(coefficient: 0, symbol: "w")), false),
            (.init(1, ComposedUnit(coefficient: -0.0, symbol: "w")), false),
            (.init(1, ComposedUnit(coefficient: .infinity, symbol: "w")), false),
            (.init(1, ComposedUnit(coefficient: .negativeInfinity, symbol: "w")), false),
            (.init(1, ComposedUnit(coefficient: .nan, symbol: "w")), false),
            (.init(1, ComposedUnit(coefficient: 1, constant: .infinity, symbol: "w")), false),
            (.init(1, ComposedUnit(coefficient: 1, constant: .negativeInfinity, symbol: "w")), false),
            (.init(1, ComposedUnit(coefficient: 1, constant: .nan, symbol: "w")), false)
        ] as Array<(Measure<ComposedUnit>, Bool)>
    )
    internal func unitConversionParametersDetermineValidity(
        measure: Measure<ComposedUnit>,
        expected: Bool
    ) {
        let validatable: any Validatable = measure
        #expect(validatable.isValid == expected)
    }

    @Test(
        "Captured unit conversion parameters determine validity",
        arguments: [
            (1.0, 0.0, true),
            (0.01, -1.0, true),
            (-1.0, 0.0, false),
            (0.0, 0.0, false),
            (-0.0, 0.0, false),
            (.infinity, 0.0, false),
            (.negativeInfinity, 0.0, false),
            (.nan, 0.0, false),
            (1.0, .infinity, false),
            (1.0, .negativeInfinity, false),
            (1.0, .nan, false)
        ] as Array<(Double, Double, Bool)>
    )
    internal func capturedUnitConversionParametersDetermineValidity(
        coefficient: Double,
        constant: Double,
        expected: Bool
    ) {
        let namedUnit: Length = .init(
            coefficient: coefficient,
            constant: constant,
            symbol: "w"
        )
        let capturedUnit: ComposedUnit = .init(namedUnit)
        let measure: Measure<ComposedUnit> = .init(1, capturedUnit)
        #expect(measure.isValid == expected)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureValidatableTests {
    @Test(
        "Nonfinite values make measures invalid",
        arguments: [
            .infinity,
            .negativeInfinity,
            .nan
        ] as Array<Double>
    )
    internal func nonfiniteValuesMakeMeasuresInvalid(value: Double) {
        let measure: Measure<ComposedUnit> = .init(value, .meter)
        #expect(measure.isValid == false)
    }
}
