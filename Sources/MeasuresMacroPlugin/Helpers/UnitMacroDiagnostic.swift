// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import SwiftDiagnostics

internal enum UnitMacroDiagnostic {
    case emptyName
    case literalRequired(String)
    case structOnly(String)
}

// MARK: - DiagnosticMessage

extension UnitMacroDiagnostic: DiagnosticMessage {
    internal var diagnosticID: MessageID {
        switch self {
        case .emptyName:
            return MessageID(
                domain: "Measures.UnitMacros",
                id: "empty-name"
            )
        case .literalRequired:
            return MessageID(
                domain: "Measures.UnitMacros",
                id: "literal-required"
            )
        case .structOnly:
            return MessageID(
                domain: "Measures.UnitMacros",
                id: "struct-only"
            )
        }
    }

    internal var message: String {
        switch self {
        case .emptyName:
            return "The unit name cannot be empty."
        case .literalRequired(let argument):
            return "The \(argument) must be a string literal."
        case .structOnly(let macro):
            return "@\(macro) can only be attached to a structure."
        }
    }

    internal var severity: DiagnosticSeverity {
        return .error
    }
}
