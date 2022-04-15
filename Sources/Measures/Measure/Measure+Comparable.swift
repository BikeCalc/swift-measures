// Measure+Comparable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure: Comparable {
	public static func < (lhs: Self, rhs: Self) -> Bool {
		let lhsValue: Double = lhs.value
		let rhsValue: Double = rhs.converted(to: lhs.unit).value
		
		return lhsValue < rhsValue
	}
}
