//
// MeasureTests.swift
// MeasuresTests
//
// Copyright © 2021-2024 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

#if canImport(Foundation)
import Foundation
#endif
import XCTest
@testable import Measures

internal final class MeasureTests: XCTestCase {
	typealias TestSubject = Measure<Time>
}

extension MeasureTests {
    internal func test_additionSucceeds() {
        // Given
        let augend: TestSubject = .init(2, .base)
        let addend: TestSubject = .init(4, .base)
        
        // When
        let sum: TestSubject = augend + addend

        // Then
        XCTAssertEqual(sum, .init(6, .base))
    }
    
    internal func test_additionEqualSucceeds() {
        // Given
        var sum: TestSubject = .init(2, .base)
        let addend: TestSubject = .init(4, .base)
        
        // When
        sum += addend

        // Then
        XCTAssertEqual(sum, .init(6, .base))
    }
    
    internal func test_addingSucceeds() {
        // Given
        let augend: TestSubject = .init(2, .base)
        let addend: TestSubject = .init(4, .base)
        
        // When
        let sum: TestSubject = augend.adding(addend)

        // Then
        XCTAssertEqual(sum, .init(6, .base))
    }
    
    internal func test_addSucceeds() {
        // Given
        var sum: TestSubject = .init(2, .base)
        let addend: TestSubject = .init(4, .base)
        
        // When
        sum.add(addend)

        // Then
        XCTAssertEqual(sum, .init(6, .base))
    }
}


extension MeasureTests {
    internal func test_isLessThanReturnsFalse() {
        // Given
        let lhs: TestSubject = .init(2, .base)
        let rhs: TestSubject = .init(1, .base)
        
        // When
        let result: Bool = lhs.isLess(than: rhs)
        
        // Then
        XCTAssertFalse(result)
    }
    
    internal func test_isLessThanReturnsTrue() {
        // Given
        let lhs: TestSubject = .init(1, .base)
        let rhs: TestSubject = .init(2, .base)
        
        // When
        let result: Bool = lhs.isLess(than: rhs)
        
        // Then
        XCTAssertTrue(result)
    }
    
    internal func test_isLessThanOrEqualToReturnsFalse() {
        // Given
        let lhs: TestSubject = .init(2, .base)
        let rhs: TestSubject = .init(1, .base)
        
        // When
        let result: Bool = lhs.isLessThanOrEqual(to: rhs)
        
        // Then
        XCTAssertFalse(result)
    }
    
    internal func test_isLessThanOrEqualToReturnsTrue() {
        // Given
        let lhs: TestSubject = .init(1, .base)
        let rhs: TestSubject = .init(1, .base)
        
        // When
        let result: Bool = lhs.isLessThanOrEqual(to: rhs)
        
        // Then
        XCTAssertTrue(result)
    }
    
    internal func test_isGreaterThanReturnsFalse() {
        // Given
        let lhs: TestSubject = .init(1, .base)
        let rhs: TestSubject = .init(2, .base)
        
        // When
        let result: Bool = lhs.isGreater(than: rhs)
        
        // Then
        XCTAssertFalse(result)
    }
    
    internal func test_isGreaterThanReturnsTrue() {
        // Given
        let lhs: TestSubject = .init(2, .base)
        let rhs: TestSubject = .init(1, .base)
        
        // When
        let result: Bool = lhs.isGreater(than: rhs)
        
        // Then
        XCTAssertTrue(result)
    }
    
    internal func test_isGreaterThanOrEqualToReturnsFalse() {
        // Given
        let lhs: TestSubject = .init(1, .base)
        let rhs: TestSubject = .init(2, .base)
        
        // When
        let result: Bool = lhs.isGreaterThanOrEqual(to: rhs)
        
        // Then
        XCTAssertFalse(result)
    }
    
    internal func test_isGreaterThanOrEqualToReturnsTrue() {
        // Given
        let lhs: TestSubject = .init(1, .base)
        let rhs: TestSubject = .init(1, .base)
        
        // When
        let result: Bool = lhs.isGreaterThanOrEqual(to: rhs)
        
        // Then
        XCTAssertTrue(result)
    }
    
    internal func test_isWithinClosedRangeReturnsFalse() {
        // Given
        let value: TestSubject = .init(4, .base)
        let lowerBound: TestSubject = .init(1, .base)
        let upperBound: TestSubject = .init(3, .base)
        let range: ClosedRange<TestSubject> = lowerBound...upperBound
        
        // Then
        XCTAssertFalse(value.isWithin(range))
    }
    
    internal func test_isWithinClosedRangeReturnsTrue() {
        // Given
        let value: TestSubject = .init(2, .base)
        let lowerBound: TestSubject = .init(1, .base)
        let upperBound: TestSubject = .init(3, .base)
        let range: ClosedRange<TestSubject> = lowerBound...upperBound
        
        // Then
        XCTAssertTrue(value.isWithin(range))
    }
    
    internal func test_isWithinBoundsReturnsFalse() {
        // Given
        let value: TestSubject = .init(4, .base)
        let lowerBound: TestSubject = .init(1, .base)
        let upperBound: TestSubject = .init(3, .base)
        
        // Then
        XCTAssertFalse(value.isWithin(lowerBound, to: upperBound))
    }
    
    internal func test_isWithinBoundsReturnsTrue() {
        // Given
        let value: TestSubject = .init(2, .base)
        let lowerBound: TestSubject = .init(1, .base)
        let upperBound: TestSubject = .init(3, .base)
        
        // Then
        XCTAssertTrue(value.isWithin(lowerBound, to: upperBound))
    }
}


