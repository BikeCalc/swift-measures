// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

#if canImport(Foundation)
import CoreMeasureTypes

// MARK: - Formattable

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension Measure: Formattable {
    public typealias FormatStyle = MeasureFormatStyle<UnitType>

    public func formatted() -> Self.FormatStyle.FormatOutput {
        let style: Self.FormatStyle = .init()
        return self.formatted(style)
    }
}
#endif
