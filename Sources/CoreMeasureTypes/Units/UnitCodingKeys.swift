// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// The keys used to encode and decode a unit.
package enum UnitCodingKeys: String, CodingKey {
    /// The multiplicative scale relative to the reference unit.
    case coefficient

    /// The additive offset applied after scaling.
    case constant

    /// The display symbol for the unit.
    case symbol

    /// The physical dimension expressed as SI base-quantity exponents.
    case dimension
}