extension MeasureTests {
    private struct FuelEfficiency: Equatable, Measurable {
        internal init(
            coefficient: Double,
            constant: Double = 0,
            symbol: String
        ) {
            self.coefficient = coefficient
            self.constant = constant
            self.symbol = symbol
        }
        
        internal let constant: Double
        internal let coefficient: Double
        internal let symbol: String
        
        internal static let base: Self = .kilometersPerLiter
        
        internal static let kilometersPerLiter: Self = .init(
            coefficient: Length.kilometer.coefficient / Volume.liter.coefficient,
            symbol: "Km/L"
        )
        
        internal static let metersPerLiter: Self = .init(
            coefficient: Length.meter.coefficient / Volume.liter.coefficient,
            symbol: "m/L"
        )
    }
    
    internal func test_convertFuelEfficiencySucceeds() {
        // Given
        var measure: Measure<FuelEfficiency> = .init(5, .kilometersPerLiter)
        
        // When
        measure.convert(to: .metersPerLiter)
        
        // Then
        XCTAssertEqual(measure.description, "5000.0 m/L")
        
        // When
        measure.convert(to: .kilometersPerLiter)
        
        // Then
        XCTAssertEqual(measure.description, "5.0 Km/L")
    }
}

extension MeasureTests {
    internal func test_convertSpeedSucceeds() {
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
    internal func test_convertThermodynamicTemperatureSucceeds() {
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

extension MeasureTests {
    internal func test_descriptionSucceeds() {
        // Given
        let value: TestSubject = .init(4, .base)
        
        // When
        let description: String = value.description
        
        // Then
        XCTAssertEqual(description, "4.0 s")
    }
}

extension MeasureTests {
    internal func test_isEqualToReturnsFalse() {
        // Given
        let lhs: TestSubject = .init(1, .second)
        let rhs: TestSubject = .init(2, .second)
        
        // When
        let result: Bool = lhs.isEqual(to: rhs)
        
        // Then
        XCTAssertFalse(result)
    }
    
    internal func test_isEqualToReturnsTrue() {
        // Given
        let lhs: TestSubject = .init(1, .second)
        let rhs: TestSubject = .init(1, .second)
        
        // When
        let result: Bool = lhs.isEqual(to: rhs)
        
        // Then
        XCTAssertTrue(result)
    }
    
    internal func test_isUnequalToReturnsFalse() {
        // Given
        let lhs: TestSubject = .init(1, .second)
        let rhs: TestSubject = .init(1, .second)
        
        // When
        let result: Bool = lhs.isUnequal(to: rhs)
        
        // Then
        XCTAssertFalse(result)
    }
    
    internal func test_isUnequalToReturnsTrue() {
        // Given
        let lhs: TestSubject = .init(1, .second)
        let rhs: TestSubject = .init(2, .second)
        
        // When
        let result: Bool = lhs.isUnequal(to: rhs)
        
        // Then
        XCTAssertTrue(result)
    }
}

extension MeasureTests {
    internal func test_isEquivalentToReturnsFalse() {
        // Given
        let lhs: TestSubject = .init(1, .minute)
        let rhs: TestSubject = .init(1, .second)
        
        // When
        let result: Bool = lhs.isEquivalent(to: rhs)
        
        // Then
        XCTAssertFalse(result)
    }
    
    internal func test_isEquivalentToReturnsTrue() {
        // Given
        let lhs: TestSubject = .init(1, .minute)
        let rhs: TestSubject = .init(60, .second)
        
        // When
        let result: Bool = lhs.isEquivalent(to: rhs)
        
        // Then
        XCTAssertTrue(result)
    }
}

#if canImport(Foundation)
extension MeasureTests {
    internal func test_decodeFromJSONSucceeds() throws {
        // Given
        let bundle: Bundle = .module
        let url: URL? = bundle.url(forResource: "Measure", withExtension: "json")
        let data: Data? = try .init(contentsOf: XCTUnwrap(url))
        
        // When
        let decoder: JSONDecoder = .init()
        let result: TestSubject = try decoder.decode(TestSubject.self, from: XCTUnwrap(data))
        
        // Then
        let value: TestSubject = .init(1, .second)
        XCTAssertEqual(result, value)
    }
}
#endif

#if canImport(Foundation)
extension MeasureTests {
    internal func test_encodeToJSONSucceeds() throws {
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

extension MeasureTests {
    internal func test_subtractionSucceeds() {
        // Given
        let minuend: Measure<Time> = .init(6, .second)
        let subtrahend: Measure<Time> = .init(4, .second)
        
        // When
        let difference: Measure<Time> = minuend - subtrahend

        // Then
        XCTAssertEqual(difference, .init(2, .second))
    }
    
    internal func test_subtractionEqualSucceeds() {
        // Given
        var difference: Measure<Time> = .init(6, .second)
        let subtrahend: Measure<Time> = .init(4, .second)
        
        // When
        difference -= subtrahend

        // Then
        XCTAssertEqual(difference, .init(2, .second))
    }
    
    internal func test_subtractingSucceeds() {
        // Given
        let minuend: Measure<Time> = .init(6, .second)
        let subtrahend: Measure<Time> = .init(4, .second)
        
        // When
        let difference: Measure<Time> = minuend.subtracting(subtrahend)

        // Then
        XCTAssertEqual(difference, .init(2, .second))
    }
    
    internal func test_subtractSucceeds() {
        // Given
        var difference: Measure<Time> = .init(6, .second)
        let subtrahend: Measure<Time> = .init(4, .second)
        
        // When
        difference.subtract(subtrahend)

        // Then
        XCTAssertEqual(difference, .init(2, .second))
    }
}
