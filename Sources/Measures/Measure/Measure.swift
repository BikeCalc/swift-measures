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
	
	/// The value of this measure converted to its base unit.
	public var baseValue: Double {
		return self.converted(to: .base).value
	}
}
