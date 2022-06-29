// MeasureTests+EquivalentableTests.swift
// MeasuresTests
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

extension MeasureTests {
	func test_isEquivalentToReturnsFalse() {
		// Given
		let lhs: TestSubject = .init(1, .minute)
		let rhs: TestSubject = .init(1, .second)
		
		// When
		let result: Bool = lhs.isEquivalent(to: rhs)
		
		// Then
		XCTAssertFalse(result)
	}
	
	func test_isEquivalentToReturnsTrue() {
		// Given
		let lhs: TestSubject = .init(1, .minute)
		let rhs: TestSubject = .init(60, .second)
		
		// When
		let result: Bool = lhs.isEquivalent(to: rhs)
		
		// Then
		XCTAssertTrue(result)
	}
}
