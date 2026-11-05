// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit whose physical dimension is expressed using the seven SI base quantities.
///
/// Coefficients and constants describe conversion to the coherent SI reference for that dimension. Units with matching
/// dimensions are compatible for conversion. Capturing a defined unit in a composed unit requires both `ComposableUnit`
/// and `DefinedUnit`; an instance's dimension alone does not provide a shared base unit or an initializer.
public protocol ComposableUnit: Unit {
    /// The physical dimension expressed as exponents of the seven SI base quantities.
    var dimension: Dimension { get }
}

extension ComposableUnit {
    public func isCompatible(with other: Self) -> Bool {
        return self.dimension == other.dimension
    }

    /// Returns a boolean value indicating whether this unit and another composable unit have matching dimensions.
    ///
    /// - Parameter other: The unit to check, which may have a different concrete type.
    /// - Returns: A boolean value indicating whether the units have the same physical dimension.
    public func isCompatible<Other>(with other: Other) -> Bool
    where Other: ComposableUnit {
        return self.dimension == other.dimension
    }
}
