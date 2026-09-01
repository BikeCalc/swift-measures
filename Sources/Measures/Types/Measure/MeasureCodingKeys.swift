// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

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
