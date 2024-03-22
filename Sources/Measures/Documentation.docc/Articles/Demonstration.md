# Demonstration

A demonstration on how to create custom dimensions and units.

## Converting custom measures

1. Create a dimension that conforms to the measurable protocol.

	```swift
    struct FuelEfficiency: Measurable {
        let coefficient: Double
        let constant: Double
        let symbol: String

        init(
            coefficient: Double,
            constant: Double = 0,
            symbol: String
        ) {
            self.coefficient = coefficient
            self.constant = constant
            self.symbol = symbol
        }
        
        static let base: Self = .kilometersPerLiter
	}
	```

2. Create a minimum of two units.

	```swift
    extension FuelEfficiency {
        static let kilometersPerLiter: Self = .init(
            coefficient: Length.kilometer.coefficient / Volume.liter.coefficient,
            symbol: "Km/L"
        )

        static let metersPerLiter: Self = .init(
            coefficient: Length.meter.coefficient / Volume.liter.coefficient,
            symbol: "m/L"
        )
    }
    ```

3. Initialize a measure of your dimension with a value and unit.

	```swift
    var measure: Measure<FuelEfficiency> = .init(5, .kilometersPerLiter)
	```

4. Convert the measure to your other unit.

    ```swift
    measure.convert(to: .metersPerLiter)
    print(measure) // Prints "5000m/L"
	```
