//
// Measure.swift
// Measures
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import NumericProtocols

/// A representation of a measure.
public struct Measure<Unit>
where Unit: Equatable & Measurable {
	/// The unit.
	public typealias Unit = Unit
    
    /// The value of this measure.
    public let value: Double
    
    /// The unit of this measure.
    public let unit: Unit
	
	/// Creates a new instance with the specified value and unit.
	///
	/// - parameter value: The value.
	/// - parameter unit: The unit.
	/// - warning: A measure can not be negative.
	public init<Value>(_ value: Value, _ unit: Unit)
	where Value: BinaryFloatingPoint {
        self.value = .init(max(.zero, value))
		self.unit = unit
	}
	
	/// Creates a new instance with the specified value and unit.
	///
	/// - parameter value: The value.
	/// - parameter unit: The unit.
	/// - warning: A measure can not be negative.
	public init<Value>(_ value: Value, _ unit: Unit)
	where Value: BinaryInteger {
        self.value = .init(max(.zero, value))
		self.unit = unit
	}
}

// MARK: - Addable

extension Measure: Addable {
    public static func + (_ lhs: Self, _ rhs: Self) -> Self {
        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value
        let newValue: Double = lhsValue + rhsValue
        
        return .init(newValue, lhs.unit)
    }
}

// MARK: - Comparable

extension Measure: Comparable {
    public static func < (_ lhs: Self, _ rhs: Self) -> Bool {
        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value
        
        return lhsValue < rhsValue
    }
}

// MARK: - Convertible

extension Measure: Convertible {
    /// The value of this unit in terms of the base unit of its dimension.
    private func convertedToBase() -> Self {
        let newValue: Double = self.value * self.unit.coefficient + self.unit.constant
        return .init(newValue, .base)
    }
    
    /// Returns this measure converted to the specified unit.
    ///
    /// ```swift
    /// let measure: Measure<Length> = .init(1, .meter).converted(to: .centimeter)
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
    /// var measure: Measure<Length> = .init(1, .meter)
    /// measure.convert(to: .centimeter)
    /// print(measure)
    /// // Prints "100cm"
    /// ```
    ///
    /// - parameter rhs: The unit to convert to.
    public mutating func convert(to rhs: Unit) {
        self = self.converted(to: rhs)
    }
}

// MARK: - CustomStringConvertible

extension Measure: CustomStringConvertible {
    /// A textual representation of this instance.
    ///
    /// ```swift
    /// let measure: Measure<Length> = .init(1, .meter)
    /// print(measure)
    /// // Prints "1 m"
    /// ```
    public var description: String {
        return self.value.description + " " + self.unit.symbol
    }
}

// MARK: - Decodable

extension Measure: Decodable
where Unit: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MeasureCodingKeys.self)
        
        let value: Double = try container.decode(Double.self, forKey: .value)
        let unit: Unit = try container.decode(Unit.self, forKey: .unit)
        
        self.init(value, unit)
    }
}

// MARK: - Divisible

extension Measure {
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
    public static func /= (_ lhs: inout Self, _ rhs: Double) {
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

// MARK: - Encodable

extension Measure: Encodable
where Unit: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MeasureCodingKeys.self)
        
        try container.encode(self.value, forKey: .value)
        try container.encode(self.unit, forKey: .unit)
    }
}

// MARK: - Equatable

extension Measure: Equatable
where Unit: Equatable {
    public static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.value == rhs.value
            && lhs.unit == rhs.unit
    }
}

// MARK: - Equivalentable

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

// MARK: - Hashable

extension Measure: Hashable
where Unit: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
        hasher.combine(self.unit)
    }
}

// MARK: - Multipliable

extension Measure {
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
    public static func *= (_ lhs: inout Self, _ rhs: Double) {
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

// MARK: - Subtractable

extension Measure: Subtractable {
    public static func - (_ lhs: Self, _ rhs: Self) -> Self {
        let lhsValue: Double = lhs.value
        let rhsValue: Double = rhs.converted(to: lhs.unit).value
        let newValue: Double = lhsValue - rhsValue
        
        return .init(newValue, lhs.unit)
    }
}
