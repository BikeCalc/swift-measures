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

@Suite("ComposedUnit Measure Tests")
internal struct ComposedUnitMeasureTests {
    internal init() {}

    private static let multiplicationArguments: [(Measure<ComposedUnit>, Measure<Length>, Measure<ComposedUnit>)] = [
        (
            .init(200, .centimeter),
            .init(3, .meter),
            .init(6, .init(dimension: .init(length: 2)))
        ),
        (
            .init(2, .init(Area.squareMeter)),
            .init(300, .centimeter),
            .init(6, .init(dimension: .init(length: 3)))
        ),
        (
            .init(0, .init(ThermodynamicTemperature.celsius)),
            .init(2, .meter),
            .init(546.3, .init(dimension: .init(length: 1, thermodynamicTemperature: 1)))
        )
    ]

    private static let divisionArguments: [(Measure<ComposedUnit>, Measure<Length>, Measure<ComposedUnit>)] = [
        (
            .init(6, .meter),
            .init(200, .centimeter),
            .init(3, .dimensionless)
        ),
        (
            .init(6, .init(Area.squareMeter)),
            .init(200, .centimeter),
            .init(3, .meter)
        ),
        (
            .init(0, .init(ThermodynamicTemperature.celsius)),
            .init(2, .meter),
            .init(136.575, .init(dimension: .init(length: -1, thermodynamicTemperature: 1)))
        )
    ]

    @Test(
        "Binary integer initialization succeeds",
        arguments: [
            (-2, -2.0),
            (0, 0.0),
            (2, 2.0)
        ] as Array<(Int, Double)>
    )
    internal func binaryIntegerInitializationSucceeds(
        value: Int,
        expected: Double
    ) {
        let measure: Measure<ComposedUnit> = .init(value, .meter)
        #expect(measure.value == expected)
        #expect(measure.unit == .meter)
    }

    @Test(
        "Binary floating-point initialization succeeds",
        arguments: [
            (.init(-1.5), -1.5),
            (.init(0), 0.0),
            (.init(1.5), 1.5)
        ] as Array<(Float, Double)>
    )
    internal func binaryFloatingPointInitializationSucceeds(
        value: Float,
        expected: Double
    ) {
        let measure: Measure<ComposedUnit> = .init(value, .centimeter)
        #expect(measure.value == expected)
        #expect(measure.unit == .centimeter)
    }

    @Test(
        "Multiplication operator composes coherent measures",
        arguments: Self.multiplicationArguments
    )
    internal func multiplicationOperatorComposesCoherentMeasures(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Measure<Length>,
        expected: Measure<ComposedUnit>
    ) {
        let result: Measure<ComposedUnit> = multiplicand * multiplier
        #expect(result.isCanonicallyEqual(to: expected) == true)
        #expect(result.unit.coefficient == 1)
        #expect(result.unit.constant == 0)
    }

    @Test(
        "Multiplication method composes coherent measures",
        arguments: Self.multiplicationArguments
    )
    internal func multiplicationMethodComposesCoherentMeasures(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Measure<Length>,
        expected: Measure<ComposedUnit>
    ) throws {
        let result: Measure<ComposedUnit> = try multiplicand.multiplying(by: multiplier)
        #expect(result.isCanonicallyEqual(to: expected) == true)
        #expect(result.unit.coefficient == 1)
        #expect(result.unit.constant == 0)
    }

    @Test(
        "Multiplication assignment composes coherent measures",
        arguments: Self.multiplicationArguments
    )
    internal func multiplicationAssignmentComposesCoherentMeasures(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Measure<Length>,
        expected: Measure<ComposedUnit>
    ) {
        var result: Measure<ComposedUnit> = multiplicand
        result *= multiplier
        #expect(result.isCanonicallyEqual(to: expected) == true)
        #expect(result.unit.coefficient == 1)
        #expect(result.unit.constant == 0)
    }

