// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

// swift-format-ignore
/// Generates `CaseIterable` conformance for the predefined units declared by a structure.
///
/// Metric and binary units appear in prefix order, followed by explicitly declared public static constants in source
/// order. Constants must have an explicit `Self` or enclosing-type annotation. The `base` alias is excluded, and each
/// property name appears only once. Units declared in separate extensions are not discovered.
@attached(extension, conformances: CaseIterable, names: named(allCases))
package macro CaseIterableUnits() = #externalMacro(
    module: "MeasuresMacroPlugin",
    type: "CaseIterableUnitsMacro"
)
