// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import NumericsExtended

/// A unit with an affine conversion to its reference scale.
///
/// Reference values are calculated as `value * coefficient + constant`. Conversion to another compatible unit subtracts
/// that unit's constant and divides by its coefficient. The valid range is expressed on the reference scale.
///
/// Explicit initialization preserves the supplied conversion parameters and symbol, including nonfinite values.
/// This allows measures to represent NaT without requiring units to implement a separate sentinel. A usable
/// conversion requires a finite positive coefficient and a finite constant.
///
/// The default compatibility implementation accepts every instance of the same unit type. Types with dimensions that
/// vary between instances must provide a compatibility check; `ComposableUnit` compares their dimensions.
public protocol Unit {
    /// Creates a new instance preserving the specified coefficient, constant, and symbol.
    ///
    /// Implementations must accept nonfinite parameters, including NaN, without rejecting or normalizing them.
    /// The concrete type determines any physical dimension that is not expressed by these parameters.
    ///
    /// - Parameters:
    ///   - coefficient: The coefficient.
    ///   - constant: The constant.
    ///   - symbol: The symbol.
    init(
        coefficient: Double,
        constant: Double,
        symbol: String
    )

    /// The multiplicative scale relative to the reference unit.
    ///
    /// Valid conversions require a finite, strictly positive value.
    var coefficient: Double { get }

    /// The additive offset applied after scaling.
    ///
    /// Valid conversions require a finite value, which may be negative, zero, or positive.
    var constant: Double { get }

    /// The display symbol for this unit.
    var symbol: String { get }

    /// The valid value range on the reference scale.
    var validRange: ClosedRange<Double> { get }

    /// Returns a boolean value indicating whether values can be converted between these units.
    ///
    /// - Parameter other: The unit to check for conversion compatibility with this unit.
    /// - Returns: A boolean value indicating whether values can be converted between this unit and the other unit.
    func isCompatible(with other: Self) -> Bool
}

extension Unit {
    public var validRange: ClosedRange<Double> {
        return .negativeInfinity ... .infinity
    }

    public func isCompatible(with other: Self) -> Bool {
        return true
    }
}

extension Unit
where Self: CanonicallyEquatable {
    public func isCanonicallyEqual(to other: Self) -> Bool {
        return self.isCompatible(with: other) == true
            && self.coefficient == other.coefficient
            && self.constant == other.constant
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
