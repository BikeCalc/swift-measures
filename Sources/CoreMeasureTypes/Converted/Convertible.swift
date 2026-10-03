// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A type whose value can be converted between units.
public protocol Convertible {
    /// The type of unit used by this value.
    associatedtype UnitType
    where UnitType: Unit

    /// Returns this measure converted to the specified unit.
    ///
    /// - Parameter unit: The unit to convert to.
    /// - Returns: The converted measure.
    func converted(to unit: Self.UnitType) -> Self

    /// Converts this measure to the specified unit.
    ///
    /// - Parameter unit: The unit to convert to.
    mutating func convert(to unit: Self.UnitType)
}
