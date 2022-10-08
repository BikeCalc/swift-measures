// Measure+CustomStringConvertible.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension Measure: CustomStringConvertible {
	/// A textual representation of this instance.
	///
	/// ```swift
	/// let measure: Measure<Length> = .init(1, .metre)
	/// print(measure)
	/// // Prints "1 m"
	/// ```
	public var description: String {
		return self.value.description + " " + self.unit.symbol
	}
}
