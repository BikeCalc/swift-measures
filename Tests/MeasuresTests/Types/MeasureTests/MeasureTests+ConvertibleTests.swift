// MeasureTests+ConvertibleTests.swift
// MeasuresTests
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

import XCTest
@testable import Measures

extension MeasureTests {
	struct FuelEfficiency: Equatable, Measurable {
		init(
			coefficient: Double,
			constant: Double = 0,
			symbol: String
		) {
			self.coefficient = coefficient
			self.constant = constant
			self.symbol = symbol
		}
		
		let constant: Double
		let coefficient: Double
		let symbol: String
		
		static let base: Self = .kilometresPerLitre
		
		static let kilometresPerLitre: Self = .init(
			coefficient: Length.kilometre.coefficient / Volume.litre.coefficient,
			symbol: "Km/L"
		)
		
		static let metresPerLitre: Self = .init(
			coefficient: Length.metre.coefficient / Volume.litre.coefficient,
			symbol: "m/L"
		)
	}
	
	func test_convertFuelEfficiencySucceeds() {
		// Given
		var measure: Measure<FuelEfficiency> = .init(5, .kilometresPerLitre)
		
		// When
		measure.convert(to: .metresPerLitre)
		
		// Then
		XCTAssertEqual(measure.description, "5000.0m/L")
		
		// When
		measure.convert(to: .kilometresPerLitre)
		
		// Then
		XCTAssertEqual(measure.description, "5.0Km/L")
	}
}

extension MeasureTests {
	func test_convertSpeedSucceeds() {
		// Given
		var measure: Measure<Speed> = .init(5, .kilometresPerHour)
		
		// When
		measure.convert(to: .metresPerSecond)
		
		// Then
		XCTAssertEqual(measure.description, "1.3888888888888888m/s")
		
		// When
		measure.convert(to: .kilometresPerHour)
		
		// Then
		XCTAssertEqual(measure.description, "5.0km/h")
	}
}

extension MeasureTests {
	func test_convertThermodynamicTemperatureSucceeds() {
		// Given
		var measure: Measure<ThermodynamicTemperature> = .init(5, .kilokelvin)
		
		// When
		measure.convert(to: .celsius)
		
		// Then
		XCTAssertEqual(measure.description, "4726.85°C")
		
		// When
		measure.convert(to: .kilokelvin)
		
		// Then
		XCTAssertEqual(measure.description, "5.0kK")
	}
}
