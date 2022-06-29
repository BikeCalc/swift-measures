// BinaryPrefix+Equatable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension BinaryPrefix: Equatable {
	public static func == (_ lhs: Self, _ rhs: Self) -> Bool {
		return lhs.rawValue == rhs.rawValue
	}
}
