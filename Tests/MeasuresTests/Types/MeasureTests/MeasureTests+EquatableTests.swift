// MeasureTests+EquatableTests.swift
// MeasuresTests
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

extension MeasureTests {
	func test_isEqualToReturnsFalse() {
		// Given
		let lhs: TestSubject = .init(1, .second)
		let rhs: TestSubject = .init(2, .second)
		
		// When
		let result: Bool = lhs.isEqual(to: rhs)
		
		// Then
		XCTAssertFalse(result)
	}
	
	func test_isEqualToReturnsTrue() {
		// Given
		let lhs: TestSubject = .init(1, .second)
		let rhs: TestSubject = .init(1, .second)
		
		// When
		let result: Bool = lhs.isEqual(to: rhs)
		
		// Then
		XCTAssertTrue(result)
	}
	
	func test_isUnequalToReturnsFalse() {
		// Given
		let lhs: TestSubject = .init(1, .second)
		let rhs: TestSubject = .init(1, .second)
		
		// When
		let result: Bool = lhs.isUnequal(to: rhs)
		
		// Then
		XCTAssertFalse(result)
	}
	
	func test_isUnequalToReturnsTrue() {
		// Given
		let lhs: TestSubject = .init(1, .second)
		let rhs: TestSubject = .init(2, .second)
		
		// When
		let result: Bool = lhs.isUnequal(to: rhs)
		
		// Then
		XCTAssertTrue(result)
	}
}
