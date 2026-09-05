// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A property wrapper that keeps a measure expressed in a specified unit.
@propertyWrapper
public struct Converted<Unit>
where Unit: Equatable & Measurable & Sendable {
    /// The converted stored measure.
    private var value: Measure<Unit>

    /// The unit in which the wrapped measure is stored.
    private let unit: Measure<Unit>.Unit

    /// Creates a wrapper containing the specified measure converted to the specified unit.
    ///
    /// - Parameter wrappedValue: The measure to convert and store.
    /// - Parameter unit: The unit in which to store the measure.
    public init(
        wrappedValue: Measure<Unit>,
        to unit: Measure<Unit>.Unit
    ) {
        self.unit = unit
        self.value = wrappedValue.converted(to: unit)
    }

    /// The wrapped measure, converted whenever it is assigned.
    public var wrappedValue: Measure<Unit> {
        get {
            return self.value
        }
        set (newValue) {
            self.value = newValue.converted(to: self.unit)
        }
    }
}

// MARK: - Comparable

extension Converted: Comparable {
    /// Returns a boolean value indicating whether the first converted measure precedes the second.
    ///
    /// - Parameter lhs: The first converted measure to compare.
    /// - Parameter rhs: The second converted measure to compare.
    /// - Returns: The result of comparing the wrapped measures.
    public static func < (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.wrappedValue < rhs.wrappedValue
    }

    /// Returns a boolean value indicating whether the first converted measure precedes or equals the second.
    ///
    /// - Parameter lhs: The first converted measure to compare.
    /// - Parameter rhs: The second converted measure to compare.
    /// - Returns: `true` when the first measure precedes or equals the second, and `false` otherwise.
    public static func <= (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.wrappedValue <= rhs.wrappedValue
    }

    /// Returns a boolean value indicating whether the first converted measure follows the second.
    ///
    /// - Parameter lhs: The first converted measure to compare.
    /// - Parameter rhs: The second converted measure to compare.
    /// - Returns: `true` when the first measure follows the second, and `false` otherwise.
    public static func > (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.wrappedValue > rhs.wrappedValue
    }

    /// Returns a boolean value indicating whether the first converted measure follows or equals the second.
    ///
    /// - Parameter lhs: The first converted measure to compare.
    /// - Parameter rhs: The second converted measure to compare.
    /// - Returns: `true` when the first measure follows or equals the second, and `false` otherwise.
    public static func >= (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.wrappedValue >= rhs.wrappedValue
    }
}

// MARK: - Decodable

extension Converted: Decodable
where Unit: Decodable {
    /// Creates a wrapper by decoding a converted measure.
    ///
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: Any error thrown while decoding the wrapped measure.
    public init(from decoder: any Decoder) throws {
        let value: Measure<Unit> = try .init(from: decoder)

        self.init(
            wrappedValue: value,
            to: value.unit
        )
    }
}

// MARK: - Encodable

extension Converted: Encodable
where Unit: Encodable {
    /// Encodes the converted wrapped measure.
    ///
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: Any error thrown while encoding the wrapped measure.
    public func encode(to encoder: any Encoder) throws {
        try self.wrappedValue.encode(to: encoder)
    }
}

// MARK: - Equatable

extension Converted: Equatable {
    /// Returns a boolean value indicating whether two converted measures are equal.
    ///
    /// - Parameter lhs: The first converted value to compare.
    /// - Parameter rhs: The second converted value to compare.
    /// - Returns: The result of comparing the wrapped measures for equality.
    public static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}

// MARK: - Hashable

extension Converted: Hashable
where Unit: Hashable {
    /// Hashes the wrapped measure by feeding it to the specified hasher.
    ///
    /// - Parameter hasher: The hasher to use when combining the components of this instance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.wrappedValue)
    }
}
