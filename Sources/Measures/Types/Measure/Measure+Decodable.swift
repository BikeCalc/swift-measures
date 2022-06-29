// Measure+Decodable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure: Decodable
where Unit: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Self.MeasureCodingKeys.self)
		
		let value: Double = try container.decode(Double.self, forKey: .value)
		let unit: Unit = try container.decode(Unit.self, forKey: .unit)
		
		self.init(value, unit)
	}
}
