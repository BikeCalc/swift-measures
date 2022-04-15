// MeasureTests.swift
// MeasuresTests
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

final class MeasureTests: XCTestCase {
	typealias TestSubject = Measure<Time>
}

extension MeasureTests {
	struct FuelEfficiency: Measurable {
		init(
			coefficient: Double,
			constant: Double = 0,
			symbol: String,
			name: String
		) {
			self.coefficient = coefficient
			self.constant = constant
			self.symbol = symbol
			self.name = name
		}
		
		let constant: Double
		let coefficient: Double
		let symbol: String
		let name: String
		
		static let base: Self = .kilometrePerLitre
		
		static let kilometrePerLitre: Self = .init(
			coefficient: Length.kilometre.coefficient / Volume.litre.coefficient,
			symbol: "Km/L",
			name: "kilometre per litre"
		)
		
		static let metrePerLitre: Self = .init(
			coefficient: Length.metre.coefficient / Volume.litre.coefficient,
			symbol: "m/L",
			name: "metre per litre"
		)
	}
	
	func test_convertToSucceeds() {
		// Given
		var measure: Measure<FuelEfficiency> = .init(5, .kilometrePerLitre)
		
		// When
		measure.convert(to: .metrePerLitre)
		
		// Then
		XCTAssertEqual(measure.description, "5000.0 m/L")
		
		// When
		measure.convert(to: .kilometrePerLitre)
		
		// Then
		XCTAssertEqual(measure.description, "5.0 Km/L")
	}
}

extension MeasureTests {
	func test_convertThermodynamicTemperatureSucceeds() {
		// Given
		var measure: Measure<ThermodynamicTemperature> = .init(5, .kilokelvin)
		
		// When
		measure.convert(to: .celsius)
		
		// Then
		XCTAssertEqual(measure.description, "4726.85 °C")
		
		// When
		measure.convert(to: .kilokelvin)
		
		// Then
		XCTAssertEqual(measure.description, "5.0 kK")
	}
}
