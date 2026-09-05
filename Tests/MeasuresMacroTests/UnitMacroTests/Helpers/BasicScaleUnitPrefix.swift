// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

@testable import MeasuresMacroSupport

internal enum BasicScaleUnitPrefix: String {
    case large
    case none = ""
    case small

    internal var coefficient: Double {
        switch self {
        case .large:
            return 1e3
        case .none:
            return 1
        case .small:
            return 1e-3
        }
    }

    internal var symbol: String {
        switch self {
        case .large:
            return "L"
        case .none:
            return ""
        case .small:
            return "S"
        }
    }
}

// MARK: - CaseIterable

extension BasicScaleUnitPrefix: CaseIterable {}

// MARK: - Equatable

extension BasicScaleUnitPrefix: Equatable {}

// MARK: - RawRepresentable

extension BasicScaleUnitPrefix: RawRepresentable {}

// MARK: - UnitPrefix

extension BasicScaleUnitPrefix: UnitPrefix {}
