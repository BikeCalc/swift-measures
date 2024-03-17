// Measure+Equivalentable.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure: Equivalentable {
	/// Returns a boolean value indicating whether the two specified instances are equivalent.
	///
	/// ```swift
	/// let oneMeter: Measure<Length> = .init(1, .meter)
	/// let oneHundredCentimeters: Measure<Length> = .init(100, .centimeter)
	/// print(oneMeter.isEquivalent(to: oneHundredCentimeters))
	/// // Prints "true"
	/// ```
	///
	/// - parameter rhs: An instance to compare.
	/// - returns: `true` if is equivalent, and `false` otherwise.
	public func isEquivalent(to rhs: Self) -> Bool {
		let lhsValue: Double = self.value
		let rhsValue: Double = rhs.converted(to: self.unit).value
		
		return lhsValue == rhsValue
	}
}
