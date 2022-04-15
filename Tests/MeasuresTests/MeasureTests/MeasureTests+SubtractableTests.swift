// MeasureTests+SubtractableTests.swift
// MeasuresTests
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

extension MeasureTests {
	func test_subtractionSucceeds() {
		// Given
		let minuend: Measure<Time> = .init(6, .second)
		let subtrahend: Measure<Time> = .init(4, .second)
		
		// When
		let difference: Measure<Time> = minuend - subtrahend

		// Then
		XCTAssertEqual(difference, .init(2, .second))
	}
	
	func test_subtractionEqualSucceeds() {
		// Given
		var difference: Measure<Time> = .init(6, .second)
		let subtrahend: Measure<Time> = .init(4, .second)
		
		// When
		difference -= subtrahend

		// Then
		XCTAssertEqual(difference, .init(2, .second))
	}
	
	func test_subtractingSucceeds() {
		// Given
		let minuend: Measure<Time> = .init(6, .second)
		let subtrahend: Measure<Time> = .init(4, .second)
		
		// When
		let difference: Measure<Time> = minuend.subtracting(subtrahend)

		// Then
		XCTAssertEqual(difference, .init(2, .second))
	}
	
	func test_subtractSucceeds() {
		// Given
		var difference: Measure<Time> = .init(6, .second)
		let subtrahend: Measure<Time> = .init(4, .second)
		
		// When
		difference.subtract(subtrahend)

		// Then
		XCTAssertEqual(difference, .init(2, .second))
	}
}
