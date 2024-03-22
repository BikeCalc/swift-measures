//
// MeasureCodingKeys.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// The coding keys for the codable protocol.
internal enum MeasureCodingKeys: String {
    case value = "value"
    case unit = "unit"
}

// MARK: - CodingKey

extension MeasureCodingKeys: CodingKey {}

// MARK: - RawRepresentable

extension MeasureCodingKeys: RawRepresentable {
    internal typealias RawValue = String
}
