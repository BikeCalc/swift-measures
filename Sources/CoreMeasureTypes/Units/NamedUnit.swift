// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A named unit with a fixed SI dimension.
public protocol NamedUnit: ComposableUnit {
    /// Creates a new instance with the specified coefficient, constant and symbol.
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

    /// The base unit through which values of this dimension are converted.
    static var base: Self { get }
}

extension NamedUnit
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

extension NamedUnit
where Self: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UnitCodingKeys.self)

        try container.encode(self.coefficient, forKey: .coefficient)
        try container.encode(self.constant, forKey: .constant)
        try container.encode(self.symbol, forKey: .symbol)
    }
}

extension NamedUnit
where Self: Equatable {
    /// A boolean value indicating whether this instance is the base.
    @available(*, deprecated)
    public var isBase: Bool {
        return self == Self.base
    }

    public static func == (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool {
        return lhs.coefficient == rhs.coefficient
            && lhs.constant == rhs.constant
            && lhs.symbol == rhs.symbol
    }
}

extension NamedUnit
where Self: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.coefficient.hashValue)
        hasher.combine(self.constant.hashValue)
        hasher.combine(self.symbol.hashValue)
    }
}
