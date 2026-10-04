// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit with an affine conversion to its reference scale.
public protocol Unit {
    /// The multiplicative scale relative to the reference unit.
    var coefficient: Double { get }

    /// The additive offset applied after scaling.
    var constant: Double { get }

    /// The display symbol for this unit.
    var symbol: String { get }

    /// The valid value range on the reference scale.
    var validRange: ClosedRange<Double> { get }

    /// Returns whether values can be converted between these units.
    ///
    /// - Parameter other: The unit to check for conversion compatibility with this unit.
    /// - Returns: Whether values can be converted between this unit and the other unit.
    func isCompatible(with other: Self) -> Bool
}

extension Unit {
    public var validRange: ClosedRange<Double> {
        return -.infinity ... .infinity
    }

    public func isCompatible(with other: Self) -> Bool {
        return true
    }
}

extension Unit
where Self: Comparable {
    public static func < (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.coefficient + lhs.constant < rhs.coefficient + rhs.constant
    }
}
