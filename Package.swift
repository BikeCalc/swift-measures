// swift-tools-version:5.7

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
		.package(url: "https://github.com/alexandrehsaad/swift-numeric-protocols.git", branch: "main"),
		.package(url: "https://github.com/apple/swift-docc-plugin.git", .upToNextMinor(from: "1.3.0"))
	],
	targets: [
		.target(
			name: "Measures",
			dependencies: [
				.product(name: "NumericProtocols", package: "swift-numeric-protocols")
			],
			path: "Sources"
		),
		.testTarget(
			name: "MeasuresTests",
			dependencies: ["Measures"],
			path: "Tests",
			resources: [
				.process("MeasuresTests/Resources")
			]
		)
	],
	swiftLanguageVersions: [.v5]
)
