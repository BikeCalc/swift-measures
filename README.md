![](Assets/GitHubBanner.png)

# swift-measures

// TODO:

## Overview

// TODO:

## Availability

- iOS 13.0+
- iPadOS 13.0+
- macCatalyst 15.0+
- macOS 10.15+
- watchOS 6.0+

## Installation

The Swift Package Manager is a tool for managing the distribution of Swift code and is integrated into the swift compiler.

1. Add the package to the dependencies in your `Package.swift` file.

    ```swift
    let package: Package = .init(
        ...
        dependencies: [
            .package(url: "https://github.com/alexandrehsaad/swift-measures.git", branch: "main")
        ],
        ...
    )
    ```

2. Add the package as a dependency on your target in your `Package.swift` file.

    ```swift
    let package: Package = .init(
        ...
        targets: [
            .target(name: "MyTarget", dependencies: [
                .product(name: "Measures", package: "swift-measures")
            ]),
        ],
        ...
    )
    ```

3. Import the package in your source code.

    ```swift
    import Measures
    ```
    
## Demonstration
    
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
		
        static let base: Self = .kilometrePerLitre
	}
	```

2. Create a minimum of two units.

	```swift
    extension FuelEfficiency {
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


3. Initialize a measure of your dimension with a value and unit.

	```swift
    var measure: Measure<FuelEfficiency> = .init(5, .kilometrePerLitre)
	```

4. Convert the measure to your other unit.

    ```swift
    measure.convert(to: .metrePerLitre)

    print(measure)
    // Prints "5000 m/L"
	```

## Documentation

You can read more about this package by visiting the [documentation page](https://alexandrehsaad.github.io/swift-measures/documentation/measures).

## Contribution

Contributions are what makes the open source community such an amazing place to learn, inspire, and create. If you wish to contribute and be part of this project, please fork the repository and create a [pull request](https://github.com/alexandrehsaad/swift-measures/pulls).

1. Fork the repository
2. Create your feature branch `git checkout -b NewFeature`
3. Commit your changes `git commit -m 'Added a new feature'`
4. Push to your branch `git push origin NewFeature`
5. Open a pull request

### Reporting a bug

If you find a bug, please create an [issue](https://github.com/alexandrehsaad/swift-measures/issues).

### Contacting the maintainers

The current code owner of this repository is Alex ([@alexandrehsaad](https://github.com/alexandrehsaad)). If you want to share your thoughts or feedback on how to improve this repository, you can contact him by writing an email to alexandresaad at icloud dot com.

### Supporting this repository

If this repository has been useful to you in some way, show your support by starring it.

## License

Distributed under Apache License v2.0 with Runtime Library Exception. See the `LICENSE.txt` file for more information.
