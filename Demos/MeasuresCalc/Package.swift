// swift-tools-version:6.3

import PackageDescription

let package: Package = .init(
    name: "swift-measures-calc",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "measures-calc",
            targets: [
                "MeasuresCalcCLI"
            ]
        ),
        .library(
            name: "MeasuresCalc",
            targets: [
                "MeasuresCalc"
            ]
        )
    ],
    dependencies: [
        .package(
            name: "swift-measures",
            path: "../.."
        ),
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.6.0"
        )
    ],
    targets: [
        .target(
            name: "MeasuresCalc",
            dependencies: [
                .product(
                    name: "Measures",
                    package: "swift-measures"
                )
            ]
        ),
        .executableTarget(
            name: "MeasuresCalcCLI",
            dependencies: [
                "MeasuresCalc",
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                )
            ]
        ),
        .testTarget(
            name: "MeasuresCalcTests",
            dependencies: [
                "MeasuresCalc"
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
