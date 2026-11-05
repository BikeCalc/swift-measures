// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A type whose instances can be checked against its validity rules.
public protocol Validatable {
    /// A boolean value indicating whether this instance satisfies the type's validity rules.
    var isValid: Bool { get }
}
