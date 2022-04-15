// Measure+RepresentableByZero.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure: RepresentableByZero {
	public static var zero: Self {
		return .init(0, .base)
	}
}
