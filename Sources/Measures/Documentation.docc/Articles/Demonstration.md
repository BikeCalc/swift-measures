# Demonstration

A demonstration on how to create custom dimensions and units.

## Overview

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

## Converting custom measures

1. Create a dimension that conforms to the measurable protocol.

	```swift
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
		
        let coefficient: Double
        let constant: Double
        let symbol: String
        let name: String
		
        static let base: Self = .kilometresPerLitre
	}
	```

2. Create a minimum of two units.

	```swift
    extension FuelEfficiency {
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


3. Initialize a measure of your dimension with a value and unit.

	```swift
    var measure: Measure<FuelEfficiency> = .init(5, .kilometresPerLitre)
	```

4. Convert the measure to your other unit.

    ```swift
    measure.convert(to: .metresPerLitre)

    print(measure)
    // Prints "5000 m/L"
	```
