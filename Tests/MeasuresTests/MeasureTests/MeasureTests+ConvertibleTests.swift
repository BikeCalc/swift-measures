// MeasureTests+ConvertibleTests.swift
// MeasuresTests
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

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
		
		static let base: Self = .kilometresPerLitre
		
		static let kilometresPerLitre: Self = .init(
			coefficient: Length.kilometre.coefficient / Volume.litre.coefficient,
			symbol: "Km/L",
			name: "kilometres per litre"
		)
		
		static let metresPerLitre: Self = .init(
			coefficient: Length.metre.coefficient / Volume.litre.coefficient,
			symbol: "m/L",
			name: "metres per litre"
		)
	}
	
	func test_convertToSucceeds() {
		// Given
		var measure: Measure<FuelEfficiency> = .init(5, .kilometresPerLitre)
		
		// When
		measure.convert(to: .metresPerLitre)
		
		// Then
		XCTAssertEqual(measure.description, "5000.0 m/L")
		
		// When
		measure.convert(to: .kilometresPerLitre)
		
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
