// Measure+Addable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure: Addable {
	public static func + (_ lhs: Self, _ rhs: Self) -> Self {
		let lhsValue: Double = lhs.value
		let rhsValue: Double = rhs.converted(to: lhs.unit).value
		let newValue: Double = lhsValue + rhsValue
		
		return .init(newValue, lhs.unit)
	}
}
