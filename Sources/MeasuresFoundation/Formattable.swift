// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

#if canImport(Foundation)
import Foundation

/// A value that supports a default textual presentation and explicit Foundation format styles.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol Formattable {
    /// The style used for this value's default textual presentation.
    associatedtype FormatStyle: Foundation.FormatStyle
    where FormatStyle.FormatInput == Self, FormatStyle.FormatOutput == String

    /// Formats this value using its default presentation.
    ///
    /// The conforming type determines the default style configuration.
    ///
    /// - Returns: The default textual representation of this value.
    func formatted() -> Self.FormatStyle.FormatOutput
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension Formattable {
    /// Formats this value using the specified style.
    ///
    /// - Parameter style: A style whose input is this value's type.
    /// - Returns: The representation produced by the style.
    public func formatted<Style>(_ style: Style) -> Style.FormatOutput
    where Style: Foundation.FormatStyle, Style.FormatInput == Self {
        return style.format(self)
    }
}
#endif
