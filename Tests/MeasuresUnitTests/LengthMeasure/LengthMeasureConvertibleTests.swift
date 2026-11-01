// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length Measure Convertible Tests")
internal struct LengthMeasureConvertibleTests {
    internal init() {}

    private let absoluteTolerance: Double = 1e-10

    @Test("Identical conversions preserve the value and use the destination unit")
    internal func identicalConversionsPreserveValue() {
        let sourceUnit: Length = .init(
            coefficient: 0.01,
            constant: 1e20,
            symbol: "source"
        )
        let destinationUnit: Length = .init(
            coefficient: 0.01,
            constant: 1e20,
            symbol: "destination"
        )
        let source: Measure<Length> = .init(1, sourceUnit)
        let result: Measure<Length> = source.converted(to: destinationUnit)
        var mutatingResult: Measure<Length> = source
        mutatingResult.convert(to: destinationUnit)
        #expect(result.value == 1)
        #expect(result.unit == destinationUnit)
        #expect(mutatingResult == result)
        let additionResult: Measure<Length> = source + result
        #expect(additionResult.value == 2)
        let subtractionResult: Measure<Length> = source - result
        #expect(subtractionResult.value == 0)
    }

    @Test(
        "Conversion succeeds",
        arguments: [
            (Measure<Length>(1, .meter), .centimeter, Measure<Length>(100, .centimeter)),
            (Measure<Length>(100, .centimeter), .meter, Measure<Length>(1, .meter)),
            (Measure<Length>(1, .foot), .inch, Measure<Length>(12, .inch)),
            (Measure<Length>(1, .yard), .foot, Measure<Length>(3, .foot)),
            (Measure<Length>(1, .kilometer), .meter, Measure<Length>(1_000, .meter))
        ] as Array<(Measure<Length>, Length, Measure<Length>)>
    )
    internal func conversionSucceeds(
        source: Measure<Length>,
        unit: Length,
        expected: Measure<Length>
    ) {
        let result: Measure<Length> = source.converted(to: unit)
        var mutatingResult: Measure<Length> = source
        mutatingResult.convert(to: unit)
        #expect(abs(result.value - expected.value) < self.absoluteTolerance)
        #expect(result.unit == expected.unit)
        #expect(abs(mutatingResult.value - expected.value) < self.absoluteTolerance)
        #expect(mutatingResult.unit == expected.unit)
    }
}

// MARK: - NaT

extension LengthMeasureConvertibleTests {
    // TODO: Implement NaT tests for this suite.
}
