// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import NumericsExtended

/// A physical dimension expressed as integer exponents of the seven SI base quantities.
///
/// Positive exponents represent factors in a numerator, negative exponents represent factors in a denominator,
/// and zero exponents omit a base quantity. A dimension with every exponent equal to zero is dimensionless.
/// Dimensions describe physical composition independently of a unit's scale, offset, or symbol. Different named
/// quantities can share the same dimension.
///
/// Multiplication adds corresponding exponents, division subtracts them, and exponentiation multiplies them by
/// an integer power. These operations use ordinary integer arithmetic and trap on overflow.
///
/// For example:
///
/// ```swift
/// let length = Dimension(length: 1)
/// let time = Dimension(time: 1)
/// let speed = length / time
///
/// print(speed.time)
/// // Prints "-1"
/// ```
public struct Dimension {
    /// The keys used to encode and decode a dimension.
    private enum CodingKeys: String, CodingKey {
        /// The exponent of length.
        case length = "length"

        /// The exponent of mass.
        case mass = "mass"

        /// The exponent of time.
        case time = "time"

        /// The exponent of electric current.
        case electricCurrent = "electric_current"

        /// The exponent of thermodynamic temperature.
        case thermodynamicTemperature = "thermodynamic_temperature"

        /// The exponent of substance amount.
        case substanceAmount = "substance_amount"

        /// The exponent of luminous intensity.
        case luminousIntensity = "luminous_intensity"
    }

    /// The exponent of length.
    public let length: Int

    /// The exponent of mass.
    public let mass: Int

    /// The exponent of time.
    public let time: Int

    /// The exponent of electric current.
    public let electricCurrent: Int

    /// The exponent of thermodynamic temperature.
    public let thermodynamicTemperature: Int

    /// The exponent of substance amount.
    public let substanceAmount: Int

    /// The exponent of luminous intensity.
    public let luminousIntensity: Int

    /// Creates a dimension from the specified SI base-quantity exponents.
    ///
    /// Omitted exponents default to zero. Omitting all exponents creates a dimensionless value.
    ///
    /// - Parameters:
    ///   - length: The exponent of length.
    ///   - mass: The exponent of mass.
    ///   - time: The exponent of time.
    ///   - electricCurrent: The exponent of electric current.
    ///   - thermodynamicTemperature: The exponent of thermodynamic temperature.
    ///   - substanceAmount: The exponent of substance amount.
    ///   - luminousIntensity: The exponent of luminous intensity.
    public init(
        length: Int = 0,
        mass: Int = 0,
        time: Int = 0,
        electricCurrent: Int = 0,
        thermodynamicTemperature: Int = 0,
        substanceAmount: Int = 0,
        luminousIntensity: Int = 0
    ) {
        self.length = length
        self.mass = mass
        self.time = time
        self.electricCurrent = electricCurrent
        self.thermodynamicTemperature = thermodynamicTemperature
        self.substanceAmount = substanceAmount
        self.luminousIntensity = luminousIntensity
    }

    /// The exponents in SI base-quantity order.
    ///
    /// Ordered by length, mass, time, electric current, thermodynamic temperature, substance amount, and luminous
    /// intensity.
    package var exponents: Array<Int> {
        return [
            self.length,
            self.mass,
            self.time,
            self.electricCurrent,
            self.thermodynamicTemperature,
            self.substanceAmount,
            self.luminousIntensity
        ]
    }

    /// A boolean value indicating whether every SI base-quantity exponent is zero.
    public var isDimensionless: Bool {
        return self.length == 0
            && self.mass == 0
            && self.time == 0
            && self.electricCurrent == 0
            && self.thermodynamicTemperature == 0
            && self.substanceAmount == 0
            && self.luminousIntensity == 0
    }

    /// Returns the dimension of a product by adding corresponding exponents.
    ///
    /// - Parameters:
    ///   - lhs: The dimension of the first factor.
    ///   - rhs: The dimension of the second factor.
    /// - Returns: The dimension of the product.
    public static func * (
        _ lhs: Self,
        _ rhs: Self
    ) -> Self {
        return .init(
            length: lhs.length + rhs.length,
            mass: lhs.mass + rhs.mass,
            time: lhs.time + rhs.time,
            electricCurrent: lhs.electricCurrent + rhs.electricCurrent,
            thermodynamicTemperature: lhs.thermodynamicTemperature + rhs.thermodynamicTemperature,
            substanceAmount: lhs.substanceAmount + rhs.substanceAmount,
            luminousIntensity: lhs.luminousIntensity + rhs.luminousIntensity
        )
    }

    /// Returns the dimension of a quotient by subtracting corresponding exponents.
    ///
    /// - Parameters:
    ///   - lhs: The dimension of the numerator.
    ///   - rhs: The dimension of the denominator.
    /// - Returns: The dimension of the quotient.
    public static func / (
        _ lhs: Self,
        _ rhs: Self
    ) -> Self {
        return .init(
            length: lhs.length - rhs.length,
            mass: lhs.mass - rhs.mass,
            time: lhs.time - rhs.time,
            electricCurrent: lhs.electricCurrent - rhs.electricCurrent,
            thermodynamicTemperature: lhs.thermodynamicTemperature - rhs.thermodynamicTemperature,
            substanceAmount: lhs.substanceAmount - rhs.substanceAmount,
            luminousIntensity: lhs.luminousIntensity - rhs.luminousIntensity
        )
    }

    /// Returns a dimension raised to an integer power by multiplying each exponent by that power.
    ///
    /// A power of zero produces a dimensionless value. A negative power reverses the signs of the exponents
    /// as well as scaling their magnitudes.
    ///
    /// - Parameters:
    ///   - lhs: The dimension to raise to a power.
    ///   - rhs: The integer power.
    /// - Returns: The dimension of the power.
    public static func ** (
        _ lhs: Self,
        _ rhs: Int
    ) -> Self {
        return .init(
            length: lhs.length * rhs,
            mass: lhs.mass * rhs,
            time: lhs.time * rhs,
            electricCurrent: lhs.electricCurrent * rhs,
            thermodynamicTemperature: lhs.thermodynamicTemperature * rhs,
            substanceAmount: lhs.substanceAmount * rhs,
            luminousIntensity: lhs.luminousIntensity * rhs
        )
    }
}

// MARK: - Codable

extension Dimension: Codable {}

// MARK: - CustomDebugStringConvertible

extension Dimension: CustomDebugStringConvertible {
    public var debugDescription: String {
        return """
            Dimension(length: \(self.length), mass: \(self.mass), time: \(self.time), electricCurrent: \
            \(self.electricCurrent), thermodynamicTemperature: \(self.thermodynamicTemperature), substanceAmount: \
            \(self.substanceAmount), luminousIntensity: \(self.luminousIntensity))
            """
    }
}

// MARK: - Equatable

extension Dimension: Equatable {}

// MARK: - Hashable

extension Dimension: Hashable {}

// MARK: - Sendable

extension Dimension: Sendable {}
