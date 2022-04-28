// Measure+Multipliable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure {
	
	// MARK: - Multiplying Values
	
	/// Returns the product of multiplying the two specified values.
	///
	/// - parameter lhs: The multiplicand.
	/// - parameter rhs: The multiplicator.
	/// - returns: The product.
	public static func * (_ lhs: Self, _ rhs: Double) -> Self {
		let lhsValue: Double = lhs.value
		let newValue: Double = lhsValue * rhs
		
		return .init(newValue, lhs.unit)
	}
	
	/// Returns the product of multiplying the two specified values.
	///
	/// - parameter lhs: The multiplicand.
	/// - parameter rhs: The multiplicator.
	/// - returns: The product.
	public static func * (_ lhs: Double, _ rhs: Self) -> Self {
		let rhsValue: Double = rhs.value
		let newValue: Double = lhs * rhsValue
		
		return .init(newValue, rhs.unit)
	}
	
	/// Multiplies the two specified values and stores the product in the left-hand-side variable.
	///
	/// - parameter lhs: The multiplicand.
	/// - parameter rhs: The multiplicator.
	public static func *= (lhs: inout Self, rhs: Double) {
		lhs = lhs * rhs
	}
	
	/// Returns the product of multiplying this value by the specified value.
	///
	/// - parameter multiplicator: The multiplicator.
	/// - returns: The product.
	public func multiplying(by multiplicator: Double) -> Self {
		return self * multiplicator
	}
	
	/// Multiplies this value by the specified value and produces the product.
	///
	/// - parameter multiplicator: The multiplicator.
	public mutating func multiply(by multiplicator: Double) {
		self *= multiplicator
	}
	
	// MARK: - Doubling Values
	
	/// Returns this value doubled.
	///
	///  - returns: The value doubled.
	public func doubled() -> Self {
		return self * 2
	}
	
	/// Doubles this value.
	public mutating func double() {
		self = self.doubled()
	}
}
