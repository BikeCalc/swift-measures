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

/// A member macro that generates a family of units from a unit-prefix type.
internal protocol UnitMacro {
    /// The prefixes used to generate the unit family.
    associatedtype Prefix: UnitPrefix

    /// The name of the concrete macro declaration.
    static var macroName: String { get }
}

extension UnitMacro {
    /// Generates the prefixed unit members for a structure.
    ///
    /// - Parameter node: The attribute that initiated the expansion.
    /// - Parameter declaration: The declaration to which the macro is attached.
    /// - Parameter context: The context in which the macro is expanded.
    /// - Returns: The generated unit factory and static unit properties.
    internal static func unitExpansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> Array<DeclSyntax> {
        // Unit families can only be generated for structures.
        guard declaration.is(StructDeclSyntax.self) else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(declaration),
                    message: UnitMacroDiagnostic.structOnly(macroName)
                )
            )

            return []
        }

        // Read the arguments from the attached macro attribute before validating their individual values.
        guard case let .argumentList(arguments) = node.arguments else {
            return []
        }

        // A literal name is required because it becomes part of every generated Swift identifier.
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

        // An empty name cannot form a valid factory method or static property name.
        guard !name.isEmpty else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(nameArgument.expression),
                    message: UnitMacroDiagnostic.emptyName
                )
            )

            return []
        }

        // A literal symbol is required because the generated factory combines it with each prefix symbol.
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

        // Every generated unit must retain a visible symbol after its prefix is applied.
        guard !symbol.isEmpty else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(symbolArgument.expression),
                    message: UnitMacroDiagnostic.emptySymbol
                )
            )

            return []
        }

        // The generated factory requires an initializer with coefficient, constant and symbol parameters.
        guard declaration.hasUnitInitializer else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(declaration),
                    message: UnitMacroDiagnostic.initializerRequired
                )
            )

            return []
        }

        let coefficient: ExprSyntax = arguments.first(where: { $0.label?.text == "coefficient" })?.expression ?? "1"
        let typeName: String = declaration.cast(StructDeclSyntax.self).name.text
        let dimension: String = typeName.splitBeforeUppercase().lowercased()
        let declaredProperties: Set<String> = declaration.staticPropertyNames

        // The first attached unit macro with this name owns the shared unprefixed unit.
        let generatesUnprefixedUnit: Bool = declaration.unitMacroOwner(named: name) == macroName
        let prefixTypeName: String = String(describing: Prefix.self)

        // Generate one factory so every static property applies its prefix consistently.
        var members: Array<DeclSyntax> = [
            """
            /// Creates a unit by applying a prefix to the unprefixed unit.
            ///
            /// - Parameter prefix: The prefix to apply.
            /// - Returns: The prefixed unit.
            private static func \(raw: name)(_ prefix: \(raw: prefixTypeName)) -> Self {
                return self.init(
                    coefficient: prefix.coefficient * \(coefficient),
                    constant: 0,
                    symbol: prefix.symbol + \(literal: symbol)
                )
            }
            """
        ]

        // Generate each missing prefixed property while respecting declared units.
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
