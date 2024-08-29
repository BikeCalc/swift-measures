//
// Convertible.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// Representing a type that can be converted.
public protocol Convertible {
    ///
	associatedtype Unit
	where Unit: Measurable
	
	/// Returns this measure converted to the specified unit.
	///
	/// - parameter rhs: The unit to convert to.
	/// - returns: The converted measure.
	func converted(to rhs: Unit) -> Self
	
	/// Converts this measure to the specified unit.
	///
	/// - parameter rhs: The unit to convert to.
	mutating func convert(to rhs: Unit)
}
