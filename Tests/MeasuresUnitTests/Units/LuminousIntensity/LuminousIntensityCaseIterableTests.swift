// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Luminous Intensity CaseIterable Tests")
internal struct LuminousIntensityCaseIterableTests {
    @Test("All cases contain the predefined units and base unit without duplicates")
    internal func allCases() {
        let units: Array<LuminousIntensity> = LuminousIntensity.allCases

        #expect(units.count == 25)
        #expect(Set(units).count == 25)
        #expect(units.contains(.base) == true)
    }
}
