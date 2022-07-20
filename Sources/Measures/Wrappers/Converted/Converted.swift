// Converted.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A property wrapper that keeps a measure converted to a specified unit.
///
/// ```swift
/// @Converted(to: .metre)
/// var measure: Measure<Length> = .init(100, .centimetre)
/// print(measure)
/// // Prints "1m"
/// ```
@propertyWrapper
public struct Converted<Unit>
where Unit: Equatable & Measurable {
	
	// MARK: - Creating Instances
	
	/// Creates a new instance from the given measure and specified unit.
	///
	/// - parameter measure: The measure to convert.
	/// - parameter unit: The unit.
	public init(wrappedValue value: Measure<Unit>, to unit: Measure<Unit>.Unit) {
		self.value = value
		self.unit = unit
		self.wrappedValue = value
	}
	
	// MARK: - Instance Properties
	
	/// The measure converted to the unit.
	private var value: Measure<Unit>
	
	/// The unit.
	private let unit: Measure<Unit>.Unit

	/// The wrapped value of this property wrapper.
	public var wrappedValue: Measure<Unit> {
		get {
			return self.value
		} set (newValue) {
			self.value = newValue
			self.value.convert(to: self.unit)
		}
	}
}
