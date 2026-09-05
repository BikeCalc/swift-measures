// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// Generates the complete family of SI-prefixed units for a measurable dimension.
///
/// - parameter name: The unprefixed unit name.
/// - parameter symbol: The unprefixed unit symbol.
/// - parameter coefficient: The unprefixed unit's coefficient relative to the dimension's base unit.
@attached(member, names: arbitrary)
package macro MetricUnits(
    name: String,
    symbol: String,
    coefficient: Double = 1
) = #externalMacro(
    module: "MeasuresMacroPlugin",
    type: "MetricUnitsMacro"
)
