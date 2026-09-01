// swift-tools-version:6.3

import PackageDescription

let package = Package(
    name: "swift-measures",
    defaultLocalization: "en",
    products: [
        .library(
            name: "Measures",
            targets: [
                "Measures"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/bikecalc/swift-numerics-extended.git",
            from: "2.0.0"
        ),
        .package(
            url: "https://github.com/swiftlang/swift-docc-plugin.git",
            from: "1.4.2"
        )
    ],
    targets: [
        .target(
            name: "Measures",
            dependencies: [
                .product(
                    name: "NumericsExtended",
                    package: "swift-numerics-extended"
                )
            ]
        ),
        .testTarget(
            name: "MeasuresTests",
            dependencies: [
                "Measures"
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
