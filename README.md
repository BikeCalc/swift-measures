![](/Assets/GitHubBanner.png)

# Swift Measures

A Swift package for defining, converting, and composing units of measure.

## Overview

Measures provides strongly typed values and units for physical dimensions. It includes SI base and derived units, metric
and binary prefixes, commonly used customary and imperial units, and dimensional composition for related units such as
area, volume, speed, force, energy, and electrical quantities.

Applications can define domain-specific dimensions by creating a unit type that conforms to `Unit`. Values can then be
represented with `Measure`, converted between compatible units, or converted automatically with `Converted`.

`ComposedUnit` supports units whose physical dimensions are determined at runtime from the seven SI base quantities.
Multiply, divide, or raise measures to integer powers to calculate across dimensions, then convert the result back to a
compatible defined unit. Composed units preserve their factors. Use `canonicalized()` or `@Canonicalized` to combine
matching factors and order their representations.

## Requirements

- Swift 6.3+

Measures is written in Swift and avoids platform-specific APIs where possible.

## Installation

1. Add Measures to the dependencies in your `Package.swift` file:

    ```swift
    internal let package: Package = .init(
        ...
        dependencies: [
            .package(
                url: "https://github.com/bikecalc/swift-measures.git",
                from: "3.0.0"
            )
        ],
        ...
    )
    ```

2. Add the `Measures` product to the dependencies of the target that will import it. Replace `YourTarget` with the name
   of that target:

    ```swift
    internal let package: Package = .init(
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

- Keep a `Measure` in one unit while calculating with another:

  ```swift
  @Converted(to: .metersPerSecond) internal var speed: Measure<Speed> = .init(36, .kilometersPerHour)
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

- Calculate across dimensions with `ComposedUnit`. Use `@Converted(to: .coherent)` to keep the result expressed in
  coherent SI units:

  ```swift
  let length: Measure<Length> = .init(4, .meter)
  let width: Measure<Length> = .init(300, .centimeter)

  @Converted(to: .coherent) var area: Measure<ComposedUnit> = length * width

  print(area)
  // Prints "12.0 m²"
  ```

## Documentation

You can read more about this package by visiting the
[Documentation](https://bikecalc.github.io/swift-measures/documentation/measures).

## Contributing

Everyone is welcome to contribute to Measures. Please read our
[Contributing Guide](https://github.com/BikeCalc/.github/blob/main/CONTRIBUTING.md) and
[Code of Conduct](https://github.com/BikeCalc/.github/blob/main/CODE_OF_CONDUCT.md).

If you find a bug, please submit a
[Bug Report](https://github.com/bikecalc/swift-measures/issues/new?template=bug-report.yml).
If you would like to suggest a new capability or improvement, please submit a
[Feature Request](https://github.com/bikecalc/swift-measures/issues/new?template=feature-request.yml).

Report security vulnerabilities privately through the repository’s Security tab instead of opening a public issue.

## License

Distributed under Apache License v2.0 with Runtime Library Exception. See the [License](/LICENSE.md) for more
information.