    @Test(
        "Multiplication mutating composes coherent measures",
        arguments: Self.multiplicationArguments
    )
    internal func multiplicationMutatingComposesCoherentMeasures(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Measure<Length>,
        expected: Measure<ComposedUnit>
    ) throws {
        var result: Measure<ComposedUnit> = multiplicand
        try result.multiply(by: multiplier)
        #expect(result.isCanonicallyEqual(to: expected) == true)
        #expect(result.unit.coefficient == 1)
        #expect(result.unit.constant == 0)
    }

    @Test(
        "Division operator composes coherent measures",
        arguments: Self.divisionArguments
    )
    internal func divisionOperatorComposesCoherentMeasures(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<Length>,
        expected: Measure<ComposedUnit>
    ) {
        let result: Measure<ComposedUnit> = dividend / divisor
        #expect(result.isCanonicallyEqual(to: expected) == true)
        #expect(result.unit.coefficient == 1)
        #expect(result.unit.constant == 0)
    }

    @Test(
        "Division method composes coherent measures",
        arguments: Self.divisionArguments
    )
    internal func divisionMethodComposesCoherentMeasures(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<Length>,
        expected: Measure<ComposedUnit>
    ) throws {
        let result: Measure<ComposedUnit> = try dividend.dividing(by: divisor)
        #expect(result.isCanonicallyEqual(to: expected) == true)
        #expect(result.unit.coefficient == 1)
        #expect(result.unit.constant == 0)
    }

    @Test(
        "Division assignment composes coherent measures",
        arguments: Self.divisionArguments
    )
    internal func divisionAssignmentComposesCoherentMeasures(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<Length>,
        expected: Measure<ComposedUnit>
    ) {
        var result: Measure<ComposedUnit> = dividend
        result /= divisor
        #expect(result.isCanonicallyEqual(to: expected) == true)
        #expect(result.unit.coefficient == 1)
        #expect(result.unit.constant == 0)
    }

    @Test(
        "Division mutating composes coherent measures",
        arguments: Self.divisionArguments
    )
    internal func divisionMutatingComposesCoherentMeasures(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<Length>,
        expected: Measure<ComposedUnit>
    ) throws {
        var result: Measure<ComposedUnit> = dividend
        try result.divide(by: divisor)
        #expect(result.isCanonicallyEqual(to: expected) == true)
        #expect(result.unit.coefficient == 1)
        #expect(result.unit.constant == 0)
    }
}

// MARK: - Composition - NaT

extension ComposedUnitMeasureTests {
    @Test(
        "Multiplying a NaT measure returns NaT",
        arguments: [
            (.nat, .init(1, .meter)),
            (.nat, .nat),
            (.invalid, .init(1, .meter))
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>)>
    )
    internal func multiplyingNaTMeasureReturnsNaT(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Measure<ComposedUnit>
    ) {
        let result: Measure<ComposedUnit> = multiplicand * multiplier
        #expect(result.isNaT == true)
    }

    @Test(
        "Multiplying by a NaT measure returns NaT",
        arguments: [
            (.init(1, .meter), .nat),
            (.init(1, .meter), .invalid)
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>)>
    )
    internal func multiplyingByNaTMeasureReturnsNaT(
        multiplicand: Measure<ComposedUnit>,
        multiplier: Measure<ComposedUnit>
    ) {
        let result: Measure<ComposedUnit> = multiplicand * multiplier
        #expect(result.isNaT == true)
    }

    @Test(
        "Dividing a NaT measure returns NaT",
        arguments: [
            (.nat, .init(1, .meter)),
            (.nat, .nat),
            (.invalid, .init(1, .meter))
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>)>
    )
    internal func dividingNaTMeasureReturnsNaT(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<ComposedUnit>
    ) {
        let result: Measure<ComposedUnit> = dividend / divisor
        #expect(result.isNaT == true)
    }

    @Test(
        "Dividing by a NaT measure returns NaT",
        arguments: [
            (.init(1, .meter), .nat),
            (.init(1, .meter), .invalid)
        ] as Array<(Measure<ComposedUnit>, Measure<ComposedUnit>)>
    )
    internal func dividingByNaTMeasureReturnsNaT(
        dividend: Measure<ComposedUnit>,
        divisor: Measure<ComposedUnit>
    ) {
        let result: Measure<ComposedUnit> = dividend / divisor
        #expect(result.isNaT == true)
    }
}
