// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Length CaseIterable Tests")
internal struct LengthCaseIterableTests {
    internal init() {}

    @Test("All cases contain the predefined units and base unit without duplicates")
    internal func allCases() {
        let units: Array<Length> = Length.allCases
        #expect(units.count == 44)
        #expect(Set(units).count == 44)
        #expect(units.contains(.base) == true)
    }
}
