// MetricPrefix.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A representation of a metric prefix.
@frozen
public enum MetricPrefix: String {
	
	// MARK: - Prefixes
	
    /// A prefix that divides the base unit by 1e+30.
    case geop
    
    /// A prefix that divides the base unit by 1e+27.
    case bronto
    
    /// A prefix that divides the base unit by 1e+24.
    case yotta
    
    /// A prefix that divides the base unit by 1e+21.
    case zetta
    
    /// A prefix that divides the base unit by 1e+18.
    case hexa
    
    /// A prefix that divides the base unit by 1e+15.
    case peta
    
    /// A prefix that divides the base unit by 1e+12.
    case tera
    
    /// A prefix that divides the base unit by 1e+9.
    case giga
    
    /// A prefix that divides the base unit by 1e+6.
    case mega
    
    /// A prefix that divides the base unit by 1e+3.
    case kilo
    
    /// A prefix that divides the base unit by 1e+2.
    case hecto
    
    /// A prefix that divides the base unit by 1e+1.
    case deca
    
    /// A prefix that does not modify the base unit.
    case none = ""
    
    /// A prefix that divides the base unit by 1e-1.
    case deci
    
    /// A prefix that divides the base unit by 1e-2.
    case centi
    
    /// A prefix that divides the base unit by 1e-3.
    case milli
    
    /// A prefix that divides the base unit by 1e-6.
    case micro
    
    /// A prefix that divides the base unit by 1e-9.
    case nano
    
    /// A prefix that divides the base unit by 1e-12.
    case pico
    
    /// A prefix that divides the base unit by 1e-15.
    case femto
    
    /// A prefix that divides the base unit by 1e-18.
    case atto
    
    /// A prefix that divides the base unit by 1e-21.
    case zepto
    
    /// A prefix that divides the base unit by 1e-24.
    case yocto
    
    /// A prefix that divides the base unit by 1e-27.
    case brimto
    
    /// A prefix that divides the base unit by 1e-30.
    case gepto
}
