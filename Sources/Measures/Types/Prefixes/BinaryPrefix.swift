//
// BinaryPrefix.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A representation of a binary prefix.
@frozen
public enum BinaryPrefix: String {
    /// A prefix that multiplies the base unit by 1024⁹.
    case yobi
    
    /// A prefix that multiplies the base unit by 1024⁸.
    case zebi
    
    /// A prefix that multiplies the base unit by 1024⁷.
    case exbi
    
    /// A prefix that multiplies the base unit by 1024⁶.
    case pebi
    
    /// A prefix that multiplies the base unit by 1024⁵.
    case tebi
    
    /// A prefix that multiplies the base unit by 1024⁴.
    case gibi
    
    /// A prefix that multiplies the base unit by 1024³.
    case mebi
    
    /// A prefix that multiplies the base unit by 1024².
    case kibi
    
    /// A prefix that does not modify the base unit.
    case none = ""
    
	/// The coefficient of this instance compared to its base unit.
	public var coefficient: Double {
		switch self {
		case .yobi:
			return 1024.raising(to: 8)
		case .zebi:
			return 1024.raising(to: 7)
		case .exbi:
			return 1024.raising(to: 6)
		case .pebi:
			return 1024.raising(to: 5)
		case .tebi:
			return 1024.raising(to: 4)
		case .gibi:
			return 1024.raising(to: 3)
		case .mebi:
			return 1024.raising(to: 2)
		case .kibi:
			return 1024
		case .none:
			return 1
		}
	}
	
	/// The constant of this instance compared to its base unit.
	public var constant: Double {
		return 0
	}
	
	/// The symbol of this instance.
	public var symbol: String {
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

// MARK: - Comparable

extension BinaryPrefix: Comparable {
    public static func < (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.coefficient < rhs.coefficient
    }
}

// MARK: - Equatable

extension BinaryPrefix: Equatable {
    public static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

// MARK: - RawRepresentable

extension BinaryPrefix: RawRepresentable {
    public typealias RawValue = String
}
