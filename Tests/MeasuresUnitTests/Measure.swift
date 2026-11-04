// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures

extension Measure
where UnitType == Length {
    internal static var invalid: Self {
        let unit: Length = .init(
            coefficient: 0,
            constant: 0,
            symbol: "w"
        )
        return .init(1, unit)
    }
}

extension Measure
where UnitType == ComposedUnit {
    internal static var invalid: Self {
        let unit: Length = .init(
            coefficient: 0,
            constant: 0,
            symbol: "w"
        )
        return .init(1, ComposedUnit(unit))
    }
}
