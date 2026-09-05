// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import SwiftSyntax

extension DeclGroupSyntax {
    /// A Boolean value indicating whether this declaration contains the initializer required by a unit macro.
    internal var hasUnitInitializer: Bool {
        return self.memberBlock.members.contains { member in
            guard let initializer = member.decl.as(InitializerDeclSyntax.self) else {
                return false
            }

            let parameters = initializer.signature.parameterClause.parameters
            let labels = parameters.map(\.firstName.text)

            return labels == [
                "coefficient",
                "constant",
                "symbol"
            ]
        }
    }

    /// The names of the static properties declared directly by this declaration.
    internal var staticPropertyNames: Set<String> {
        return self.memberBlock.members.reduce(into: Set<String>()) { result, member in
            guard let variable = member.decl.as(VariableDeclSyntax.self),
                  variable.modifiers.contains(where: { $0.name.text == "static" }) else {
                return
            }

            for binding in variable.bindings {
                guard let identifier = binding.pattern.as(IdentifierPatternSyntax.self) else {
                    continue
                }

                result.insert(identifier.identifier.text)
            }
        }
    }

    /// Returns the first attached macro that declares a unit with the given name.
    ///
    /// When multiple unit macros declare the same unprefixed unit, the first macro owns its generation.
    ///
    /// - Parameter name: The unprefixed unit name.
    /// - Returns: The name of the owning macro, or `nil` when no matching macro is attached.
    internal func unitMacroOwner(named name: String) -> String? {
        for element in self.attributes {
            guard case let .attribute(attribute) = element else {
                continue
            }

            guard case let .argumentList(arguments) = attribute.arguments,
                  arguments.first?.expression.stringLiteralValue == name else {
                continue
            }

            return attribute.attributeName.trimmedDescription
        }

        return nil
    }
}
