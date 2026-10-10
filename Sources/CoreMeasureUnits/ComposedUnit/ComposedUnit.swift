// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes
import CoreNumericOperators
import NumericsExtended

/// A composed unit whose only stored state is its structured factors.
///
/// Unit representations preserve custom scales and dimensions without resolving symbols through a registry.
/// Symbols are display labels, never parsed. Simplification and normalization are explicit operations.
public struct ComposedUnit {
    /// A snapshot of a defined unit, independent of its concrete Swift type.
    internal struct AnyDefinedUnit: Codable, Hashable, Sendable {
        /// The physical dimension of the captured unit.
        internal let dimension: Dimension

        /// The multiplicative scale relative to the coherent SI reference.
        internal let coefficient: Double

        /// The additive offset applied after scaling.
        internal let constant: Double

        /// The original display label, preserved without parsing.
        internal let symbol: String

        /// Captures an explicit unit definition without interpreting its symbol.
        fileprivate init(
            coefficient: Double,
            constant: Double,
            symbol: String,
            dimension: Dimension
        ) {
            self.coefficient = coefficient
            self.constant = constant
            self.symbol = symbol
            self.dimension = dimension
        }

        /// Captures the conversion and dimension information of a defined unit.
        ///
        /// - Parameter unit: A defined unit, including a developer-defined unit of an existing dimension.
        internal init<UnitType>(_ unit: UnitType)
        where UnitType: ComposableUnit & DefinedUnit {
            self.dimension = unit.dimension
            self.coefficient = unit.coefficient
            self.constant = unit.constant
            self.symbol = unit.symbol
        }

        /// Whether the conversion values are finite and the coefficient is positive.
        internal var hasValidConversion: Bool {
            return self.coefficient.isFinite
                && self.coefficient > 0
                && self.constant.isFinite
        }
    }

    /// A unit representation and its signed integer exponent.
    internal struct Factor: Codable, Hashable, Sendable {
        /// The complete captured unit used to identify matching factors.
        internal let unit: AnyDefinedUnit

        /// The signed power applied to the captured unit.
        internal let exponent: Int

        /// Creates a factor from a captured unit and an exponent.
        ///
        /// - Parameters:
        ///   - unit: The complete unit representation used for matching factors.
        ///   - exponent: The power applied to this unit.
        internal init(
            unit: AnyDefinedUnit,
            exponent: Int = 1
        ) {
            self.unit = unit
            self.exponent = exponent
        }

        /// The unit's coefficient raised to this factor's exponent.
        internal var raisedCoefficient: Double {
            return self.unit.coefficient ** self.exponent
        }

        /// The same unit representation with its exponent negated.
        internal var inverted: Self {
            return .init(
                unit: self.unit,
                exponent: -self.exponent
            )
        }
    }

    /// The complete source of truth; scale, offset, symbol, and dimension are derived from these factors.
    internal let factors: Array<Self.Factor>

    /// Creates a composed unit from one defined unit, retaining its offset.
    ///
    /// - Parameter unit: The defined unit to capture.
    public init<UnitType>(_ unit: UnitType)
    where UnitType: ComposableUnit & DefinedUnit {
        let factor: Factor = .init(unit: AnyDefinedUnit(unit))
        self.init(factors: [factor])
    }

    /// Creates a composed unit preserving the supplied factors and their order.
    ///
    /// Offsets are permitted only for a single active factor with exponent one. Simplification and normalization are
    /// explicit operations; construction preserves duplicates and zero exponents.
    /// Combined coefficients and dimension exponents must remain representable.
    ///
    /// - Parameter factors: The factors to compose. An empty collection represents the dimensionless identity.
    internal init(factors: Array<Self.Factor>) {
        let validator: ComposedUnitFactorValidator = .init(factors: factors)
        precondition(
            validator.validate(),
            "Factors require valid scales, offsets, and representable combined values."
        )
        self.factors = factors
    }

    /// Builds the coherent reference using actual SI unit representations in dimension order.
    internal var coherent: Self {
        return Self(dimension: self.dimension)
    }

    /// Creates a coherent SI reference directly from a physical dimension.
    ///
    /// - Parameter dimension: The exponents of the seven base quantities.
    internal init(dimension: Dimension) {
        let factors: Array<Factor> = [
            .init(
                unit: AnyDefinedUnit(Length.base),
                exponent: dimension.length
            ),
            .init(
                unit: AnyDefinedUnit(Mass.base),
                exponent: dimension.mass
            ),
            .init(
                unit: AnyDefinedUnit(Time.base),
                exponent: dimension.time
            ),
            .init(
                unit: AnyDefinedUnit(ElectricCurrent.base),
                exponent: dimension.electricCurrent
            ),
            .init(
                unit: AnyDefinedUnit(ThermodynamicTemperature.base),
                exponent: dimension.thermodynamicTemperature
            ),
            .init(
                unit: AnyDefinedUnit(SubstanceAmount.base),
                exponent: dimension.substanceAmount
            ),
            .init(
                unit: AnyDefinedUnit(LuminousIntensity.base),
                exponent: dimension.luminousIntensity
            )
        ]
        self.init(factors: factors)
    }

