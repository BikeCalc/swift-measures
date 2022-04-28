// Measure+Divisible.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure {
	
	// MARK: - Dividing Values
	
	/// Returns the quotient of dividing the first specified value by the second.
	///
	/// - parameter lhs: The dividend.
	/// - parameter rhs: The divisor.
	/// - returns: The quotient.
	public static func / (_ lhs: Self, _ rhs: Double) -> Self {
		let lhsValue: Double = lhs.value
		let newValue: Double = lhsValue / rhs
		
		return .init(newValue, lhs.unit)
	}
	
	/// Returns the quotient of dividing the first specified value by the second.
	///
	/// - parameter lhs: The dividend.
	/// - parameter rhs: The divisor.
	/// - returns: The quotient.
	public static func / (_ lhs: Double, _ rhs: Self) -> Self {
		let rhsValue: Double = rhs.value
		let newValue: Double = lhs / rhsValue
		
		return .init(newValue, rhs.unit)
	}
	
	/// Divides the first specified value by the second and stores the quotient in the left-hand-side variable.
	///
	/// - parameter lhs: The dividend.
	/// - parameter rhs: The divisor.
	public static func /= (lhs: inout Self, rhs: Double) {
		lhs = lhs / rhs
	}
	
	/// Returns the quotient of dividing this value by the specified value.
	///
	/// - parameter divisor: The divisor.
	/// - returns: The quotient.
	public func dividing(by divisor: Double) -> Self {
		return self / divisor
	}
	
	/// Divides this value by the specified value and produces the quotient.
	///
	/// - parameter divisor: The divisor.
	public mutating func divide(by divisor: Double) {
		self /= divisor
	}
	
	// MARK: - Halving Values
	
	/// Returns this value halved.
	///
	/// - returns: The value halved.
	public func halved() -> Self {
		return self / 2
	}
	
	/// Halves this value.
	///
	public mutating func halve() {
		self = self.halved()
	}
}
