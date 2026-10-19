// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures

/// Looks up the registered units by their exact Measures symbols.
internal struct UnitRegistry {
    /// A resolved unit token and the number of input characters consumed by its symbol.
    internal typealias Match = (
        token: UnitToken,
        count: Int
    )

    /// The exact, case-sensitive symbols mapped to their named unit definitions.
    private let units: Dictionary<String, Array<UnitToken>>

    /// Symbols matched as indivisible tokens, ordered longest first.
    private let atomicSymbols: Array<String>

    /// Registers all predefined composable units without discarding duplicate symbols.
    internal init() {
        self.units = Dictionary(grouping: Self.definitions) { $0.unit.symbol }
        self.atomicSymbols = self.units.keys
            .filter { $0.contains("/") == false && $0.contains("·") == false }
            .sorted { $0.count == $1.count ? $0 < $1 : $0.count > $1.count }
    }

    /// The registered unit symbols sorted lexicographically.
    internal var symbols: Array<String> {
        return self.units.keys.sorted()
    }

    /// Matches the longest registered symbol without consuming the start of a longer identifier.
    ///
    /// - Parameters:
    ///   - characters: The input characters.
    ///   - index: The nonnegative offset at which to match a symbol.
    /// - Returns: The matched token and consumed character count, or `nil` when no registered symbol matches.
    /// - Throws: A calculation error if the matched symbol has more than one definition.
    internal func match(
        in characters: Array<Character>,
        at index: Int
    ) throws -> Self.Match? {
        for symbol in self.atomicSymbols {
            let spelling: Array<Character> = .init(symbol)
            let end: Int = index + spelling.count

            guard end <= characters.count,
                Array(characters[index ..< end]) == spelling,
                end == characters.count || characters[end].isLetter == false
            else {
                continue
            }

            if let token: UnitToken = try self.unit(for: symbol) {
                return (
                    token: token,
                    count: spelling.count
                )
            }
        }

        return nil
    }

    /// Looks up a unit by its exact symbol.
    ///
    /// - Parameter symbol: The case-sensitive symbol to resolve.
    /// - Returns: The registered unit token, or `nil` for an unknown symbol.
    /// - Throws: A calculation error if the symbol has more than one definition.
    internal func unit(for symbol: String) throws -> UnitToken? {
        guard let definitions: Array<UnitToken> = self.units[symbol] else {
            return nil
        }

        guard definitions.count == 1 else {
            throw CalculationError.ambiguousUnit(symbol)
        }

        return definitions.first
    }
}

// MARK: - Sendable

extension UnitRegistry: Sendable {}