    /// Multiplies units by combining their structured factors.
    ///
    /// - Parameters:
    ///   - lhs: The first unit, which must have zero offset.
    ///   - rhs: The second unit, which must have zero offset.
    /// - Returns: The composed product, retaining the concatenated factors.
    public static func * (
        _ lhs: Self,
        _ rhs: Self
    ) -> Self {
        precondition(
            lhs.constant == 0 && rhs.constant == 0,
            "Multiplication of units requires zero constants."
        )

        let factors: Array<Factor> = lhs.factors + rhs.factors
        return .init(factors: factors)
    }

    /// Divides units by negating the divisor’s factor exponents.
    ///
    /// - Parameters:
    ///   - lhs: The numerator unit, which must have zero offset.
    ///   - rhs: The denominator unit, which must have zero offset.
    /// - Returns: The composed quotient, retaining the original and inverted factors.
    public static func / (
        _ lhs: Self,
        _ rhs: Self
    ) -> Self {
        precondition(
            lhs.constant == 0 && rhs.constant == 0,
            "Division of units requires zero constants."
        )

        let invertedFactors: Array<Factor> = rhs.factors.map { $0.inverted }
        let factors: Array<Factor> = lhs.factors + invertedFactors
        return .init(factors: factors)
    }

    /// Raises a unit by multiplying its factor exponents.
    ///
    /// - Parameters:
    ///   - lhs: The unit to raise; nonzero offsets permit only exponents zero and one.
    ///   - rhs: The integer exponent.
    /// - Returns: The identity for zero, the original unit for one, or the composed power.
    public static func ** (
        _ lhs: Self,
        _ rhs: Int
    ) -> Self {
        switch rhs {
        case 0:
            return .init(factors: [])
        case 1:
            return lhs
        default:
            precondition(
                lhs.constant == 0,
                "Exponentiation requires a zero constant unless the exponent is zero or one."
            )

            let factors: Array<Factor> = lhs.factors.map { factor in
                return .init(
                    unit: factor.unit,
                    exponent: factor.exponent * rhs
                )
            }

            return .init(factors: factors)
        }
        }
    }
}

// MARK: - ComposableUnit

extension ComposedUnit: ComposableUnit {
    public var coefficient: Double {
        return self.factors.reduce(1) { result, factor in
            // Coherent unit factors have scale one, regardless of their exponent.
            guard factor.unit.coefficient != 1 else {
                return result
            }
            return result * factor.raisedCoefficient
        }
    }

    public var constant: Double {
        guard let factor = self.factors.first(where: { $0.exponent != 0 }), factor.exponent == 1 else {
            return 0
        }
        return factor.unit.constant
    }

    public var symbol: String {
        let formatter: ComposedUnitSymbolFormatter = .init(factors: self.factors)
        return formatter.format()
    }

    public var dimension: Dimension {
        return self.factors.reduce(Dimension()) { result, factor in
            return result * (factor.unit.dimension ** factor.exponent)
        }
    }

    public var validRange: ClosedRange<Double> {
        if self.dimension == Dimension(thermodynamicTemperature: 1) {
            return 0 ... .infinity
        } else {
            return .negativeInfinity ... .infinity
        }
    }
}

// MARK: - Decodable

extension ComposedUnit: Decodable {
    /// Decodes factors without trusting serialized scales, offsets, or exponent combinations.
    ///
    /// The wire format is simply an array of factors; no redundant aggregate properties are encoded.
    ///
    /// - Parameter decoder: The decoder supplying the factor array.
    /// - Throws: A decoding error for invalid scales, offsets, or unrepresentable derived values.
    public init(from decoder: any Decoder) throws {
        let container: any SingleValueDecodingContainer = try decoder.singleValueContainer()
        let factors: Array<Factor> = try container.decode(Array<Factor>.self)
        let validator: ComposedUnitFactorValidator = .init(factors: factors)

        guard validator.validate() else {
            throw DecodingError.dataCorruptedError(
                forKey: .constant,
                in: container,
                debugDescription: "The constant must be finite."
                debugDescription: "Factors require valid scales, offsets, and representable combined values."
            )
        }

        self.init(
        self.factors = factors
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
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
    }
}

// MARK: - Equatable

extension ComposedUnit: Equatable {
    public static func == (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.coefficient == rhs.coefficient
        return lhs.dimension == rhs.dimension
            && lhs.coefficient == rhs.coefficient
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

    }
}

// MARK: - Sendable

extension ComposedUnit: Sendable {}
