// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit whose physical dimension is expressed using the seven SI base quantities.
public protocol ComposableUnit: Unit {
    /// The physical dimension expressed as exponents of the seven SI base quantities.
    var dimension: Dimension { get }
}

extension ComposableUnit {
    public func isCompatible(with other: Self) -> Bool {
        return self.dimension == other.dimension
    }
}
