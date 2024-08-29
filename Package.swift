// swift-tools-version:5.9

import PackageDescription

let package: Package = .init(
    name: "swift-measures",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .macCatalyst(.v15),
        .macOS(.v10_15),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "Measures", targets: ["Measures"])
    ],
    dependencies: [
        .package(url: "https://github.com/alexandrehsaad/swift-numeric-protocols.git", .upToNextMajor(from: "0.2.0")),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin.git", .upToNextMajor(from: "1.4.2"))
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
