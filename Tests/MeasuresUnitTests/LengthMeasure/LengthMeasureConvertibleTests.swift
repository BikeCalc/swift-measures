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
        let converted: Measure<Length> = source.converted(to: unit)
        var mutated: Measure<Length> = source
        mutated.convert(to: unit)

        #expect(abs(converted.value - expected.value) < 1e-10)
        #expect(converted.unit == expected.unit)
        #expect(abs(mutated.value - expected.value) < 1e-10)
        #expect(mutated.unit == expected.unit)
    }
}
