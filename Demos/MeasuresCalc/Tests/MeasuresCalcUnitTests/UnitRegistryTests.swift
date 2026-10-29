// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures
import Testing

@testable import MeasuresCalc

@Suite("UnitRegistry Tests")
internal struct UnitRegistryTests {
    internal init() {}

    @Test("Registered units are valid")
    internal func registeredUnitsAreValid() throws {
        let calculator: Calculator = .init()
        let definitions: Array<UnitToken> = UnitRegistry.definitions
        let grouped: Dictionary<String, Array<UnitToken>> = Dictionary(grouping: definitions) { $0.unit.symbol }
        #expect(definitions.count == 829)
        #expect(calculator.supportedUnits.count == grouped.count)

        for definition in definitions {
            let unit: ComposedUnit = definition.unit
            #expect(unit.symbol.isEmpty == false)
            try Measure<ComposedUnit>.validateUnit(unit)
        }
    }
}
