// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@Suite("Surface Density CaseIterable Tests")
internal struct SurfaceDensityCaseIterableTests {
    @Test("All cases contain the predefined units and base unit without duplicates")
    internal func allCases() {
        let units: Array<SurfaceDensity> = SurfaceDensity.allCases

        #expect(units.count == 3)
        #expect(Set(units).count == 3)
        #expect(units.contains(.base) == true)
    }
}
