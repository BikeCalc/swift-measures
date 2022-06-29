// MeasureTests+AddableTests.swift
// MeasuresTests
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

extension MeasureTests {
	func test_additionSucceeds() {
		// Given
		let augend: TestSubject = .init(2, .base)
		let addend: TestSubject = .init(4, .base)
		
		// When
		let sum: TestSubject = augend + addend

		// Then
		XCTAssertEqual(sum, .init(6, .base))
	}
	
	func test_additionEqualSucceeds() {
		// Given
		var sum: TestSubject = .init(2, .base)
		let addend: TestSubject = .init(4, .base)
		
		// When
		sum += addend

		// Then
		XCTAssertEqual(sum, .init(6, .base))
	}
	
	func test_addingSucceeds() {
		// Given
		let augend: TestSubject = .init(2, .base)
		let addend: TestSubject = .init(4, .base)
		
		// When
		let sum: TestSubject = augend.adding(addend)

		// Then
		XCTAssertEqual(sum, .init(6, .base))
	}
	
	func test_addSucceeds() {
		// Given
		var sum: TestSubject = .init(2, .base)
		let addend: TestSubject = .init(4, .base)
		
		// When
		sum.add(addend)

		// Then
		XCTAssertEqual(sum, .init(6, .base))
	}
}
