// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

/// Tests enumeration of predefined catalytic activity units.
@Suite("Catalytic Activity CaseIterable Tests")
internal struct CatalyticActivityCaseIterableTests {
    /// Creates the case-iteration test suite.
    internal init() {}

    /// Checks the predefined unit count, uniqueness, and inclusion of the base unit.
    @Test("All cases contain the predefined units and base unit without duplicates")
    internal func allCases() {
        let units: Array<CatalyticActivity> = CatalyticActivity.allCases

        #expect(units.count == 26)
        #expect(Set(units).count == 26)
        #expect(units.contains(.base) == true)
    }
}
