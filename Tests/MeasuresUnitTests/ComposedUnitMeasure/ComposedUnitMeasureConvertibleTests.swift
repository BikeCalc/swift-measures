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
            (Measure<ComposedUnit>(1, .meter), .centimeter, Measure<ComposedUnit>(100, .centimeter)),
            (Measure<ComposedUnit>(100, .centimeter), .meter, Measure<ComposedUnit>(1, .meter)),
            (Measure<ComposedUnit>(1, .foot), .inch, Measure<ComposedUnit>(12, .inch)),
            (Measure<ComposedUnit>(1, .yard), .foot, Measure<ComposedUnit>(3, .foot)),
            (Measure<ComposedUnit>(1, .kilometer), .meter, Measure<ComposedUnit>(1_000, .meter)),
            (Measure<ComposedUnit>(1, .dimensionless), .dimensionless, Measure<ComposedUnit>(1, .dimensionless)),
            (Measure<ComposedUnit>(1, .dimensionless), .cancelledMeters, Measure<ComposedUnit>(1, .cancelledMeters)),
            (Measure<ComposedUnit>(1, .cancelledMeters),  .dimensionless, Measure<ComposedUnit>(1, .dimensionless)),
            (Measure<ComposedUnit>(1, .cancelledMeters), .cancelledMeters, Measure<ComposedUnit>(1, .cancelledMeters))
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
    // TODO: Implement NaT tests for this suite.
}
