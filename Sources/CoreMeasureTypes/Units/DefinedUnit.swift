// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit with an explicit conversion definition and a shared base unit.
///
/// Conformance does not require an SI dimension. Units that support dimensional composition also conform to
/// `ComposableUnit`.
public protocol DefinedUnit: Unit {
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

    /// The shared reference unit through which values of this unit type are converted.
    static var base: Self { get }
}

extension DefinedUnit
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

extension DefinedUnit
where Self: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UnitCodingKeys.self)

        try container.encode(self.coefficient, forKey: .coefficient)
        try container.encode(self.constant, forKey: .constant)
        try container.encode(self.symbol, forKey: .symbol)
    }
}

extension DefinedUnit
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

extension DefinedUnit
where Self: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.coefficient.hashValue)
        hasher.combine(self.constant.hashValue)
        hasher.combine(self.symbol.hashValue)
    }
}
