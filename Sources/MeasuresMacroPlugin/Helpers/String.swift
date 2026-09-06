// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

extension String {
    /// Returns this string with a space inserted before each uppercase character except the first.
    internal func splitBeforeUppercase() -> String {
        return self.reduce(into: "") { result, character in
            if character.isUppercase && !result.isEmpty {
                result.append(" ")
            }

            result.append(character)
        }
    }
}
