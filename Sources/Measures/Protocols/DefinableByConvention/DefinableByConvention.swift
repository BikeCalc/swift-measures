// DefinableByConvention.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// Representing a type that can be defined by convention.
public protocol DefinableByConvention {
	
	// MARK: - Unit Properties
	
	/// The coefficient of this instance compared to its base unit.
	var coefficient: Double { get }
	
	/// The constant of this instance compared to its base unit.
	var constant: Double { get }
	
	/// The symbol of this instance.
	var symbol: String { get }
}
