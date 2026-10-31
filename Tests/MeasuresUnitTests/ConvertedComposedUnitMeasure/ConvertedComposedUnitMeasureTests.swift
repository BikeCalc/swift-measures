// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import Measures

@Suite("Converted ComposedUnit Measure Tests")
internal struct ConvertedComposedUnitMeasureTests {
    internal init() {}

    private static let conversionArguments: [(Measure<ComposedUnit>, Measure<ComposedUnit>)] = [
        (.init(1, .meter), .init(1, .meter)),
        (.init(100, .centimeter), .init(1, .meter)),
        (.init(1_000, .millimeter), .init(1, .meter)),
        (.init(10, .decimeter), .init(1, .meter)),
        (.init(0.1, .decameter), .init(1, .meter)),
        (.init(0.01, .hectometer), .init(1, .meter)),
        (.init(0.001, .kilometer), .init(1, .meter)),
        (.init(1_000_000, .micrometer), .init(1, .meter)),
        (.init(1, .dimensionless), .init(1, .dimensionless)),
        (.init(1, .cancelledMeters), .init(1, .dimensionless)),
        (.init(1, .dimensionless), .init(1, .cancelledMeters)),
        (.init(1, .cancelledMeters), .init(1, .cancelledMeters))
    ]

    private static let coherentConversionArguments: [(Measure<ComposedUnit>, Measure<ComposedUnit>)] = [
        (.init(100, .centimeter), .init(1, .meter)),
        (.init(2, ComposedUnit(Time.minute)), .init(120, ComposedUnit(Time.second))),
        (
            .init(0, ComposedUnit(ThermodynamicTemperature.celsius)),
            .init(273.15, ComposedUnit(ThermodynamicTemperature.kelvin))
        ),
        (.init(2, .cancelledMeters), .init(2, .dimensionless))
    ]

    @Test(
        "Initialization converts measures",
        arguments: Self.conversionArguments
    )
    internal func initializationConvertsMeasures(
        value: Measure<ComposedUnit>,
        result: Measure<ComposedUnit>
    ) {
        @Converted(to: result.unit) var convertedValue: Measure<ComposedUnit> = value
        #expect(convertedValue == result)
    }

    @Test(
        "Assignment converts measures",
        arguments: Self.conversionArguments
    )
    internal func assignmentConvertsMeasures(
        value: Measure<ComposedUnit>,
        result: Measure<ComposedUnit>
    ) {
        @Converted(to: result.unit) var convertedValue: Measure<ComposedUnit> = .init(0, result.unit)
        convertedValue = value
        #expect(convertedValue == result)
    }

    @Test(
        "Coherent initialization converts measures",
        arguments: Self.coherentConversionArguments
    )
    internal func coherentInitializationConvertsMeasures(
        value: Measure<ComposedUnit>,
        result: Measure<ComposedUnit>
    ) {
        @Converted(to: .coherent) var convertedValue: Measure<ComposedUnit> = value
        #expect(convertedValue == result)
    }

    @Test(
        "Coherent assignment resolves the destination for each dimension",
        arguments: Self.coherentConversionArguments
    )
    internal func coherentAssignmentResolvesDestination(
        value: Measure<ComposedUnit>,
        result: Measure<ComposedUnit>
    ) {
        @Converted(to: .coherent) var convertedValue: Measure<ComposedUnit> = .init(1, .meter)
        convertedValue = value
        #expect(convertedValue == result)
        convertedValue = .init(200, .centimeter)
        #expect(convertedValue == .init(2, .meter))
    }
}

// MARK: - NaT

extension ConvertedComposedUnitMeasureTests {
    // TODO: Implement NaT tests for this suite.
}
