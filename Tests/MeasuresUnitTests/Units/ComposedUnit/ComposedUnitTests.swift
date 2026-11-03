// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import CoreMeasureUnits
@testable import Measures

@Suite("ComposedUnit Tests")
internal struct ComposedUnitTests {
    internal init() {}

    @Test(
        "Dimension initialization includes only nonzero factors",
        arguments: [
            (.init(), [], [], ""),
            (.init(length: 1), ["m"], [1], "m"),
            (.init(time: -2), ["s"], [-2], "s⁻²"),
            (.init(length: 1, time: -2), ["m", "s"], [1, -2], "m·s⁻²")
        ] as Array<(Dimension, Array<String>, Array<Int>, String)>
    )
    internal func dimensionInitializationIncludesOnlyNonzeroFactors(
        dimension: Dimension,
        symbols: Array<String>,
        exponents: Array<Int>,
        symbol: String
    ) {
        let unit: ComposedUnit = .init(dimension: dimension)
        #expect(unit.factors.map { $0.unit.symbol } == symbols)
        #expect(unit.factors.map { $0.exponent } == exponents)
        #expect(unit.dimension == dimension)
        #expect(unit.coefficient == 1)
        #expect(unit.constant == 0)
        #expect(unit.symbol == symbol)
    }

    @Test(
        "Multiplication retains factors without converting or combining them",
        arguments: [
            (
                .centimeter,
                .meter,
                [.init(Length.centimeter, 1), .init(Length.meter, 1)],
                0.01,
                .init(length: 2),
                "cm·m"
            ),
            (.meter, .meter, [.init(Length.meter, 1), .init(Length.meter, 1)], 1.0, .init(length: 2), "m·m"),
            (
                .meter,
                .init(Time.second),
                [.init(Length.meter, 1), .init(Time.second, 1)],
                1.0,
                .init(length: 1, time: 1),
                "m·s"
            )
        ] as Array<(ComposedUnit, ComposedUnit, Array<ComposedUnit.Factor>, Double, Dimension, String)>
    )
    internal func multiplicationRetainsFactors(
        lhs: ComposedUnit,
        rhs: ComposedUnit,
        factors: Array<ComposedUnit.Factor>,
        coefficient: Double,
        dimension: Dimension,
        symbol: String
    ) {
        let unit: ComposedUnit = lhs * rhs
        #expect(unit.factors == factors)
        #expect(unit.coefficient == coefficient)
        #expect(unit.dimension == dimension)
        #expect(unit.symbol == symbol)
    }

    @Test(
        "Division negates every denominator exponent",
        arguments: [
            (.centimeter, .meter, [.init(Length.centimeter, 1), .init(Length.meter, -1)], 0.01, .init(), "cm·m⁻¹"),
            (
                .meter,
                .init(Time.second),
                [.init(Length.meter, 1), .init(Time.second, -1)],
                1.0,
                .init(length: 1, time: -1),
                "m·s⁻¹"
            ),
            (
                .centimeter,
                .meter / .init(Time.second),
                [.init(Length.centimeter, 1), .init(Length.meter, -1), .init(Time.second, 1)],
                0.01,
                .init(time: 1),
                "cm·m⁻¹·s"
            )
        ] as Array<(ComposedUnit, ComposedUnit, Array<ComposedUnit.Factor>, Double, Dimension, String)>
    )
    internal func divisionNegatesDenominatorExponents(
        lhs: ComposedUnit,
        rhs: ComposedUnit,
        factors: Array<ComposedUnit.Factor>,
        coefficient: Double,
        dimension: Dimension,
        symbol: String
    ) {
        let unit: ComposedUnit = lhs / rhs
        #expect(unit.factors == factors)
        #expect(unit.coefficient == coefficient)
        #expect(unit.dimension == dimension)
        #expect(unit.symbol == symbol)
    }

    @Test(
        "Exponentiation scales factor exponents",
        arguments: [
            (0, [], 1.0, .init(), ""),
            (1, [1, -1], 2.0, .init(length: 1, time: -1), "u·s⁻¹"),
            (2, [2, -2], 4.0, .init(length: 2, time: -2), "u²·s⁻²"),
            (-1, [-1, 1], 0.5, .init(length: -1, time: 1), "u⁻¹·s")
        ] as Array<(Int, Array<Int>, Double, Dimension, String)>
    )
    internal func exponentiationScalesFactorExponents(
        exponent: Int,
        exponents: Array<Int>,
        coefficient: Double,
        dimension: Dimension,
        symbol: String
    ) {
        let length: Length = .init(coefficient: 2, symbol: "u")
        let source: ComposedUnit = .init(length) / .init(Time.second)
        let unit: ComposedUnit = source ** exponent
        #expect(unit.factors.map { $0.exponent } == exponents)
        #expect(unit.coefficient == coefficient)
        #expect(unit.dimension == dimension)
        #expect(unit.symbol == symbol)
    }
}
