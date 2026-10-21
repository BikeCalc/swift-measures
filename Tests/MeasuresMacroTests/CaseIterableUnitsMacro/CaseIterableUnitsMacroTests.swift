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

@Suite("CaseIterableUnitsMacro Tests")
internal struct CaseIterableUnitsMacroTests {
    internal init() {}

    @Test("Expands case-iterable units")
    internal func expansion() {
        var failures: Array<TestFailureSpec> = []
        // swift-format-ignore
        assertMacroExpansion(
            """
            @CaseIterableUnits
            struct Nonsense {
                public static let kilowibble: Self = .init()
                public static let wibble: Nonsense = .init()
                public static let base: Self = .wibble
                public static let unrelated: Int = 0
                private static let hidden: Self = .init()
                public static var computed: Self { .wibble }
            }
            """,
            expandedSource: """
            struct Nonsense {
                public static let kilowibble: Self = .init()
                public static let wibble: Nonsense = .init()
                public static let base: Self = .wibble
                public static let unrelated: Int = 0
                private static let hidden: Self = .init()
                public static var computed: Self { .wibble }
            }

            extension Nonsense: CaseIterable {
                public static let allCases: Array<Self> = [
                    .kilowibble,
                    .wibble
                ]
            }
            """,
            macroSpecs: [
                "CaseIterableUnits": MacroSpec(type: CaseIterableUnitsMacro.self)
            ],
            failureHandler: { failure in
                failures.append(failure)
            }
        )
        #expect(failures.isEmpty == true)
    }

    @Test("Expands combined prefix units")
    internal func combinedPrefixUnits() {
        var failures: Array<TestFailureSpec> = []
        // swift-format-ignore
        assertMacroExpansion(
            """
            @MetricUnits(name: "wibble", symbol: "w")
            @BinaryUnits(name: "wibble", symbol: "w")
            @CaseIterableUnits
            struct Nonsense {
                public static let wibble: Self = .init()
                public static let custom: Self = .init()
            }
            """,
            expandedSource: """
            @MetricUnits(name: "wibble", symbol: "w")
            @BinaryUnits(name: "wibble", symbol: "w")
            struct Nonsense {
                public static let wibble: Self = .init()
                public static let custom: Self = .init()
            }

            extension Nonsense: CaseIterable {
                public static let allCases: Array<Self> = [
                    .quettawibble,
                    .ronnawibble,
                    .yottawibble,
                    .zettawibble,
                    .exawibble,
                    .petawibble,
                    .terawibble,
                    .gigawibble,
                    .megawibble,
                    .kilowibble,
                    .hectowibble,
                    .decawibble,
                    .wibble,
                    .deciwibble,
                    .centiwibble,
                    .milliwibble,
                    .microwibble,
                    .nanowibble,
                    .picowibble,
                    .femtowibble,
                    .attowibble,
                    .zeptowibble,
                    .yoctowibble,
                    .rontowibble,
                    .quectowibble,
                    .yobiwibble,
                    .zebiwibble,
                    .exbiwibble,
                    .pebiwibble,
                    .tebiwibble,
                    .gibiwibble,
                    .mebiwibble,
                    .kibiwibble,
                    .custom
                ]
            }
            """,
            macroSpecs: [
                "CaseIterableUnits": MacroSpec(type: CaseIterableUnitsMacro.self)
            ],
            failureHandler: { failure in
                failures.append(failure)
            }
        )
        #expect(failures.isEmpty == true)
    }
}
