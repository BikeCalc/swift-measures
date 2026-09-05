// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import SwiftSyntax

extension DeclGroupSyntax {
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

    internal func unitMacroOwner(named name: String) -> String? {
        for element in self.attributes {
            guard case let .attribute(attribute) = element,
                  ["BinaryUnits", "MetricUnits"].contains(attribute.attributeName.trimmedDescription) else {
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
