// MeasurableCodingKeys.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// The coding keys for the codable protocol.
internal enum MeasurableCodingKeys: String, CodingKey {
	case coefficient = "coefficient"
	case constant = "constant"
	case symbol = "symbol"
	case name = "name"
}
