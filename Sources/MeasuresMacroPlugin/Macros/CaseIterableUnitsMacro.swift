// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// The implementation of the `CaseIterableUnits` macro.
package struct CaseIterableUnitsMacro {
    /// Creates the case-iterable units macro.
    package init() {}

    /// Returns the names of predefined units in prefix and source declaration order.
    ///
    /// - Parameter declaration: The annotated structure.
    /// - Returns: Unique property names, excluding the base alias.
    private static func propertyNames(in declaration: StructDeclSyntax) -> Array<String> {
        var names: Array<String> = []

        // Read sibling attributes rather than depending on their expansion order.
        for element in declaration.attributes {
            guard case .attribute(let attribute) = element,
                case .argumentList(let arguments) = attribute.arguments,
                let name: String = arguments.first?.expression.stringLiteralValue
            else {
                continue
            }

            switch attribute.attributeName.trimmedDescription {
            case "MetricUnits":
                names.append(contentsOf: MetricUnitsMacro.propertyNames(named: name))
            case "BinaryUnits":
                names.append(contentsOf: BinaryUnitsMacro.propertyNames(named: name))
            default:
                continue
            }
        }

        names.append(contentsOf: declaration.publicStaticSelfConstantNames)
        var seen: Set<String> = []
        return names.filter { $0 != "base" && seen.insert($0).inserted == true }
    }
}

// MARK: - ExtensionMacro

extension CaseIterableUnitsMacro: ExtensionMacro {
    package static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: Array<TypeSyntax>,
        in context: some MacroExpansionContext
    ) throws -> Array<ExtensionDeclSyntax> {
        guard let structure: StructDeclSyntax = declaration.as(StructDeclSyntax.self) else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(declaration),
                    message: UnitMacroDiagnostic.structOnly("CaseIterableUnits")
                )
            )
            return []
        }

        let names: Array<String> = Self.propertyNames(in: structure)
        let elements: String = names.map { "." + $0 }.joined(separator: ",\n")
        let result: DeclSyntax = """
            extension \(type): CaseIterable {
                public static let allCases: Array<Self> = [
                    \(raw: elements)
                ]
            }
            """
        return [result.cast(ExtensionDeclSyntax.self)]
    }
}
