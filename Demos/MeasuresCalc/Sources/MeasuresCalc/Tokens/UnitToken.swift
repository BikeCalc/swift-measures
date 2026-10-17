// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures

/// A registered unit stored as a composed definition.
internal struct UnitToken {
    /// The registered unit's scale, offset, symbol, and dimension.
    internal let unit: ComposedUnit

    /// Creates a token from a defined unit that supports dimensional composition.
    ///
    /// - Parameter unit: The unit to preserve without conversion to coherent units.
    internal init<UnitType>(_ unit: UnitType)
    where UnitType: ComposableUnit & DefinedUnit {
        self.unit = .init(unit)
    }

}

// MARK: - Equatable

extension UnitToken: Equatable {}

// MARK: - Sendable

extension UnitToken: Sendable {}
