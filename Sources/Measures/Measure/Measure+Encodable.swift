// Measure+Encodable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure: Encodable
where Unit: Encodable {
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: Self.MeasureCodingKeys.self)
		
		try container.encode(self.value, forKey: .value)
		try container.encode(self.unit, forKey: .unit)
	}
}
