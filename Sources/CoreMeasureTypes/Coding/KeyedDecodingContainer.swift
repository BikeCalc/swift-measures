// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

extension KeyedDecodingContainer {
    /// Decodes a value, returning the supplied default only when the key is absent.
    ///
    /// Present null values and values that cannot be decoded are passed to the ordinary decoder and are not replaced
    /// by the default value.
    ///
    /// - Parameters:
    ///   - type: The type of value to decode.
    ///   - key: The key associated with the value.
    ///   - defaultValue: The value returned when the key is absent.
    /// - Returns: The decoded value, or the default value when the key is absent.
    /// - Throws: Any error thrown when decoding a present value.
    package func decode<Value>(
        _ type: Value.Type,
        forKey key: Key,
        defaultValue: Value
    ) throws -> Value
    where Value: Decodable {
        guard self.contains(key) == true else {
            return defaultValue
        }

        return try self.decode(
            type,
            forKey: key
        )
    }
}
