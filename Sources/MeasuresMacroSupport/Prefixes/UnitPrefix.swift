// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

package protocol UnitPrefix
where Self: CaseIterable & Equatable & RawRepresentable, Self.RawValue == String {
    var coefficient: Double { get }
    var symbol: String { get }

    static var none: Self { get }
}

extension UnitPrefix {
    package var name: String {
        return self == .none ? "none" : self.rawValue
    }
}
