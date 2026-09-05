// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A prefix that scales a unit and contributes to its name and symbol.
package protocol UnitPrefix
where Self: CaseIterable & Equatable & RawRepresentable, Self.RawValue == String {
    /// The multiplier represented by this prefix.
    var coefficient: Double { get }

    /// The symbol prepended to the unprefixed unit symbol.
    var symbol: String { get }

    /// The prefix that leaves a unit unchanged.
    static var none: Self { get }
}

extension UnitPrefix {
    /// The name used to refer to this prefix.
    package var name: String {
        return self == .none ? "none" : self.rawValue
    }
}
