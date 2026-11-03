// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("ComposedUnit Measure Convertible Tests")
internal struct ComposedUnitMeasureConvertibleTests {
    internal init() {}

    private let absoluteTolerance: Double = 1e-10

    @Test("Identical conversions preserve the value and use the destination unit")
    internal func identicalConversionsPreserveValue() {
        let sourceUnit: ComposedUnit = .init(
            Length(
                coefficient: 0.01,
                constant: 1e20,
                symbol: "source"
            )
        )
        let destinationUnit: ComposedUnit = .init(
            Length(
                coefficient: 0.01,
                constant: 1e20,
                symbol: "destination"
            )
        )
        let source: Measure<ComposedUnit> = .init(1, sourceUnit)
        let result: Measure<ComposedUnit> = source.converted(to: destinationUnit)
        var mutatingResult: Measure<ComposedUnit> = source
        mutatingResult.convert(to: destinationUnit)
        #expect(result.value == 1)
        #expect(result.unit == destinationUnit)
        #expect(mutatingResult == result)
        let additionResult: Measure<ComposedUnit> = source + result
        #expect(additionResult.value == 2)
        let subtractionResult: Measure<ComposedUnit> = source - result
        #expect(subtractionResult.value == 0)
    }

    @Test(
        "Conversion succeeds",
        arguments: [
            (.init(1, .meter), .centimeter, .init(100, .centimeter)),
            (.init(100, .centimeter), .meter, .init(1, .meter)),
            (.init(1, .foot), .inch, .init(12, .inch)),
            (.init(1, .yard), .foot, .init(3, .foot)),
            (.init(1, .kilometer), .meter, .init(1_000, .meter)),
            (.init(1, .dimensionless), .dimensionless, .init(1, .dimensionless)),
            (.init(1, .dimensionless), .cancelledMeters, .init(1, .cancelledMeters)),
            (.init(1, .cancelledMeters), .dimensionless, .init(1, .dimensionless)),
            (.init(1, .cancelledMeters), .cancelledMeters, .init(1, .cancelledMeters))
        ] as Array<(Measure<ComposedUnit>, ComposedUnit, Measure<ComposedUnit>)>
    )
    internal func conversionSucceeds(
        source: Measure<ComposedUnit>,
        unit: ComposedUnit,
        expected: Measure<ComposedUnit>
    ) {
        let result: Measure<ComposedUnit> = source.converted(to: unit)
        var mutatingResult: Measure<ComposedUnit> = source
        mutatingResult.convert(to: unit)
        #expect(abs(result.value - expected.value) < self.absoluteTolerance)
        #expect(result.unit == expected.unit)
        #expect(abs(mutatingResult.value - expected.value) < self.absoluteTolerance)
        #expect(mutatingResult.unit == expected.unit)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureConvertibleTests {
    @Test(
        "Converting NaT produces NaT",
        arguments: [
            .nat,
            .init(Double.nan, .meter),
            .init(Double.infinity, .meter),
            .init(Double.negativeInfinity, .meter),
            .invalid
        ] as Array<Measure<ComposedUnit>>
    )
    internal func convertingNaTProducesNaT(value: Measure<ComposedUnit>) {
        let result: Measure<ComposedUnit> = value.converted(to: .centimeter)
        #expect(result.isNaT == true)
    }

    @Test("Invalid destination produces NaT")
    internal func invalidDestinationProducesNaT() {
        let value: Measure<ComposedUnit> = .init(1, .meter)
        let destination: ComposedUnit = .init(
            coefficient: 0,
            constant: 0,
            symbol: "invalid"
        )
        let result: Measure<ComposedUnit> = value.converted(to: destination)
        #expect(result.isNaT == true)
    }
}
