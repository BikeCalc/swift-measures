// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import SwiftSyntaxMacrosGenericTestSupport
import Testing
@testable import MeasuresMacroPlugin
@testable import MeasuresMacroSupport

@Suite("BinaryUnitsMacro")
internal struct BinaryUnitsMacroTests {
    @Test("Expands binary units")
    internal func expansion() {
        var failures: Array<TestFailureSpec> = []

        assertMacroExpansion(
            """
            @BinaryUnits(name: "wibble", symbol: "w")
            struct Nonsense {}
            """,
            expandedSource: """
            struct Nonsense {

                /// Creates a unit by applying a prefix to the unprefixed unit.
                ///
                /// - Parameter prefix: The prefix to apply.
                /// - Returns: The prefixed unit.
                private static func wibble(_ prefix: BinaryUnitPrefix) -> Self {
                    return self.init(
                        coefficient: prefix.coefficient * 1,
                        symbol: prefix.symbol + "w"
                    )
                }

                /// The yobiwibble unit of nonsense.
                public static let yobiwibble: Self = .wibble(.yobi)

                /// The zebiwibble unit of nonsense.
                public static let zebiwibble: Self = .wibble(.zebi)

                /// The exbiwibble unit of nonsense.
                public static let exbiwibble: Self = .wibble(.exbi)

                /// The pebiwibble unit of nonsense.
                public static let pebiwibble: Self = .wibble(.pebi)

                /// The tebiwibble unit of nonsense.
                public static let tebiwibble: Self = .wibble(.tebi)

                /// The gibiwibble unit of nonsense.
                public static let gibiwibble: Self = .wibble(.gibi)

                /// The mebiwibble unit of nonsense.
                public static let mebiwibble: Self = .wibble(.mebi)

                /// The kibiwibble unit of nonsense.
                public static let kibiwibble: Self = .wibble(.kibi)

                /// The wibble unit of nonsense.
                public static let wibble: Self = .wibble(BinaryUnitPrefix.none)
            }
            """,
            macroSpecs: [
                "BinaryUnits": MacroSpec(type: BinaryUnitsMacro.self)
            ],
            failureHandler: { failure in
                failures.append(failure)
            }
        )

        #expect(failures.isEmpty)
    }
}
