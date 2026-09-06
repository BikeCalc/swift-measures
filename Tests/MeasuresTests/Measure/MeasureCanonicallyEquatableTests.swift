// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Measure CanonicallyEquatable Tests")
internal struct MeasureCanonicallyEquatableTests {
    private typealias TemperatureMeasure = Measure<ThermodynamicTemperature>

    @Test(
        "Canonical equality succeeds",
        arguments: [
            (Measure<Length>(1, .meter), Measure<Length>(1, .meter), true),
            (Measure<Length>(1, .meter), Measure<Length>(100, .centimeter), true),
            (Measure<Length>(100, .centimeter), Measure<Length>(1, .meter), true),
            (Measure<Length>(1, .foot), Measure<Length>(12, .inch), true),
            (Measure<Length>(-1, .meter), Measure<Length>(-100, .centimeter), true),
            (Measure<Length>(0, .meter), Measure<Length>(0, .foot), true),
            (Measure<Length>(1, .meter), Measure<Length>(99, .centimeter), false),
            (Measure<Length>(1, .foot), Measure<Length>(13, .inch), false),
            (Measure<Length>(-1, .meter), Measure<Length>(100, .centimeter), false)
        ]
    )
    internal func canonicalEqualitySucceeds(
        lhs: Measure<Length>,
        rhs: Measure<Length>,
        result: Bool
    ) {
        #expect(lhs.isCanonicallyEquatable(to: rhs) == result)
    }
}
