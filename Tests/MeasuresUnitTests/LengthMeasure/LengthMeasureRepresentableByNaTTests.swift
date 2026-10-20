// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure RepresentableByNaT Tests")
internal struct LengthMeasureRepresentableByNaTTests {
    internal init() {}

    private func makeNaT<Value>() -> Value
    where Value: RepresentableByNaT {
        return .nat
    }
}

// MARK: - Finite Values

extension LengthMeasureRepresentableByNaTTests {
    @Test(
        "Finite values with valid conversion parameters are not NaT",
        arguments: [-1.0, -0.0, 0.0, 1.0],
        [
            (1.0, 0.0),
            (2.0, -1.0),
            (0.5, 1.0)
        ]
    )
    internal func finiteValuesAreNotNaT(
        value: Double,
        conversion: (Double, Double)
    ) {
        let unit: Length = .init(
            coefficient: conversion.0,
            constant: conversion.1,
            symbol: "u"
        )
        let measure: Measure<Length> = .init(value, unit)
        #expect(measure.isNaT == false)
    }
}

// MARK: - NaT

extension LengthMeasureRepresentableByNaTTests {
    @Test("NaT is available through the protocol")
    internal func natIsAvailableThroughProtocol() {
        let measure: Measure<Length> = self.makeNaT()
        #expect(measure.isNaT == true)
        #expect(measure.value.isNaN == true)
        #expect(measure.unit.coefficient.isNaN == true)
        #expect(measure.unit.constant.isNaN == true)
        #expect(measure.unit.symbol == "NaT")
        #expect(measure.unit.dimension == Dimension(length: 1))
    }

    @Test(
        "Nonfinite values are NaT",
        arguments: [
            Double.nan,
            Double.infinity,
            Double.negativeInfinity
        ]
    )
    internal func nonfiniteValuesAreNaT(value: Double) {
        let measure: Measure<Length> = .init(value, .meter)
        #expect(measure.isNaT == true)
    }

    @Test(
        "Invalid conversion parameters are NaT",
        arguments: [
            (Double.nan, 0.0),
            (Double.infinity, 0.0),
            (Double.negativeInfinity, 0.0),
            (0.0, 0.0),
            (-0.0, 0.0),
            (-1.0, 0.0),
            (1.0, Double.nan),
            (1.0, Double.infinity),
            (1.0, Double.negativeInfinity)
        ]
    )
    internal func invalidConversionParametersAreNaT(
        coefficient: Double,
        constant: Double
    ) {
        let unit: Length = .init(
            coefficient: coefficient,
            constant: constant,
            symbol: "u"
        )
        let measure: Measure<Length> = .init(1, unit)
        #expect(measure.isNaT == true)
    }
}
