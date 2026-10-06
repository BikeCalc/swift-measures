// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import NumericsExtended

/// A unit whose physical dimension, scale, offset, and symbol are defined at runtime.
///
/// Conversion to the coherent SI reference uses `value * coefficient + constant`.
/// Multiplication and division combine dimensions and coefficients; integer powers scale the dimension's exponents.
/// Unit-level arithmetic requires zero constants, except for powers zero and one. Convert measures with nonzero
/// constants to coherent units before combining them. Arithmetic traps if its result has a nonfinite or nonpositive
/// coefficient, or an exponent overflows.
/// Symbols describe the operations performed and are not simplified. Equality and hashing use the dimension,
/// coefficient, and constant, excluding the symbol.
///
/// For example:
///
/// ```swift
/// let distance = ComposedUnit(Length.meter)
/// let duration = ComposedUnit(Time.second)
/// let speed = distance / duration
///
/// print(speed.symbol)
/// // Prints "(m)/(s)"
/// ```
public struct ComposedUnit {
    public let coefficient: Double

    public let constant: Double

    public let symbol: String

    public let dimension: Dimension

    /// Creates a unit with the specified conversion, symbol, and physical dimension.
    ///
    /// The coefficient must be finite and positive, and the constant must be finite.
    ///
    /// - Parameters:
    ///   - coefficient: The multiplicative scale relative to the coherent SI reference.
    ///   - constant: The additive offset applied after scaling; defaults to zero.
    ///   - symbol: The display symbol for the unit.
    ///   - dimension: The exponents of the seven SI base quantities.
    public init(
        coefficient: Double,
        constant: Double = 0,
        symbol: String,
        dimension: Dimension
    ) {
        precondition(coefficient.isFinite && coefficient > 0)
        precondition(constant.isFinite)

        self.coefficient = coefficient
        self.constant = constant
        self.symbol = symbol
        self.dimension = dimension
    }

    /// Creates a composed unit preserving a named unit's conversion, symbol, and dimension.
    ///
    /// - Parameter unit: The named unit to represent as a composed unit.
    public init<UnitType>(_ unit: UnitType)
    where UnitType: NamedUnit {
        self.init(
            coefficient: unit.coefficient,
            constant: unit.constant,
            symbol: unit.symbol,
            dimension: unit.dimension
        )
    }

    // TODO: Simplify composed symbols while preserving their original units and scale.
    // TODO: Format coherent unit symbols with superscripts and a grouped denominator.
    /// The unit with the same dimension, coefficient one, and constant zero in coherent SI units.
    internal var coherentUnit: Self {
        let factors: Array<(String, Int)> = [
            (Length.meter.symbol, self.dimension.length),
            (Mass.kilogram.symbol, self.dimension.mass),
            (Time.second.symbol, self.dimension.time),
            (ElectricCurrent.ampere.symbol, self.dimension.electricCurrent),
            (ThermodynamicTemperature.kelvin.symbol, self.dimension.thermodynamicTemperature),
            (SubstanceAmount.mole.symbol, self.dimension.substanceAmount),
            (LuminousIntensity.candela.symbol, self.dimension.luminousIntensity)
        ]
        let symbols: Array<String> = factors.compactMap { symbol, exponent in
            guard exponent != 0 else {
                return nil
            }

            return exponent == 1 ? symbol : "\(symbol)^\(exponent)"
        }

        return .init(
            coefficient: 1,
            symbol: symbols.isEmpty ? "1" : symbols.joined(separator: "·"),
            dimension: self.dimension
        )
    }

    /// Returns a unit by multiplying coefficients and adding corresponding dimension exponents.
    ///
    /// Both units must have zero constants.
    ///
    /// - Parameters:
    ///   - lhs: The first factor unit.
    ///   - rhs: The second factor unit.
    /// - Returns: The composed product unit.
    public static func * (
        _ lhs: Self,
        _ rhs: Self
    ) -> Self {
        precondition(lhs.constant == 0 && rhs.constant == 0)

        return .init(
            coefficient: lhs.coefficient * rhs.coefficient,
            symbol: "(\(lhs.symbol))·(\(rhs.symbol))",
            dimension: lhs.dimension * rhs.dimension
        )
    }

