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

/// A locale-aware presentation of a measure's value and existing unit symbol.
///
/// The numeric style controls precision, rounding, grouping, and other number conventions. Formatting preserves the
/// stored value and unit without conversion or canonicalization. Measures whose `isNaT` property is true produce
/// "NaT", without a number or unit symbol. Other readings are formatted even when outside the unit's valid range.
/// A nonempty symbol is separated from the number by a nonbreaking space (U+00A0); an empty symbol produces only the
/// formatted number.
///
/// For example:
///
/// ```swift
/// let distance: Measure<Length> = .init(1234.5, .meter)
/// let style: MeasureFormatStyle<Length> = .init()
///
/// print(style.locale(Locale(identifier: "en_US")).format(distance))
/// // Prints "1,234.5 m"
/// ```
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct MeasureFormatStyle<UnitType>
where UnitType: CoreMeasureTypes.Unit {
    /// The numeric presentation, including the locale used to format the value.
    public var numberFormatStyle: FloatingPointFormatStyle<Double>

    /// Creates a style using the specified numeric presentation.
    ///
    /// - Parameter numberFormatStyle: The number formatting configuration. The default follows the current locale.
    public init(numberFormatStyle: FloatingPointFormatStyle<Double> = .number) {
        self.numberFormatStyle = numberFormatStyle
    }
}

// MARK: - Decodable

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MeasureFormatStyle: Decodable {}

// MARK: - Encodable

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MeasureFormatStyle: Encodable {}

// MARK: - Equatable

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MeasureFormatStyle: Equatable {}

// MARK: - FormatStyle

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MeasureFormatStyle: FormatStyle {
    public typealias FormatInput = Measure<UnitType>

    public typealias FormatOutput = String

    public func format(_ value: Self.FormatInput) -> Self.FormatOutput {
        guard value.isNaT == false else {
            return "NaT"
        }

        let formattedNumber: String = self.numberFormatStyle.format(value.value)

        guard value.unit.symbol.isEmpty == false else {
            return formattedNumber
        }

        return formattedNumber + "\u{00A0}" + value.unit.symbol
    }

    public func locale(_ locale: Locale) -> Self {
        var style: Self = self
        style.numberFormatStyle = style.numberFormatStyle.locale(locale)
        return style
    }
}

// MARK: - Hashable

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MeasureFormatStyle: Hashable {}

// MARK: - Sendable

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MeasureFormatStyle: Sendable {}
#endif
