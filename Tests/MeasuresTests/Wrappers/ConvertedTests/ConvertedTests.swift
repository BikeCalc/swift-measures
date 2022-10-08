// ConvertedTests.swift
// MeasuresTests
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

final class ConvertedTests: XCTestCase {
	func test_converted_succeeds() {
		// Given
		@Converted(to: .metre)
		var measure: Measure<Length> = .init(100, .centimetre)
		
		// When
		measure = .init(1000, .millimetre)
		
		// Then
		XCTAssertEqual(measure, .init(1, .metre))
		XCTAssertEqual(measure.description, "1.0 m")
		
		// When
		measure = .init(0.001, .kilometre)
		
		// Then
		XCTAssertEqual(measure, .init(1, .metre))
		XCTAssertEqual(measure.description, "1.0 m")
	}
}