    /// Returns a unit by dividing coefficients and subtracting corresponding dimension exponents.
    ///
    /// Both units must have zero constants.
    ///
    /// - Parameters:
    ///   - lhs: The numerator unit.
    ///   - rhs: The denominator unit.
    /// - Returns: The composed quotient unit.
    public static func / (
        _ lhs: Self,
        _ rhs: Self
    ) -> Self {
        precondition(lhs.constant == 0 && rhs.constant == 0)

        return .init(
            coefficient: lhs.coefficient / rhs.coefficient,
            symbol: "(\(lhs.symbol))/(\(rhs.symbol))",
            dimension: lhs.dimension / rhs.dimension
        )
    }

    /// Returns a unit by raising its coefficient and multiplying its dimension exponents by an integer.
    ///
    /// Exponent zero returns the dimensionless identity; exponent one preserves the original unit.
    /// Other exponents require a zero constant, and negative exponents produce reciprocal powers.
    ///
    /// - Parameters:
    ///   - lhs: The unit to raise to a power.
    ///   - rhs: The integer exponent; zero produces a dimensionless unit with coefficient one.
    /// - Returns: The composed power unit.
    public static func ** (
        _ lhs: Self,
        _ rhs: Int
    ) -> Self {
        switch rhs {
        case 0:
            return .init(
                coefficient: 1,
                symbol: "1",
                dimension: .init()
            )
        case 1:
            return lhs
        default:
            precondition(lhs.constant == 0)
            return .init(
                coefficient: integerPower(lhs.coefficient, exponent: rhs),
                symbol: "(\(lhs.symbol))^\(rhs)",
                dimension: lhs.dimension ** rhs
            )
        }
    }
}

// MARK: - ComposableUnit

extension ComposedUnit: ComposableUnit {
    /// The valid reference-scale range, restricted to nonnegative values for pure thermodynamic temperature.
    public var validRange: ClosedRange<Double> {
        if self.dimension == Dimension(thermodynamicTemperature: 1) {
            return .zero ... .infinity
        }

        return -.infinity ... .infinity
    }
}

// MARK: - Decodable

extension ComposedUnit: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UnitCodingKeys.self)
        let coefficient = try container.decode(Double.self, forKey: .coefficient)
        let constant = try container.decodeIfPresent(Double.self, forKey: .constant) ?? 0
        let symbol = try container.decode(String.self, forKey: .symbol)
        let dimension = try container.decode(Dimension.self, forKey: .dimension)

        guard coefficient.isFinite && coefficient > 0 else {
            throw DecodingError.dataCorruptedError(
                forKey: .coefficient,
                in: container,
                debugDescription: "The coefficient must be finite and positive."
            )
        }
        guard constant.isFinite else {
            throw DecodingError.dataCorruptedError(
                forKey: .constant,
                in: container,
                debugDescription: "The constant must be finite."
            )
        }

        self.init(
            coefficient: coefficient,
            constant: constant,
            symbol: symbol,
            dimension: dimension
        )
    }
}

// MARK: - Encodable

extension ComposedUnit: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UnitCodingKeys.self)

        try container.encode(self.coefficient, forKey: .coefficient)
        try container.encode(self.constant, forKey: .constant)
        try container.encode(self.symbol, forKey: .symbol)
        try container.encode(self.dimension, forKey: .dimension)
    }
}

// MARK: - Equatable

extension ComposedUnit: Equatable {
    public static func == (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.coefficient == rhs.coefficient
            && lhs.constant == rhs.constant
            && lhs.dimension == rhs.dimension
    }
}

// MARK: - Hashable

extension ComposedUnit: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.coefficient)
        hasher.combine(self.constant)
        hasher.combine(self.dimension)
    }
}

// MARK: - Sendable

extension ComposedUnit: Sendable {}
