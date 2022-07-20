// Measure+Convertible.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure: Convertible {
	
	// MARK: - Converting Values
	
	/// The value of this unit in terms of the base unit of its dimension.
	private func convertedToBase() -> Self {
		let newValue: Double = self.value * self.unit.coefficient + self.unit.constant
		return .init(newValue, .base)
	}
	
	/// Returns this measure converted to the specified unit.
	///
	/// ```swift
	/// let measure: Measure<Length> = .init(1, .metre).converted(to: .centimetre)
	/// print(measure)
	/// // Prints "100cm"
	/// ```
	///
	/// - parameter rhs: The unit to convert to.
	/// - returns: The converted measure.
	public func converted(to rhs: Unit) -> Self {
		let newValue: Double = (self.convertedToBase().value - rhs.constant) / rhs.coefficient
		return .init(newValue, rhs)
	}
	
	/// Returns this measure converted to the specified unit.
	///
	/// ```swift
	/// let measure: Measure<Frequency> = .init(1, .hertz).converted(to: .second)
	/// print(measure)
	/// // Prints "1s"
	/// ```
	///
	/// - parameter rhs: The unit to convert to.
	/// - returns: The converted measure.
	public func converted(to rhs: Time) -> Measure<Time>
	where Unit == Frequency {
		let newValue: Double = (self.convertedToBase().value - rhs.constant) / rhs.coefficient
		return .init(1 / newValue, rhs)
	}
	
	/// Converts this measure to the specified unit.
	///
	/// ```swift
	/// var measure: Measure<Length> = .init(1, .metre)
	/// measure.convert(to: .centimetre)
	/// print(measure)
	/// // Prints "100cm"
	/// ```
	///
	/// - parameter rhs: The unit to convert to.
	public mutating func convert(to rhs: Unit) {
		self = self.converted(to: rhs)
	}
}
