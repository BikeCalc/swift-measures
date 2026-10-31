// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures

@testable import CoreMeasureUnits

extension ComposedUnit {
    internal static let meter: Self = .init(Length.meter)

    internal static let centimeter: Self = .init(Length.centimeter)

    internal static let millimeter: Self = .init(Length.millimeter)

    internal static let kilometer: Self = .init(Length.kilometer)

    internal static let inch: Self = .init(Length.inch)

    internal static let foot: Self = .init(Length.foot)

    internal static let cancelledMeters: Self = Self.meter / Self.meter

    internal static let dimensionless: Self = .init(dimension: Dimension())
}
