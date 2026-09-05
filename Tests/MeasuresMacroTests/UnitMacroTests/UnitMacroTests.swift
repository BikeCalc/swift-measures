// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import SwiftSyntax
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import SwiftSyntaxMacrosGenericTestSupport
import Testing
@testable import MeasuresMacroPlugin
@testable import MeasuresMacroSupport

@Suite("UnitMacro")
internal struct UnitMacroTests {
    @Test("Expands prefixed units")
    internal func expansion() {
        assertExpansion(
            """
            @BasicScaleUnits(name: "bite", symbol: "B", coefficient: 2)
            struct Biscuit {}
            """,
            expandedSource: """
            struct Biscuit {

                /// Creates a unit by applying a prefix to the unprefixed unit.
                ///
                /// - Parameter prefix: The prefix to apply.
                /// - Returns: The prefixed unit.
                private static func bite(_ prefix: BasicScaleUnitPrefix) -> Self {
                    return self.init(
                        coefficient: prefix.coefficient * 2,
                        symbol: prefix.symbol + "B"
                    )
                }

                /// The largebite unit of biscuit.
                public static let largebite: Self = .bite(.large)

                /// The bite unit of biscuit.
                public static let bite: Self = .bite(BasicScaleUnitPrefix.none)

                /// The smallbite unit of biscuit.
                public static let smallbite: Self = .bite(.small)
            }
            """
        )
    }

    @Test("Preserves explicitly declared units")
    internal func explicitUnit() {
        assertExpansion(
            """
            @BasicScaleUnits(name: "bite", symbol: "B")
            struct Biscuit {
                static let largebite: Self
            }
            """,
            expandedSource: """
            struct Biscuit {
                static let largebite: Self

                /// Creates a unit by applying a prefix to the unprefixed unit.
                ///
                /// - Parameter prefix: The prefix to apply.
                /// - Returns: The prefixed unit.
                private static func bite(_ prefix: BasicScaleUnitPrefix) -> Self {
                    return self.init(
                        coefficient: prefix.coefficient * 1,
                        symbol: prefix.symbol + "B"
                    )
                }

                /// The bite unit of biscuit.
                public static let bite: Self = .bite(BasicScaleUnitPrefix.none)

                /// The smallbite unit of biscuit.
                public static let smallbite: Self = .bite(.small)
            }
            """
        )
    }

    @Test("Generates a shared unprefixed unit once")
    internal func sharedUnprefixedUnit() {
        var failures: Array<TestFailureSpec> = []

        assertMacroExpansion(
            """
            @BasicScaleUnits(name: "bite", symbol: "B")
            @ExtendedScaleUnits(name: "bite", symbol: "B")
            struct Biscuit {}
            """,
            expandedSource: """
            struct Biscuit {
            
                /// Creates a unit by applying a prefix to the unprefixed unit.
                ///
                /// - Parameter prefix: The prefix to apply.
                /// - Returns: The prefixed unit.
                private static func bite(_ prefix: BasicScaleUnitPrefix) -> Self {
                    return self.init(
                        coefficient: prefix.coefficient * 1,
                        symbol: prefix.symbol + "B"
                    )
                }
            
                /// The largebite unit of biscuit.
                public static let largebite: Self = .bite(.large)
            
                /// The bite unit of biscuit.
                public static let bite: Self = .bite(BasicScaleUnitPrefix.none)
            
                /// The smallbite unit of biscuit.
                public static let smallbite: Self = .bite(.small)

                /// Creates a unit by applying a prefix to the unprefixed unit.
                ///
                /// - Parameter prefix: The prefix to apply.
                /// - Returns: The prefixed unit.
                private static func bite(_ prefix: ExtendedScaleUnitPrefix) -> Self {
                    return self.init(
                        coefficient: prefix.coefficient * 1,
                        symbol: prefix.symbol + "B"
                    )
                }

                /// The extralargebite unit of biscuit.
                public static let extralargebite: Self = .bite(.extralarge)

                /// The extrasmallbite unit of biscuit.
                public static let extrasmallbite: Self = .bite(.extrasmall)
            }
            """,
            macroSpecs: [
                "ExtendedScaleUnits": MacroSpec(type: ExtendedScaleUnitsMacro.self),
                "BasicScaleUnits": MacroSpec(type: BasicScaleUnitsMacro.self)
            ],
            failureHandler: { failure in
                failures.append(failure)
            }
        )

        #expect(failures.isEmpty)
    }

    @Test("Rejects a non-structure declaration")
    internal func nonStructure() {
        assertExpansion(
            """
            @BasicScaleUnits(name: "bite", symbol: "B")
            class Biscuit {}
            """,
            expandedSource: """
            class Biscuit {}
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "@BasicScaleUnits can only be attached to a structure.",
                    line: 1,
                    column: 1
                )
            ]
        )
    }

    @Test("Rejects an empty unit name")
    internal func emptyName() {
        assertExpansion(
            """
            @BasicScaleUnits(name: "", symbol: "B")
            struct Biscuit {}
            """,
            expandedSource: """
            struct Biscuit {}
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "The unit name cannot be empty.",
                    line: 1,
                    column: 24
                )
            ]
        )
    }

    @Test("Rejects an empty unit symbol")
    internal func emptySymbol() {
        assertExpansion(
            """
            @BasicScaleUnits(name: "bite", symbol: "")
            struct Biscuit {}
            """,
            expandedSource: """
            struct Biscuit {}
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "The unit symbol cannot be empty.",
                    line: 1,
                    column: 40
                )
            ]
        )
    }

    @Test("Requires a unit name string literal")
    internal func nameLiteral() {
        assertExpansion(
            """
            @BasicScaleUnits(name: biteName, symbol: "B")
            struct Biscuit {}
            """,
            expandedSource: """
            struct Biscuit {}
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "The unit name must be a string literal.",
                    line: 1,
                    column: 1
                )
            ]
        )
    }

    @Test("Requires a unit symbol string literal")
    internal func symbolLiteral() {
        assertExpansion(
            """
            @BasicScaleUnits(name: "bite", symbol: biteSymbol)
            struct Biscuit {}
            """,
            expandedSource: """
            struct Biscuit {}
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "The unit symbol must be a string literal.",
                    line: 1,
                    column: 1
                )
            ]
        )
    }

    internal func assertExpansion(
        _ source: String,
        expandedSource: String,
        diagnostics: Array<DiagnosticSpec> = []
    ) {
        var failures: Array<TestFailureSpec> = []

        assertMacroExpansion(
            source,
            expandedSource: expandedSource,
            diagnostics: diagnostics,
            macroSpecs: [
                "BasicScaleUnits": MacroSpec(type: BasicScaleUnitsMacro.self)
            ],
            failureHandler: { failure in
                failures.append(failure)
            }
        )

        #expect(failures.isEmpty)
    }
}
