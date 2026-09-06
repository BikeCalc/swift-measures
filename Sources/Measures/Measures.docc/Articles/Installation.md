# Installation

Add Measures to a Swift package and import the public product.

## Overview

Measures is distributed as a Swift package. Add it as a dependency, attach the `Measures` product to your target, and
import the module in source files that use its measurement types.

### Add the Package Dependency

Add the package to the dependencies in your `Package.swift` file.

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

### Attach the Product to a Target

Add the `Measures` product to the dependencies of the target that will import it. Replace `YourTarget` with the name of
that target.

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

### Import the Module

Import the package in your source code.

```swift
import Measures
```
