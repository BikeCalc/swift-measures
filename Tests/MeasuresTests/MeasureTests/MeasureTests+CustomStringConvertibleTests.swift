// MeasureTests+CustomStringConvertibleTests.swift
// MeasuresTests
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

extension MeasureTests {
	func test_descriptionSucceeds() {
		// Given
		let value: TestSubject = .init(4, .base)
		
		// When
		let description: String = value.description
		
		// Then
		XCTAssertEqual(description, "4.0 s")
	}
}
