// swift-tools-version:5.9

import PackageDescription

let package: Package = .init(
    name: "swift-measures",
    defaultLocalization: "en",
    products: [
        .library(name: "Measures", targets: ["Measures"])
    ],
    dependencies: [
        .package(url: "https://github.com/bikecalc/swift-numeric-protocols.git", from: "1.0.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin.git", from: "1.4.2")
    ],
    targets: [
        .target(
            name: "Measures",
            dependencies: [
                .product(name: "NumericProtocols", package: "swift-numeric-protocols")
            ],
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency=complete")
            ]
        ),
        .testTarget(
            name: "MeasuresTests",
            dependencies: ["Measures"],
            path: "Tests",
            resources: [
                .process("MeasuresTests/Resources")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency=complete")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
