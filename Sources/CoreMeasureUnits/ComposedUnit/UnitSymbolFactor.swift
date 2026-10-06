// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit-symbol label paired with its signed exponent.
internal typealias UnitSymbolFactor = (symbol: String, exponent: Int)

extension Array
where Self.Element == UnitSymbolFactor {
    /// Returns the combined, nonzero factors in first appearance order.
    ///
    /// Matching labels are combined by adding their signed exponents. Zero totals and the identity label `1` are
    /// removed. Labels are compared exactly; distinct units such as `km` and `m` remain separate. Input normalization
    /// and parsing belong to earlier stages. Exponent addition traps on integer overflow.
    ///
    /// - Returns: A new array containing each surviving symbol once with its summed exponent, or an empty array
    ///   when every factor cancels or represents the identity.
    internal func simplified() -> Self {
        var exponents: Dictionary<String, Int> = [:]
        var order: Array<String> = []

        for factor in self {
            guard factor.symbol != "1" else {
                continue
            }
            if exponents[factor.symbol] == nil {
                order.append(factor.symbol)
            }
            exponents[factor.symbol, default: 0] += factor.exponent
        }

        return order.compactMap { symbol in
            guard let exponent: Int = exponents[symbol], exponent != 0 else {
                return nil
            }

            return (
                symbol: symbol,
                exponent: exponent
            )
        }
    }
}
