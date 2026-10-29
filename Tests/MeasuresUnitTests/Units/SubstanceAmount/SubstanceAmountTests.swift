// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("SubstanceAmount Tests")
internal struct SubstanceAmountTests {
    internal init() {}

    private let accuracy: Double = 1e-12

    @Test(
        "Dividing by Time returns CatalyticActivity",
        arguments: [
            (.millimole, .kilosecond, .init(coefficient: 1e-6, symbol: "mmol/ks")),
            (.mole, .second, .init(coefficient: 1, symbol: "mol/s")),
            (.kilomole, .millisecond, .init(coefficient: 1e+6, symbol: "kmol/ms"))
        ] as Array<(SubstanceAmount, Time, CatalyticActivity)>
    )
    internal func dividingByTimeReturnsCatalyticActivity(
        lhs: SubstanceAmount,
        rhs: Time,
        expected: CatalyticActivity
    ) {
        let result: CatalyticActivity = lhs / rhs
        #expect(abs(result.coefficient - expected.coefficient) <= abs(expected.coefficient) * self.accuracy)
        #expect(result.constant == expected.constant)
        #expect(result.symbol == expected.symbol)
    }
}
