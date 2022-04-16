// MetricPrefix+Comparable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension MetricPrefix: Comparable {
	public static func < (lhs: Self, rhs: Self) -> Bool {
		return lhs.coefficient + lhs.constant < rhs.coefficient + rhs.constant
	}
}
