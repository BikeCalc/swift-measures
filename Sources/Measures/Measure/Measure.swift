// Measure.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A representation of a measure.
public struct Measure<Unit>
where Unit: Equatable & Measurable {
	/// The unit.
	public typealias Unit = Unit
	
	// MARK: - Creating Instances
    
    /// Creates a new instance with the specified value and unit.
    ///
    /// - parameter value: The value.
	/// - parameter unit: The unit.
	/// - warning: A measure can not be negative.
	public init(_ value: Double = 1, _ unit: Unit) {
		precondition(value.isNegative == false)
		
        self.value = value
        self.unit = unit
    }
	
	// MARK: - Instance Properties
	
	/// The value of this measure.
	public let value: Double
	
	/// The unit of this measure.
	public let unit: Unit
	
	// MARK: - Converting Values
	
	/// The value of this unit in terms of the base unit of its dimension.
	private func valueConvertedToBase() -> Double {
		return self.value * self.unit.coefficient + self.unit.constant
	}
	
	/// Returns this measure converted to the specified unit.
	///
	/// ```swift
	/// let measure: Measure<Length> = .init(1, .metre).converted(to: .centimetre)
	/// print(measure)
	/// // Prints "100 cm"
	/// ```
	///
	/// - parameter rhs: The unit to convert to.
	/// - returns: The converted measure.
	public func converted(to rhs: Unit) -> Self {
		let newValue: Double = (self.valueConvertedToBase() - rhs.constant) / rhs.coefficient
		return .init(newValue, rhs)
	}
	
	/// Returns this measure converted to the specified unit.
	///
	/// ```swift
	/// let measure: Measure<Frequency> = .init(1, .hertz).converted(to: .second)
	/// print(measure)
	/// // Prints "1 s"
	/// ```
	///
	/// - parameter rhs: The unit to convert to.
	/// - returns: The converted measure.
	public func converted(to rhs: Time) -> Measure<Time>
	where Unit == Frequency {
		let newValue: Double = (self.valueConvertedToBase() - rhs.constant) / rhs.coefficient
		return .init(1 / newValue, rhs)
	}
	
	/// Converts this measure to the specified unit.
	///
	/// ```swift
	/// var measure: Measure<Length> = .init(1, .metre)
	/// measure.convert(to: .centimetre)
	/// print(measure)
	/// // Prints "100 cm"
	/// ```
	///
	/// - parameter rhs: The unit to convert to.
	public mutating func convert(to rhs: Unit) {
		self = self.converted(to: rhs)
	}
}
