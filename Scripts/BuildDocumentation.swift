// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Foundation

guard CommandLine.arguments.count == 1 else {
    print("Usage: BuildDocumentation.swift")
    exit(EXIT_FAILURE)
}

/// The HTML that redirects the site root to DocC's documentation landing page.
fileprivate let redirectHTML: String = "<meta http-equiv=\"refresh\" content=\"0; url=documentation/\">\n"

/// The output path of the documentation site's landing page.
fileprivate let landingPagePath: String = "docs/index.html"

do {
    let process: Process = .init()
    process.executableURL = .init(fileURLWithPath: "/usr/bin/env")

    // Keep the generated site rooted at docs/ for the workflow's Pages artifact upload.
    process.arguments = [
        "swift", "package", "--allow-writing-to-directory", "./docs", "generate-documentation",
        "--enable-experimental-combined-documentation",
        "--target", "CoreMeasureTypes",
        "--target", "CoreMeasureUnits",
        "--target", "AdditionalMeasureUnits",
        "--target", "Measures",
        "--output-path", "./docs",
        "--transform-for-static-hosting",
        "--hosting-base-path", "swift-measures"
    ]

    try process.run()
    process.waitUntilExit()

    // Do not create or replace the landing page when documentation generation fails.
    guard process.terminationReason == .exit && process.terminationStatus == EXIT_SUCCESS else {
        exit(process.terminationReason == .exit ? process.terminationStatus : EXIT_FAILURE)
    }

    // Redirect the site root to DocC's documentation landing page after a successful build.
    try redirectHTML.write(
        toFile: landingPagePath,
        atomically: true,
        encoding: .utf8
    )
} catch let error {
    FileHandle.standardError.write(Data("\(error)\n".utf8))
    exit(EXIT_FAILURE)
}
