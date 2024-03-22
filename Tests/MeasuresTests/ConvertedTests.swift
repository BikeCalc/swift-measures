//
// ConvertedTests.swift
// MeasuresTests
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

internal final class ConvertedTests: XCTestCase {
    internal func test_converted_succeeds() {
		// Given
		@Converted(to: .meter)
		var measure: Measure<Length> = .init(100, .centimeter)
		
		// When
		measure = .init(1000, .millimeter)
		
		// Then
		XCTAssertEqual(measure, .init(1, .meter))
		XCTAssertEqual(measure.description, "1.0 m")
		
		// When
		measure = .init(0.001, .kilometer)
		
		// Then
		XCTAssertEqual(measure, .init(1, .meter))
		XCTAssertEqual(measure.description, "1.0 m")
	}
}
