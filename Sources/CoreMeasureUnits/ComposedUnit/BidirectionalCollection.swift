// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

extension BidirectionalCollection {
    /// The index of the last element, or `nil` if the collection is empty.
    internal var lastIndex: Self.Index? {
        guard self.isEmpty == false else {
            return nil
        }

        return self.index(before: self.endIndex)
    }
}
