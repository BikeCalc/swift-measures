// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// Representing a type that can be measured.
public protocol Measurable {
    /// Creates a new instance with the specified coefficient, constant and symbol.
    ///
    /// - parameter coefficient: The coefficient.
    /// - parameter constant: The constant.
    /// - parameter symbol: The symbol.
    init(
        coefficient: Double,
        constant: Double,
        symbol: String
    )

    /// The coefficient of this instance compared to its base unit.
    var coefficient: Double { get }

    /// The constant of this instance compared to its base unit.
    var constant: Double { get }

    /// The symbol of this instance.
    var symbol: String { get }

    /// The base unit of this instance's dimension.
    static var base: Self { get }

    /// The valid range expressed in the base unit.
    static var validRange: ClosedRange<Double> { get }
}

/// The keys used to encode and decode a measurable unit.
fileprivate enum UnitCodingKeys: String, CodingKey {
    case coefficient
    case constant
    case symbol
}

extension Measurable {
    public static var validRange: ClosedRange<Double> {
        return -.infinity ... .infinity
    }
}

extension Measurable
where Self: Comparable {
    public static func < (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.coefficient + lhs.constant < rhs.coefficient + rhs.constant
    }
}

extension Measurable
where Self: Decodable {
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<UnitCodingKeys> = try decoder.container(
            keyedBy: UnitCodingKeys.self
        )

        let coefficient: Double = try container.decode(Double.self, forKey: .coefficient)
        let constant: Double = try container.decodeIfPresent(Double.self, forKey: .constant) ?? .zero
        let symbol: String = try container.decode(String.self, forKey: .symbol)

        self.init(
            coefficient: coefficient,
            constant: constant,
            symbol: symbol
        )
    }
}

extension Measurable
where Self: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UnitCodingKeys.self)

        try container.encode(self.coefficient, forKey: .coefficient)
        try container.encode(self.constant, forKey: .constant)
        try container.encode(self.symbol, forKey: .symbol)
    }
}

extension Measurable
where Self: Equatable {
    /// A boolean value indicating whether this instance is the base.
    public var isBase: Bool {
        return self == Self.base
    }

    public static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.coefficient == rhs.coefficient
            && lhs.constant == rhs.constant
            && lhs.symbol == rhs.symbol
    }
}

extension Measurable
where Self: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.coefficient.hashValue)
        hasher.combine(self.constant.hashValue)
        hasher.combine(self.symbol.hashValue)
    }
}
