// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import NumericsExtended

/// A representation of a binary unit prefix.
@frozen
package enum BinaryUnitPrefix: String {
    /// A prefix that multiplies a unit by 1024⁸.
    case yobi

    /// A prefix that multiplies a unit by 1024⁷.
    case zebi

    /// A prefix that multiplies a unit by 1024⁶.
    case exbi

    /// A prefix that multiplies a unit by 1024⁵.
    case pebi

    /// A prefix that multiplies a unit by 1024⁴.
    case tebi

    /// A prefix that multiplies a unit by 1024³.
    case gibi

    /// A prefix that multiplies a unit by 1024².
    case mebi

    /// A prefix that multiplies a unit by 1024¹.
    case kibi

    /// A prefix that leaves a unit unchanged.
    case none = ""

    /// The multiplier represented by this prefix.
    package var coefficient: Double {
        switch self {
        case .yobi:
            return 1_024 ** 8
        case .zebi:
            return 1_024 ** 7
        case .exbi:
            return 1_024 ** 6
        case .pebi:
            return 1_024 ** 5
        case .tebi:
            return 1_024 ** 4
        case .gibi:
            return 1_024 ** 3
        case .mebi:
            return 1_024 ** 2
        case .kibi:
            return 1_024
        case .none:
            return 1
        }
    }

    /// The symbol of this instance.
    package var symbol: String {
        switch self {
        case .yobi:
            return "Yi"
        case .zebi:
            return "Zi"
        case .exbi:
            return "Ei"
        case .pebi:
            return "Pi"
        case .tebi:
            return "Ti"
        case .gibi:
            return "Gi"
        case .mebi:
            return "Mi"
        case .kibi:
            return "Ki"
        case .none:
            return ""
        }
    }
}

// MARK: - RawRepresentable

extension BinaryUnitPrefix: CaseIterable {}

// MARK: - Comparable

extension BinaryUnitPrefix: Comparable {
    package static func < (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.coefficient < rhs.coefficient
    }
}

// MARK: - Equatable

extension BinaryUnitPrefix: Equatable {
    package static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

// MARK: - RawRepresentable

extension BinaryUnitPrefix: RawRepresentable {
    package typealias RawValue = String
}

// MARK: - UnitPrefix

extension BinaryUnitPrefix: UnitPrefix {}
