// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Measure CustomStringConvertible Tests")
internal struct MeasureCustomStringConvertibleTests {
    @Test(
        "Description succeeds",
        arguments: [
            (Measure<Length>(1, .meter), "1.0 m"),
            (Measure<Length>(-1, .meter), "-1.0 m"),
            (Measure<Length>(0, .meter), "0.0 m"),
            (Measure<Length>(100, .centimeter), "100.0 cm"),
            (Measure<Length>(1.5, .foot), "1.5 ft")
        ]
    )
    internal func descriptionSucceeds(
        value: Measure<Length>,
        result: String
    ) {
        #expect(value.description == result)
    }
}
