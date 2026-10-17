// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// A member macro that generates prefixed units from a unit-prefix type.
internal protocol UnitMacro {
    /// The prefixes used to generate the units.
    associatedtype Prefix: UnitPrefix

    /// The name of the concrete macro declaration.
    static var macroName: String { get }
}

extension UnitMacro {
    /// Returns the property name for a prefixed unit.
    ///
    /// - Parameters:
    ///   - prefix: The unit prefix.
    ///   - name: The unprefixed unit name.
    /// - Returns: The name shared by unit generation and enumeration.
    internal static func propertyName(
        for prefix: Prefix,
        named name: String
    ) -> String {
        return prefix.rawValue + name
    }

    /// Returns every prefixed property name in prefix order, including the unprefixed unit.
    ///
    /// - Parameter name: The unprefixed unit name.
    /// - Returns: The property names for the prefix family.
    internal static func propertyNames(named name: String) -> Array<String> {
        return Prefix.allCases.map { prefix in
            return Self.propertyName(
                for: prefix,
                named: name
            )
        }
    }

    /// Generates the prefixed unit members for a structure.
    ///
    /// - Parameters:
    ///   - node: The attribute that initiated the expansion.
    ///   - declaration: The declaration to which the macro is attached.
    ///   - context: The context in which the macro is expanded.
    /// - Returns: The generated unit factory and static unit properties.
    /// - Throws: An error if the generated declarations cannot be constructed.
    internal static func unitExpansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> Array<DeclSyntax> {
        // Prefixed units can only be generated for structures.
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
        guard case .argumentList(let arguments) = node.arguments else {
            return []
        }

        // A literal name is required because it becomes part of every generated Swift identifier.
        guard let nameArgument: LabeledExprSyntax = arguments.first,
            let name: String = nameArgument.expression.stringLiteralValue
        else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: UnitMacroDiagnostic.literalRequired("unit name")
                )
            )

            return []
        }

        // An empty name cannot form a valid factory method or static property name.
        guard name.isEmpty == false else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(nameArgument.expression),
                    message: UnitMacroDiagnostic.emptyName
                )
            )

            return []
        }

        // A literal symbol is required because the generated factory combines it with each prefix symbol.
        guard let symbolArgument: LabeledExprSyntax = arguments.first(where: { $0.label?.text == "symbol" }),
            let symbol: String = symbolArgument.expression.stringLiteralValue
        else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: UnitMacroDiagnostic.literalRequired("unit symbol")
                )
            )

            return []
        }

        // Every generated unit must retain a visible symbol after its prefix is applied.
        guard symbol.isEmpty == false else {
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
        let prefixTypeName: String = .init(describing: Prefix.self)

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
        for prefix in Prefix.allCases {
            let propertyName: String = Self.propertyName(
                for: prefix,
                named: name
            )

            guard declaredProperties.contains(propertyName) == false,
                prefix != .none || generatesUnprefixedUnit
            else {
                continue
            }

            let prefixExpression: String = prefix == .none ? "\(prefixTypeName).none" : ".\(prefix.name)"

            members.append(
                """
                /// The \(raw: propertyName) unit of \(raw: dimension).
                public static let \(raw: propertyName): Self = .\(raw: name)(\(raw: prefixExpression))
                """
            )
        }

        return members
    }
}
