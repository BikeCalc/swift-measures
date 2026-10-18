// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A type that can represent not-a-thing values.
public protocol RepresentableByNaT {
    /// A boolean value indicating whether this instance is not a thing.
    var isNaT: Bool { get }

    /// The not-a-thing value.
    static var nat: Self { get }
}
