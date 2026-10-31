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
        let converted: Measure<ComposedUnit> = source.converted(to: destinationUnit)
        var mutated: Measure<ComposedUnit> = source
        mutated.convert(to: destinationUnit)
        #expect(converted.value == 1)
        #expect(converted.unit == destinationUnit)
        #expect(mutated == converted)
        #expect((source + converted).value == 2)
        #expect((source - converted).value == 0)
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
        let converted: Measure<ComposedUnit> = source.converted(to: unit)
        var mutated: Measure<ComposedUnit> = source
        mutated.convert(to: unit)
        #expect(abs(converted.value - expected.value) < self.absoluteTolerance)
        #expect(converted.unit == expected.unit)
        #expect(abs(mutated.value - expected.value) < self.absoluteTolerance)
        #expect(mutated.unit == expected.unit)
    }
}

// MARK: - NaT

extension ComposedUnitMeasureConvertibleTests {}
