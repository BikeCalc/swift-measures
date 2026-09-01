// swift-tools-version:5.9

// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import PackageDescription

let package: Package = .init(
    name: "swift-measures",
    defaultLocalization: "en",
    products: [
        .library(name: "Measures", targets: ["Measures"])
    ],
    dependencies: [
        .package(url: "https://github.com/bikecalc/swift-numerics-extended.git", from: "2.0.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin.git", from: "1.4.2")
    ],
    targets: [
        .target(
            name: "Measures",
            dependencies: [
                .product(name: "NumericsExtended", package: "swift-numerics-extended")
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
