// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A type that defines a valid range in its base unit.
public protocol RangeValidatable {
    /// The valid range expressed in the base unit.
    static var validRange: ClosedRange<Double> { get }
}

extension RangeValidatable {
    public static var validRange: ClosedRange<Double> {
        return -.infinity ... .infinity
    }
}
