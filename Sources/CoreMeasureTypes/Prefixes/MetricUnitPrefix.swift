// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A representation of a metric unit prefix.
@frozen
package enum MetricUnitPrefix: String {
    /// A prefix that multiplies a unit by 1e+30.
    case quetta

    /// A prefix that multiplies a unit by 1e+27.
    case ronna

    /// A prefix that multiplies a unit by 1e+24.
    case yotta

    /// A prefix that multiplies a unit by 1e+21.
    case zetta

    /// A prefix that multiplies a unit by 1e+18.
    case exa

    /// A prefix that multiplies a unit by 1e+15.
    case peta

    /// A prefix that multiplies a unit by 1e+12.
    case tera

    /// A prefix that multiplies a unit by 1e+9.
    case giga

    /// A prefix that multiplies a unit by 1e+6.
    case mega

    /// A prefix that multiplies a unit by 1e+3.
    case kilo

    /// A prefix that multiplies a unit by 1e+2.
    case hecto

    /// A prefix that multiplies a unit by 1e+1.
    case deca

    /// A prefix that leaves a unit unchanged.
    case none = ""

    /// A prefix that multiplies a unit by 1e-1.
    case deci

    /// A prefix that multiplies a unit by 1e-2.
    case centi

    /// A prefix that multiplies a unit by 1e-3.
    case milli

    /// A prefix that multiplies a unit by 1e-6.
    case micro

    /// A prefix that multiplies a unit by 1e-9.
    case nano

    /// A prefix that multiplies a unit by 1e-12.
    case pico

    /// A prefix that multiplies a unit by 1e-15.
    case femto

    /// A prefix that multiplies a unit by 1e-18.
    case atto

    /// A prefix that multiplies a unit by 1e-21.
    case zepto

    /// A prefix that multiplies a unit by 1e-24.
    case yocto

    /// A prefix that multiplies a unit by 1e-27.
    case ronto

    /// A prefix that multiplies a unit by 1e-30.
    case quecto
}

extension MetricUnitPrefix {
    /// The multiplier represented by this prefix.
    package var coefficient: Double {
        switch self {
        case .quetta:
            return 1e30
        case .ronna:
            return 1e27
        case .yotta:
            return 1e24
        case .zetta:
            return 1e21
        case .exa:
            return 1e18
        case .peta:
            return 1e15
        case .tera:
            return 1e12
        case .giga:
            return 1e9
        case .mega:
            return 1e6
        case .kilo:
            return 1e3
        case .hecto:
            return 1e2
        case .deca:
            return 1e1
        case .none:
            return 1
        case .deci:
            return 1e-1
        case .centi:
            return 1e-2
        case .milli:
            return 1e-3
        case .micro:
            return 1e-6
        case .nano:
            return 1e-9
        case .pico:
            return 1e-12
        case .femto:
            return 1e-15
        case .atto:
            return 1e-18
        case .zepto:
            return 1e-21
        case .yocto:
            return 1e-24
        case .ronto:
            return 1e-27
        case .quecto:
            return 1e-30
        }
    }

    /// The symbol of this instance.
    package var symbol: String {
        switch self {
        case .quetta:
            return "Q"
        case .ronna:
            return "R"
        case .yotta:
            return "Y"
        case .zetta:
            return "Z"
        case .exa:
            return "E"
        case .peta:
            return "P"
        case .tera:
            return "T"
        case .giga:
            return "G"
        case .mega:
            return "M"
        case .kilo:
            return "k"
        case .hecto:
            return "h"
        case .deca:
            return "da"
        case .none:
            return ""
        case .deci:
            return "d"
        case .centi:
            return "c"
        case .milli:
            return "m"
        case .micro:
            return "µ"
        case .nano:
            return "n"
        case .pico:
            return "p"
        case .femto:
            return "f"
        case .atto:
            return "a"
        case .zepto:
            return "z"
        case .yocto:
            return "y"
        case .ronto:
            return "r"
        case .quecto:
            return "q"
        }
    }
}

// MARK: - RawRepresentable

extension MetricUnitPrefix: CaseIterable {}

// MARK: - Comparable

extension MetricUnitPrefix: Comparable {
    package static func < (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.coefficient < rhs.coefficient
    }
}

// MARK: - Equatable

extension MetricUnitPrefix: Equatable {
    package static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

// MARK: - RawRepresentable

extension MetricUnitPrefix: RawRepresentable {
    package typealias RawValue = String
}

// MARK: - UnitPrefix

extension MetricUnitPrefix: UnitPrefix {}
