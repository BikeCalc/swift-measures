// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import CoreMeasureTypes

extension Converted
where UnitType == ComposedUnit {
    /// A conversion policy that derives its destination from the assigned composed unit.
    public enum ConversionPolicy {
        /// Converts each assigned value to the coherent SI unit for its current dimension.
        case coherent
    }

    /// Creates a wrapper that converts each assigned measure to its coherent SI unit.
    ///
    /// The destination is recalculated on every assignment, allowing the stored dimension to change. Conversion
    /// applies the assigned unit's coefficient and constant. Encoding stores only the measure; decoding restores
    /// a fixed destination rather than this policy.
    ///
    /// For example:
    ///
    /// ```swift
    /// @Converted(to: .coherent)
    /// var distance = Measure(2, ComposedUnit(Length.centimeter))
    ///
    /// print(distance)
    /// // Prints "0.02 m"
    /// ```
    ///
    /// - Parameters:
    ///   - wrappedValue: The measure to convert and store.
    ///   - conversionPolicy: The policy used to determine the destination on every assignment.
    public init(
        wrappedValue: Measure<ComposedUnit>,
        to conversionPolicy: ConversionPolicy
    ) {
        switch conversionPolicy {
        case .coherent:
            self.init(wrappedValue: wrappedValue) { unit in
                return unit.coherent
            }
        }
    }
}
