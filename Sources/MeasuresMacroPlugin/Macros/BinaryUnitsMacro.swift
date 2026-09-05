// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import SwiftSyntax
import SwiftSyntaxMacros

/// The implementation of the `BinaryUnits` macro.
package struct BinaryUnitsMacro {}

// MARK: - UnitMacro

extension BinaryUnitsMacro: UnitMacro {
    internal typealias Prefix = BinaryUnitPrefix

    internal static var macroName: String {
        return "BinaryUnits"
    }
}

// MARK: - MemberMacro

extension BinaryUnitsMacro: MemberMacro {
    package static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: Array<TypeSyntax>,
        in context: some MacroExpansionContext
    ) throws -> Array<DeclSyntax> {
        return try unitExpansion(
            of: node,
            providingMembersOf: declaration,
            in: context
        )
    }
}
