// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing
@testable import Measures

@Suite("Converted Measure Tests")
internal struct ConvertedMeasureTests {
    private static let conversionArguments: [(Measure<Length>, Measure<Length>)] = [
        (Measure<Length>(1, .meter), Measure<Length>(1, .meter)),
        (Measure<Length>(100, .centimeter), Measure<Length>(1, .meter)),
        (Measure<Length>(1_000, .millimeter), Measure<Length>(1, .meter)),
        (Measure<Length>(10, .decimeter), Measure<Length>(1, .meter)),
        (Measure<Length>(0.1, .decameter), Measure<Length>(1, .meter)),
        (Measure<Length>(0.01, .hectometer), Measure<Length>(1, .meter)),
        (Measure<Length>(0.001, .kilometer), Measure<Length>(1, .meter)),
        (Measure<Length>(1_000_000, .micrometer), Measure<Length>(1, .meter))
    ]

    @Test(
        "Initialization converts measures",
        arguments: Self.conversionArguments
    )
    internal func initializationConvertsMeasures(
        value: Measure<Length>,
        result: Measure<Length>
    ) {
        @Converted(to: .meter) var convertedValue: Measure<Length> = value

        #expect(convertedValue == result)
    }

    @Test(
        "Assignment converts measures",
        arguments: Self.conversionArguments
    )
    internal func assignmentConvertsMeasures(
        value: Measure<Length>,
        result: Measure<Length>
    ) {
        @Converted(to: .meter) var convertedValue: Measure<Length> = .init(0, .base)
        convertedValue = value

        #expect(convertedValue == result)
    }
}
