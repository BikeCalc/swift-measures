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
		
		static let base: Self = .kilometersPerLitre
		
		static let kilometersPerLitre: Self = .init(
			coefficient: Length.kilometer.coefficient / Volume.litre.coefficient,
			symbol: "Km/L"
		)
		
		static let metersPerLitre: Self = .init(
			coefficient: Length.meter.coefficient / Volume.litre.coefficient,
			symbol: "m/L"
		)
	}
	
	func test_convertFuelEfficiencySucceeds() {
		// Given
		var measure: Measure<FuelEfficiency> = .init(5, .kilometersPerLitre)
		
		// When
		measure.convert(to: .metersPerLitre)
		
		// Then
		XCTAssertEqual(measure.description, "5000.0 m/L")
		
		// When
		measure.convert(to: .kilometersPerLitre)
		
		// Then
		XCTAssertEqual(measure.description, "5.0 Km/L")
	}
}

extension MeasureTests {
	func test_convertSpeedSucceeds() {
		// Given
		var measure: Measure<Speed> = .init(5, .kilometersPerHour)
		
		// When
		measure.convert(to: .metersPerSecond)
		
		// Then
		XCTAssertEqual(measure.description, "1.3888888888888888 m/s")
		
		// When
		measure.convert(to: .kilometersPerHour)
		
		// Then
		XCTAssertEqual(measure.description, "5.0 km/h")
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
