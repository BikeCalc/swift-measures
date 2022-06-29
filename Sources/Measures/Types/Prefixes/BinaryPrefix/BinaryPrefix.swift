// BinaryPrefix.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A representation of a binary prefix.
@frozen
public enum BinaryPrefix: String {
	
	// MARK: - Prefixes
	
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
}
