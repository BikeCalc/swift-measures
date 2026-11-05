// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A half-open range of character offsets in the original expression.
internal struct SourceSpan {
    /// The offset of the first character, starting at zero.
    internal let start: Int

    /// The offset immediately after the last character.
    internal let end: Int

    /// Creates a source range using zero-based character offsets.
    ///
    /// - Parameters:
    ///   - start: The offset of the first character.
    ///   - end: The exclusive end offset.
    internal init(
        start: Int,
        end: Int
    ) {
        self.start = start
        self.end = end
    }
}

// MARK: - Equatable

extension SourceSpan: Equatable {}

// MARK: - Sendable

extension SourceSpan: Sendable {}
