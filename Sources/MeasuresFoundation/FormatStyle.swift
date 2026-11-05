// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

#if canImport(Foundation)
import CoreMeasureTypes
import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle {
    /// Returns a style that formats a measure's numeric value and preserves its existing unit symbol.
    ///
    /// - Parameter numberFormatStyle: The numeric presentation, including precision, rounding, and locale.
    /// - Returns: A measure format style using the specified numeric presentation.
    public static func measure<UnitType>(
        numberFormatStyle: FloatingPointFormatStyle<Double> = .number
    ) -> Self
    where Self == MeasureFormatStyle<UnitType> {
        return .init(numberFormatStyle: numberFormatStyle)
    }
}
#endif
