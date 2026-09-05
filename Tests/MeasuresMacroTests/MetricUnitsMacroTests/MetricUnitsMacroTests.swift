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

@Suite("MetricUnitsMacro")
internal struct MetricUnitsMacroTests {
    @Test("Expands metric units")
    internal func expansion() {
        var failures: Array<TestFailureSpec> = []

        assertMacroExpansion(
            """
            @MetricUnits(name: "wibble", symbol: "w")
            struct Nonsense {
                init(coefficient: Double, constant: Double, symbol: String) {}
            }
            """,
            expandedSource: """
            struct Nonsense {
                init(coefficient: Double, constant: Double, symbol: String) {}

                /// Creates a unit by applying a prefix to the unprefixed unit.
                ///
                /// - Parameter prefix: The prefix to apply.
                /// - Returns: The prefixed unit.
                private static func wibble(_ prefix: MetricUnitPrefix) -> Self {
                    return self.init(
                        coefficient: prefix.coefficient * 1,
                        constant: 0,
                        symbol: prefix.symbol + "w"
                    )
                }

                /// The quettawibble unit of nonsense.
                public static let quettawibble: Self = .wibble(.quetta)

                /// The ronnawibble unit of nonsense.
                public static let ronnawibble: Self = .wibble(.ronna)

                /// The yottawibble unit of nonsense.
                public static let yottawibble: Self = .wibble(.yotta)

                /// The zettawibble unit of nonsense.
                public static let zettawibble: Self = .wibble(.zetta)

                /// The exawibble unit of nonsense.
                public static let exawibble: Self = .wibble(.exa)

                /// The petawibble unit of nonsense.
                public static let petawibble: Self = .wibble(.peta)

                /// The terawibble unit of nonsense.
                public static let terawibble: Self = .wibble(.tera)

                /// The gigawibble unit of nonsense.
                public static let gigawibble: Self = .wibble(.giga)

                /// The megawibble unit of nonsense.
                public static let megawibble: Self = .wibble(.mega)

                /// The kilowibble unit of nonsense.
                public static let kilowibble: Self = .wibble(.kilo)

                /// The hectowibble unit of nonsense.
                public static let hectowibble: Self = .wibble(.hecto)

                /// The decawibble unit of nonsense.
                public static let decawibble: Self = .wibble(.deca)

                /// The wibble unit of nonsense.
                public static let wibble: Self = .wibble(MetricUnitPrefix.none)

                /// The deciwibble unit of nonsense.
                public static let deciwibble: Self = .wibble(.deci)

                /// The centiwibble unit of nonsense.
                public static let centiwibble: Self = .wibble(.centi)

                /// The milliwibble unit of nonsense.
                public static let milliwibble: Self = .wibble(.milli)

                /// The microwibble unit of nonsense.
                public static let microwibble: Self = .wibble(.micro)

                /// The nanowibble unit of nonsense.
                public static let nanowibble: Self = .wibble(.nano)

                /// The picowibble unit of nonsense.
                public static let picowibble: Self = .wibble(.pico)

                /// The femtowibble unit of nonsense.
                public static let femtowibble: Self = .wibble(.femto)

                /// The attowibble unit of nonsense.
                public static let attowibble: Self = .wibble(.atto)

                /// The zeptowibble unit of nonsense.
                public static let zeptowibble: Self = .wibble(.zepto)

                /// The yoctowibble unit of nonsense.
                public static let yoctowibble: Self = .wibble(.yocto)

                /// The rontowibble unit of nonsense.
                public static let rontowibble: Self = .wibble(.ronto)

                /// The quectowibble unit of nonsense.
                public static let quectowibble: Self = .wibble(.quecto)
            }
            """,
            macroSpecs: [
                "MetricUnits": MacroSpec(type: MetricUnitsMacro.self)
            ],
            failureHandler: { failure in
                failures.append(failure)
            }
        )

        #expect(failures.isEmpty)
    }
}
