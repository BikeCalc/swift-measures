// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import SwiftDiagnostics

/// An error emitted while expanding a unit macro.
internal enum UnitMacroDiagnostic {
    /// The supplied unit name is empty.
    case emptyName

    /// The supplied unit symbol is empty.
    case emptySymbol

    /// A required macro argument is not an uninterpolated string literal.
    ///
    /// - Parameter argument: The name of the argument that requires a string literal.
    case literalRequired(_ argument: String)

    /// A unit macro is attached to a declaration other than a structure.
    ///
    /// - Parameter macro: The name of the unit macro that requires a structure.
    case structOnly(_ macro: String)
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
        case .emptySymbol:
            return MessageID(
                domain: "Measures.UnitMacros",
                id: "empty-symbol"
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
        case .emptySymbol:
            return "The unit symbol cannot be empty."
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
