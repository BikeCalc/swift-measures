//
// MeasurableCodingKeys.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// The coding keys for the codable protocol.
internal enum MeasurableCodingKeys: String {
	case coefficient = "coefficient"
	case constant = "constant"
	case symbol = "symbol"
}

// MARK: - CodingKey

extension MeasurableCodingKeys: CodingKey {}

// MARK: - RawRepresentable

extension MeasurableCodingKeys: RawRepresentable {
    internal typealias RawValue = String
}
