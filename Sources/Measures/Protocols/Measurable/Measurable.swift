// Measurable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// Representing a type that can be measured.
public protocol Measurable: DefinableByConvention {
	
	// MARK: - Creating Units
	
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
	
	// MARK: - Base Unit
	
	/// The base unit of this instance's dimension.
	static var base: Self { get }
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
		let container: KeyedDecodingContainer<MeasurableCodingKeys> = try decoder.container(keyedBy: MeasurableCodingKeys.self)
		
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
		var container = encoder.container(keyedBy: MeasurableCodingKeys.self)
		
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
