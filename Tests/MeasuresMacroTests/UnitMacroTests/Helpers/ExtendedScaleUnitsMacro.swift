// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import SwiftSyntax
import SwiftSyntaxMacros
@testable import MeasuresMacroPlugin

internal struct ExtendedScaleUnitsMacro {
    internal init() {}
}

// MARK: - UnitMacro

extension ExtendedScaleUnitsMacro: UnitMacro {
    internal typealias Prefix = ExtendedScaleUnitPrefix

    internal static var macroName: String {
        return "ExtendedScaleUnits"
    }
}

// MARK: - MemberMacro

extension ExtendedScaleUnitsMacro: MemberMacro {
    internal static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> Array<DeclSyntax> {
        return try unitExpansion(
            of: node,
            providingMembersOf: declaration,
            in: context
        )
    }
}
