![](/Assets/GitHubBanner.png)

# Swift Measures

A Swift package for defining, converting, and composing units of measure.

## Overview

Measures provides strongly typed values and units for physical dimensions. It includes SI base and derived units,
metric and binary prefixes, commonly used customary and imperial units, and dimensional composition for related
units such as area, volume, speed, force, energy, and electrical quantities.

Applications can define domain-specific dimensions by creating a unit type that conforms to `Measurable`. Values can
then be represented with `Measure`, converted between compatible units, or converted automatically with `Converted`.

## Requirements

- Swift 6.3+

Measures is written in Swift and avoids platform-specific APIs where possible.

## Installation

1. Add Measures to the dependencies in your `Package.swift` file:

    ```swift
    let package: Package = .init(
        ...
        dependencies: [
            .package(
                url: "https://github.com/bikecalc/swift-measures.git",
                from: "2.0.0"
            )
        ],
        ...
    )
    ```

2. Add the `Measures` product to the dependencies of the target that will import it. Replace `YourTarget` with the
   name of that target:

    ```swift
    let package: Package = .init(
        ...
        targets: [
            .target(
                name: "YourTarget",
                dependencies: [
                    .product(
                        name: "Measures",
                        package: "swift-measures"
                    )
                ]
            )
        ],
        ...
    )
    ```

3. Import the package in your source code:

    ```swift
    import Measures
    ```

## Demonstration

Keep a measure in one unit while calculating with another:

```swift
@Converted(to: .metersPerSecond)
var speed: Measure<Speed> = .init(36, .kilometersPerHour)
print(speed)
// Prints "10.0 m/s"

speed += .init(18, .kilometersPerHour)
print(speed)
// Prints "15.0 m/s"

speed *= 2
print(speed)
// Prints "30.0 m/s"

print(speed.converted(to: .kilometersPerHour))
// Prints "108.0 km/h"
```

Beyond the operations shown here, `Measure` also supports subtraction, division by a scalar, and comparisons.

## Documentation

You can read more about this package by visiting the
[documentation](https://bikecalc.github.io/swift-measures/documentation/measures).

## Contributing

Everyone is welcome to contribute to Measures. See [Contributing](/CONTRIBUTING.md) for contribution guidelines, branch
conventions, pull request expectations, and testing instructions.

If you find a bug, please create an [issue](https://github.com/bikecalc/swift-measures/issues). Security vulnerabilities
should be reported using the instructions in the [Security Policy](/SECURITY.md).

## Code of Conduct

This project follows a [Code of Conduct](/CODE_OF_CONDUCT.md).

## License

Distributed under Apache License v2.0 with Runtime Library Exception. See the [License](/LICENSE.md) for more
information.
