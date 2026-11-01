// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Converted Length Measure Tests")
internal struct ConvertedLengthMeasureTests {
    internal init() {}

    private static let conversionArguments: [(Measure<Length>, Measure<Length>)] = [
        (.init(1, .meter), .init(1, .meter)),
        (.init(100, .centimeter), .init(1, .meter)),
        (.init(1_000, .millimeter), .init(1, .meter)),
        (.init(10, .decimeter), .init(1, .meter)),
        (.init(0.1, .decameter), .init(1, .meter)),
        (.init(0.01, .hectometer), .init(1, .meter)),
        (.init(0.001, .kilometer), .init(1, .meter)),
        (.init(1_000_000, .micrometer), .init(1, .meter))
    ]

    @Test(
        "Initialization converts measures",
        arguments: Self.conversionArguments
    )
    internal func initializationConvertsMeasures(
        value: Measure<Length>,
        expected: Measure<Length>
    ) {
        @Converted(to: .meter) var result: Measure<Length> = value
        #expect(result == expected)
    }

    @Test(
        "Assignment converts measures",
        arguments: Self.conversionArguments
    )
    internal func assignmentConvertsMeasures(
        value: Measure<Length>,
        expected: Measure<Length>
    ) {
        @Converted(to: .meter) var result: Measure<Length> = .init(0, .base)
        result = value
        #expect(result == expected)
    }
}

// MARK: - NaT

extension ConvertedLengthMeasureTests {
    // TODO: Implement NaT tests for this suite.
}
