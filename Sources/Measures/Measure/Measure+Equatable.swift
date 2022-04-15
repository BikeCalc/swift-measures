// Measure+Equatable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure: Equatable
where Unit: Equatable {
	public static func == (_ lhs: Self, _ rhs: Self) -> Bool {
		return lhs.value == rhs.value
			&& lhs.unit == rhs.unit
	}
}
