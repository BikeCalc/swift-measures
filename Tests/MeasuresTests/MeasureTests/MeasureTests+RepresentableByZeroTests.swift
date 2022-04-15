// MeasureTests+RepresentableByZeroTests.swift
// MeasuresTests
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

extension MeasureTests {
	func test_isZeroReturnsFalse() {
		// Given
		let value: TestSubject = .init(1, .base)
		
		// When
		let result: Bool = value.isZero
		
		// Then
		XCTAssertFalse(result)
	}
	
	func test_isZeroReturnsTrue() {
		// Given
		let value: TestSubject = .zero
		
		// When
		let result: Bool = value.isZero
		
		// Then
		XCTAssertTrue(result)
	}
	
	func test_additionReturnsZero() {
		// Given
		let augend: TestSubject = .zero
		let addend: TestSubject = .zero
		
		// When
		let sum: TestSubject = augend + addend

		// Then
		XCTAssertEqual(sum, .zero)
	}
	
	func test_subtractionReturnsZero() {
		// Given
		let minuend: TestSubject = .zero
		let subtrahend: TestSubject = .zero
		
		// When
		let difference: TestSubject = minuend - subtrahend

		// Then
		XCTAssertEqual(difference, .zero)
	}
}
