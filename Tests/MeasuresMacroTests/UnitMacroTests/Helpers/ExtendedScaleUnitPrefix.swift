// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

@testable import MeasuresMacroSupport

internal enum ExtendedScaleUnitPrefix: String {
    case extralarge
    case none = ""
    case extrasmall

    internal var coefficient: Double {
        switch self {
        case .extralarge:
            return 1e6
        case .none:
            return 1
        case .extrasmall:
            return 1e-6
        }
    }

    internal var symbol: String {
        switch self {
        case .extralarge:
            return "XL"
        case .none:
            return ""
        case .extrasmall:
            return "XS"
        }
    }
}

// MARK: - CaseIterable

extension ExtendedScaleUnitPrefix: CaseIterable {}

// MARK: - Equatable

extension ExtendedScaleUnitPrefix: Equatable {}

// MARK: - RawRepresentable

extension ExtendedScaleUnitPrefix: RawRepresentable {}

// MARK: - UnitPrefix

extension ExtendedScaleUnitPrefix: UnitPrefix {}
