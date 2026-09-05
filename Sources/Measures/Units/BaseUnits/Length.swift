// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for length.
@MetricUnits(name: "meter", symbol: "m")
public struct Length {
    public let coefficient: Double

    public let constant: Double

    public let symbol: String

    public init(
        coefficient: Double,
        constant: Double = 0,
        symbol: String
    ) {
        self.coefficient = coefficient
        self.constant = constant
        self.symbol = symbol
    }

    // MARK: Astronomical Units

    /// The parsec unit of length.
    public static let parsec: Self = .init(
        coefficient: 3.086e+16,
        symbol: "pc"
    )

    /// The light year unit of length.
    public static let lightYear: Self = .init(
        coefficient: 9.4607e+15,
        symbol: "ly"
    )

    /// The astronomical unit unit of length.
    public static let astronomicalUnit: Self = .init(
        coefficient: 1.496e+11,
        symbol: "au"
    )

    // MARK: Customary and Imperial Units

    /// The nautical league unit of length.
    public static let nauticalLeague: Self = .init(
        coefficient: Self.nauticalMile.coefficient * 3,
        symbol: "nlea"
    )

    /// The league unit of length.
    public static let league: Self = .init(
        coefficient: Self.mile.coefficient * 3,
        symbol: "lea"
    )

    /// The nautical mile unit of length.
    public static let nauticalMile: Self = .init(
        coefficient: 1.852e+3,
        symbol: "nmi"
    )

    /// The mile unit of length.
    public static let mile: Self = .init(
        coefficient: 1.609344e+3,
        symbol: "mi"
    )

    /// The cable unit of length.
    public static let cable: Self = .init(
        coefficient: Self.nauticalMile.coefficient / 10,
        symbol: "cb"
    )

    /// The furlong unit of length.
    public static let furlong: Self = .init(
        coefficient: 2.01168e+2, symbol: "fur"
    )

    /// The chain unit of length.
    public static let chain: Self = .init(
        coefficient: Self.inch.coefficient * 792,
        symbol: "ch"
    )

    /// The rod unit of length.
    public static let rod: Self = .init(
        coefficient: Self.inch.coefficient * 198,
        symbol: "rd"
    )

    /// The fathom unit of length.
    public static let fathom: Self = .init(
        coefficient: Self.inch.coefficient * 72,
        symbol: "ftm"
    )

    /// The yard unit of length.
    public static let yard: Self = .init(
        coefficient: Self.inch.coefficient * 36,
        symbol: "yd"
    )

    /// The foot unit of length.
    public static let foot: Self = .init(
        coefficient: Self.inch.coefficient * 12,
        symbol: "ft"
    )

    /// The link unit of length.
    public static let link: Self = .init(
        coefficient: 2.01168,
        symbol: "li"
    )

    /// The inch unit of length.
    public static let inch: Self = .init(
        coefficient: 2.54e-2,
        symbol: "in"
    )

    /// The pica unit of length.
    public static let pica: Self = .init(
        coefficient: Self.inch.coefficient / 6,
        symbol: "pc"
    )

    /// The point unit of length.
    public static let point: Self = .init(
        coefficient: Self.inch.coefficient / 72,
        symbol: "pt"
    )

    /// The thou unit of length.
    public static let thou: Self = .init(
        coefficient: Self.inch.coefficient / 1_000,
        symbol: "th"
    )
}

// MARK: - Codable

extension Length: Codable {}

// MARK: - Comparable

extension Length: Comparable {}

// MARK: - Divisible

extension Length {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter time: A unit of time.
    /// - returns: A unit of speed.
    public func dividing(by time: Time) -> Speed {
        let coefficient: Double =  self.coefficient * (1 / time.coefficient)
        let symbol: String = self.symbol + "/" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension Length: Equatable {}

// MARK: - Hashable

extension Length: Hashable {}

// MARK: - Measurable

extension Length: Measurable {
    public static let base: Self = .meter
}

// MARK: - Multipliable

extension Length {
    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - parameter length: A unit of length.
    /// - returns: A unit of area.
    public func multiplying(by length: Length) -> Area {
        let coefficient: Double = self.coefficient * length.coefficient
        let symbol: String = self.symbol + "⋅" + length.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Raisable

extension Length {
    /// Returns the result of raising this value to its square.
    ///
    /// - returns: A unit of area.
    public func squared() -> Area {
        let unit: Area = self.multiplying(by: self)

        return .init(
            coefficient: unit.coefficient,
            symbol: self.symbol + "²"
        )
    }

    /// Returns the result of raising this value to its cube.
    ///
    /// - returns: A unit of volume.
    public func cubed() -> Volume {
        let unit: Volume = self.squared().multiplying(by: self)

        return .init(
            coefficient: unit.coefficient,
            symbol: self.symbol + "³"
        )
    }
}

// MARK: - Sendable

extension Length: Sendable {}
