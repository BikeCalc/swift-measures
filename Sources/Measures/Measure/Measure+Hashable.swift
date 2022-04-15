// Measure+Hashable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure: Hashable
where Unit: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.value)
		hasher.combine(self.unit)
	}
}
