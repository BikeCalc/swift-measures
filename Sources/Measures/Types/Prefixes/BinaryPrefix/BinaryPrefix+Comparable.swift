// BinaryPrefix+Comparable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension BinaryPrefix: Comparable {
	public static func < (_ lhs: Self, _ rhs: Self) -> Bool {
		return lhs.coefficient < rhs.coefficient
	}
}
