// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Foundation

extension URL {
    /// Identifies the bundle containing the integration tests rather than the test runner.
    private final class TestBundleLocator {
        /// Creates the bundle locator.
        private init() {}
    }

    /// Locates Measures Calc alongside the current test build products.
    ///
    /// - Returns: The executable URL found by searching the test bundle's ancestor directories.
    /// - Throws: A file-not-found error if the executable cannot be located.
    internal static func measuresCalcExecutable() throws -> Self {
        var directory: Self = Bundle(for: Self.TestBundleLocator.self).bundleURL

        while directory.path != "/" {
            let executable: Self = directory.appendingPathComponent("measures-calc")

            if FileManager.default.isExecutableFile(atPath: executable.path) == true {
                return executable
            }

            directory.deleteLastPathComponent()
        }

        throw CocoaError(.fileNoSuchFile)
    }
}
