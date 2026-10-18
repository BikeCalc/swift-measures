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
///
/// The default Codable implementations use coefficient, constant, and symbol as their serialized representation. The
/// decoder treats an omitted constant as zero and recreates the unit through its initializer. Dimension information is
/// supplied by the concrete type rather than encoded by this protocol's implementation.
public protocol DefinedUnit: Unit {
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
        var container: KeyedEncodingContainer<UnitCodingKeys> = encoder.container(keyedBy: UnitCodingKeys.self)

        try container.encode(self.coefficient, forKey: .coefficient)
        try container.encode(self.constant, forKey: .constant)
        try container.encode(self.symbol, forKey: .symbol)
    }
}
