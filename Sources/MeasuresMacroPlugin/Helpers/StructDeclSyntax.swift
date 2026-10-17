// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import SwiftSyntax

extension StructDeclSyntax {
    /// The names of public static constants explicitly typed as `Self` or the enclosing structure.
    internal var publicStaticSelfConstantNames: Array<String> {
        var names: Array<String> = []

        for member in self.memberBlock.members {
            guard let variable: VariableDeclSyntax = member.decl.as(VariableDeclSyntax.self),
                variable.modifiers.contains(where: { $0.name.text == "public" }),
                variable.modifiers.contains(where: { $0.name.text == "static" }),
                variable.bindingSpecifier.tokenKind == .keyword(.let)
            else {
                continue
            }

            for binding in variable.bindings {
                guard let identifier: IdentifierPatternSyntax = binding.pattern.as(IdentifierPatternSyntax.self),
                    let type: String = binding.typeAnnotation?.type.trimmedDescription,
                    type == "Self" || type == self.name.text
                else {
                    continue
                }

                names.append(identifier.identifier.text)
            }
        }

        return names
    }
}
