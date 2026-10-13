// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import NumericsExtended

/// A property wrapper that converts a measure whenever it is assigned.
///
/// Pass a destination unit to keep the wrapped measure expressed in that unit. Defined units support `.base` as a
/// destination. An explicit composed destination is also fixed: subsequent assignments must have a compatible dimension.
/// For composed measures whose dimension may change, the coherent conversion policy resolves a destination for each
/// assignment instead.
///
/// Encoding stores only the wrapped measure. Decoding uses its stored unit as a fixed destination and does not restore
/// a dynamic conversion policy.
///
/// For example:
///
/// ```swift
/// @Converted(to: .base)
/// var distance: Measure<Length> = .init(100, .centimeter)
///
/// print(distance)
/// // Prints "1.0 m"
/// ```
@propertyWrapper
public struct Converted<UnitType>
where UnitType: Unit {
    /// The converted stored measure.
    private var value: Measure<UnitType>

    /// Resolves the destination unit for each assigned measure.
    private let destination: (UnitType) -> UnitType

    /// Creates a wrapper containing the specified measure converted to the specified unit.
    ///
    /// - Parameters:
    ///   - wrappedValue: The measure to convert and store.
    ///   - unit: The unit in which to store the measure.
    /// - Precondition: The source and destination units are compatible on initialization and every assignment.
    public init(
        wrappedValue: Measure<UnitType>,
        to unit: UnitType
    ) {
        self.init(
            wrappedValue: wrappedValue,
            resolvingUnit: { _ in unit }
        )
    }

    /// Creates a wrapper that resolves its destination from each assigned unit.
    ///
    /// - Parameters:
    ///   - wrappedValue: The measure to convert and store.
    ///   - destination: A resolver returning a unit compatible with the assigned unit.
    package init(
        wrappedValue: Measure<UnitType>,
        resolvingUnit destination: @escaping (UnitType) -> UnitType
    ) {
        self.destination = destination
        self.value = wrappedValue.converted(to: destination(wrappedValue.unit))
    }

    /// The wrapped measure, converted whenever it is assigned.
    public var wrappedValue: Measure<UnitType> {
        get {
            return self.value
        }
        set(newValue) {
            self.value = newValue.converted(to: self.destination(newValue.unit))
        }
    }
}

extension Converted
where UnitType == ComposedUnit {
    /// A conversion policy that derives its destination from the assigned composed unit.
    public enum ConversionPolicy {
        /// Converts each assigned value to the coherent SI unit for its current dimension.
        case coherent
    }

    /// Creates a wrapper that converts each assigned measure to its coherent SI unit.
    ///
    /// The destination is recalculated on every assignment, allowing the stored dimension to change. Conversion
    /// applies the assigned unit's coefficient and constant. Encoding stores only the measure; decoding restores
    /// a fixed destination rather than this policy.
    ///
    /// For example:
    ///
    /// ```swift
    /// @Converted(to: .coherent)
    /// var distance = Measure(2, ComposedUnit(Length.centimeter))
    ///
    /// print(distance)
    /// // Prints "0.02 m"
    /// ```
    ///
    /// - Parameters:
    ///   - wrappedValue: The measure to convert and store.
    ///   - conversionPolicy: The policy used to determine the destination on every assignment.
    public init(
        wrappedValue: Measure<ComposedUnit>,
        to conversionPolicy: ConversionPolicy
    ) {
        switch conversionPolicy {
        case .coherent:
            self.init(wrappedValue: wrappedValue) { unit in
                return unit.coherent
            }
        }
    }
}

// MARK: - CanonicallyEquatable

extension Converted: CanonicallyEquatable {
    /// Returns a boolean value indicating whether the wrapped measures represent the same quantity.
    ///
    /// Compares the wrapped measures using their units' conversion values. The conversion policies are not compared.
    ///
    /// - Parameter other: The converted measure to compare with this instance.
    /// - Returns: `true` when the wrapped measures are canonically equal, and `false` otherwise.
    public func isCanonicallyEqual(to other: Self) -> Bool {
        return self.wrappedValue.isCanonicallyEqual(to: other.wrappedValue)
    }
}

// MARK: - Comparable

extension Converted: Comparable
where UnitType: Equatable {
    /// Returns a boolean value indicating whether the first converted measure precedes the second.
    ///
    /// - Parameters:
    ///   - lhs: The first converted measure to compare.
    ///   - rhs: The second converted measure to compare.
    /// - Returns: The result of comparing the wrapped measures.
    public static func < (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.wrappedValue < rhs.wrappedValue
    }

    /// Returns a boolean value indicating whether the first converted measure precedes or equals the second.
    ///
    /// - Parameters:
    ///   - lhs: The first converted measure to compare.
    ///   - rhs: The second converted measure to compare.
    /// - Returns: `true` when the first measure precedes or equals the second, and `false` otherwise.
    public static func <= (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.wrappedValue <= rhs.wrappedValue
    }

    /// Returns a boolean value indicating whether the first converted measure follows the second.
    ///
    /// - Parameters:
    ///   - lhs: The first converted measure to compare.
    ///   - rhs: The second converted measure to compare.
    /// - Returns: `true` when the first measure follows the second, and `false` otherwise.
    public static func > (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.wrappedValue > rhs.wrappedValue
    }

    /// Returns a boolean value indicating whether the first converted measure follows or equals the second.
    ///
    /// - Parameters:
    ///   - lhs: The first converted measure to compare.
    ///   - rhs: The second converted measure to compare.
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
where UnitType: Decodable {
    /// Creates a wrapper by decoding a converted measure.
    ///
    /// The decoded unit becomes a fixed destination for subsequent assignments. Dynamic conversion policies are
    /// not serialized.
    ///
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: Any error thrown while decoding the wrapped measure.
    public init(from decoder: any Decoder) throws {
        let value: Measure<UnitType> = try .init(from: decoder)

        self.init(
            wrappedValue: value,
            to: value.unit
        )
    }
}

// MARK: - Encodable

extension Converted: Encodable
where UnitType: Encodable {
    /// Encodes the converted wrapped measure.
    ///
    /// Only the measure is encoded; the conversion policy is not preserved.
    ///
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: Any error thrown while encoding the wrapped measure.
    public func encode(to encoder: any Encoder) throws {
        try self.wrappedValue.encode(to: encoder)
    }
}

// MARK: - Equatable

extension Converted: Equatable
where UnitType: Equatable {
    /// Returns a boolean value indicating whether two converted measures are equal.
    ///
    /// - Parameters:
    ///   - lhs: The first converted value to compare.
    ///   - rhs: The second converted value to compare.
    /// - Returns: The result of comparing the wrapped measures for equality.
    public static func == (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}

// MARK: - Hashable

extension Converted: Hashable
where UnitType: Hashable {
    /// Hashes the wrapped measure by feeding it to the specified hasher.
    ///
    /// - Parameter hasher: The hasher to use when combining the components of this instance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.wrappedValue)
    }
}
