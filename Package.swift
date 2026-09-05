// swift-tools-version:6.3

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "swift-measures",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v13)
    ],
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
        ),
        .package(
            url: "https://github.com/swiftlang/swift-syntax.git",
            from: "603.0.2"
        )
    ],
    targets: [
        .macro(
            name: "MeasuresMacroPlugin",
            dependencies: [
                "MeasuresMacroSupport",
                .product(
                    name: "SwiftCompilerPlugin",
                    package: "swift-syntax"
                ),
                .product(
                    name: "SwiftDiagnostics",
                    package: "swift-syntax"
                ),
                .product(
                    name: "SwiftSyntax",
                    package: "swift-syntax"
                ),
                .product(
                    name: "SwiftSyntaxBuilder",
                    package: "swift-syntax"
                ),
                .product(
                    name: "SwiftSyntaxMacros",
                    package: "swift-syntax"
                )
            ]
        ),
        .target(
            name: "Measures",
            dependencies: [
                "MeasuresMacro",
                "MeasuresMacroSupport",
                .product(
                    name: "NumericsExtended",
                    package: "swift-numerics-extended"
                )
            ]
        ),
        .target(
            name: "MeasuresMacro",
            dependencies: [
                "MeasuresMacroPlugin"
            ]
        ),
        .target(
            name: "MeasuresMacroSupport",
            dependencies: [
                .product(
                    name: "NumericsExtended",
                    package: "swift-numerics-extended"
                )
            ]
        ),
        .testTarget(
            name: "MeasuresMacroTests",
            dependencies: [
                "Measures",
                "MeasuresMacroPlugin",
                "MeasuresMacroSupport",
                .product(
                    name: "SwiftSyntaxMacrosGenericTestSupport",
                    package: "swift-syntax"
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
