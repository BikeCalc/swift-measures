// MeasureTests+JSONEncodableTests.swift
// MeasuresTests
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

#if canImport(Foundation)

import Foundation

extension MeasureTests {
	func test_encodeToJSONSucceeds() throws {
		// Given
		let value: TestSubject = .init(1, .second)
		
		// When
		let encoder: JSONEncoder = .init()
		let result: Data? = try encoder.encode(value)
		
		// Then
		let bundle: Bundle = .module
		let url: URL? = bundle.url(forResource: "Measure", withExtension: "json")
		let data: Data? = try .init(contentsOf: XCTUnwrap(url))
		let json: Any? = try JSONSerialization.jsonObject(with: XCTUnwrap(data))
		let jsonData: Data? = try JSONSerialization.data(withJSONObject: XCTUnwrap(json))
		
		XCTAssertEqual(result, jsonData)
	}
}

#endif
