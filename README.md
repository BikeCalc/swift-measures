![](Assets/GitHubBanner.png)

# swift-measures

A package containing a set of objects and protocols to create and convert units of measure, for the Swift programming language.

## Overview

No overview available.

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
            symbol: String
        ) {
            self.coefficient = coefficient
            self.constant = constant
            self.symbol = symbol
        }
		
        let coefficient: Double
        let constant: Double
        let symbol: String
		
        static let base: Self = .kilometresPerLitre
	}
	```

2. Create a minimum of two units.

	```swift
    extension FuelEfficiency {
        static let kilometresPerLitre: Self = .init(
            coefficient: Length.kilometre.coefficient / Volume.litre.coefficient,
            symbol: "Km/L"
        )

        static let metresPerLitre: Self = .init(
            coefficient: Length.metre.coefficient / Volume.litre.coefficient,
            symbol: "m/L"
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
    // Prints "5000m/L"
	```

## Documentation

You can read more about this package by visiting the [documentation page].

## Contribution

Contributions are what makes the open source community such an amazing place to learn, inspire, and create. If you wish to contribute and be part of this project, please fork the repository and create a [pull request].

1. Fork the repository
2. Create your feature branch `git checkout -b feature/NewFeature`
3. Commit your changes `git commit -m 'Added a new feature'`
4. Push to your branch `git push origin feature/NewFeature`
5. Open a pull request

### Reporting a bug

If you find a bug, please create an [issue].

### Contacting the maintainers

If you want to share your thoughts on how to improve this repository, you can contact the code owner. See the `CODEOWNERS.txt` file for more information.

### Supporting this repository

If this repository has been useful to you in some way, show your support by starring it.

## Code of Conduct

To be a truly great community, we welcome developers from all walks of life, with different backgrounds, and with a wide range of experience. A diverse and friendly community will have more great ideas, more unique perspectives, and produce more great code. We will work diligently to make this community welcoming to everyone. See the `CODEOFCONDUCT.md` file for more information.

## License

Distributed under Apache License v2.0 with Runtime Library Exception. See the `LICENSE.md` file for more information.

[documentation page]: https://alexandrehsaad.github.io/swift-measures/documentation/measures
[pull request]: https://github.com/alexandrehsaad/swift-measures/pulls
[issue]: https://github.com/alexandrehsaad/swift-measures/issues
