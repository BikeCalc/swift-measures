// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import MeasuresMacroSupport
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

internal protocol UnitMacro {
    associatedtype Prefix: UnitPrefix

    static var macroName: String { get }
}

extension UnitMacro {
    internal static func unitExpansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> Array<DeclSyntax> {
        guard declaration.is(StructDeclSyntax.self) else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(declaration),
                    message: UnitMacroDiagnostic.structOnly(macroName)
                )
            )

            return []
        }

        guard case let .argumentList(arguments) = node.arguments else {
            return []
        }

        guard let nameArgument = arguments.first,
              let name = nameArgument.expression.stringLiteralValue else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: UnitMacroDiagnostic.literalRequired("unit name")
                )
            )

            return []
        }

        guard !name.isEmpty else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(nameArgument.expression),
                    message: UnitMacroDiagnostic.emptyName
                )
            )

            return []
        }

        guard let symbolArgument = arguments.first(where: { $0.label?.text == "symbol" }),
              let symbol = symbolArgument.expression.stringLiteralValue else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: UnitMacroDiagnostic.literalRequired("unit symbol")
                )
            )

            return []
        }

        let coefficient: ExprSyntax = arguments.first(where: { $0.label?.text == "coefficient" })?.expression ?? "1"
        let typeName: String = declaration.cast(StructDeclSyntax.self).name.text
        let dimension: String = typeName.splitBeforeUppercase().lowercased()
        let declaredProperties: Set<String> = declaration.staticPropertyNames
        let generatesUnprefixedUnit: Bool = declaration.unitMacroOwner(named: name) == macroName
        let prefixTypeName: String = String(describing: Prefix.self)

        var members: Array<DeclSyntax> = [
            """
            /// Creates a unit by applying a prefix to the unprefixed unit.
            ///
            /// - Parameter prefix: The prefix to apply.
            /// - Returns: The prefixed unit.
            private static func \(raw: name)(_ prefix: \(raw: prefixTypeName)) -> Self {
                return self.init(
                    coefficient: prefix.coefficient * \(coefficient),
                    symbol: prefix.symbol + \(literal: symbol)
                )
            }
            """
        ]

        members.append(contentsOf: Prefix.allCases.compactMap { prefix in
            let propertyName: String = prefix.rawValue + name

            guard !declaredProperties.contains(propertyName),
                  prefix != .none || generatesUnprefixedUnit else {
                return nil
            }

            let prefixExpression: String = prefix == .none ? "\(prefixTypeName).none" : ".\(prefix.name)"

            return """
            /// The \(raw: propertyName) unit of \(raw: dimension).
            public static let \(raw: propertyName): Self = .\(raw: name)(\(raw: prefixExpression))
            """
        })

        return members
    }
}
