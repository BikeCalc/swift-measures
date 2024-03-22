//
// Converted.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

/// A property wrapper that keeps a measure converted to a specified unit.
///
/// ```swift
/// @Converted(to: .meter)
/// var measure: Measure<Length> = .init(100, .centimeter)
/// print(measure)
/// // Prints "1m"
/// ```
@propertyWrapper
public struct Converted<Unit>
where Unit: Equatable & Measurable {
    /// The measure converted to the unit.
    private var value: Measure<Unit>
    
    /// The unit.
    private let unit: Measure<Unit>.Unit
    
	/// Creates a new instance from the given measure and specified unit.
	///
	/// - parameter measure: The measure to convert.
	/// - parameter unit: The unit.
	public init(wrappedValue value: Measure<Unit>, to unit: Measure<Unit>.Unit) {
		self.value = value
		self.unit = unit
		self.wrappedValue = value
	}

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
