// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for mass.
@MetricUnits(name: "gram", symbol: "g", coefficient: 1e-3)
public struct Mass {
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

    /// The solar unit of mass.
    public static let solar: Self = .init(
        coefficient: 1.98892e+30,
        symbol: "Mo"
    )

    /// The jupiter unit of mass.
    public static let jupiter: Self = .init(
        coefficient: 1.898e+27,
        symbol: "Mj"
    )

    /// The jupiter unit of mass.
    public static let earth: Self = .init(
        coefficient: Self.pound.coefficient *  5.9742e+24,
        symbol: "Me"
    )

    // MARK: Imperial Units

    /// The imperial ton unit of mass.
    public static let imperialTon: Self = .init(
        coefficient: Self.pound.coefficient * 2.24e+3,
        symbol: "imp ton"
    )

    /// The imperial hundredweight unit of mass.
    public static let imperialHundredweight: Self = .init(
        coefficient: Self.pound.coefficient * 112,
        symbol: "imp cwt"
    )

    /// The stone unit of mass.
    public static let stone: Self = .init(
        coefficient: Self.pound.coefficient * 14,
        symbol: "st"
    )

    // MARK: Other Metric Units

    /// The metric ton unit of mass.
    public static let metricTon: Self = .init(
        coefficient: Self.megagram.coefficient,
        symbol: "t"
    )

    /// The carat unit of mass.
    public static let carat: Self = .init(
        coefficient: 2e-4,
        symbol: "ct"
    )

    // MARK: Troy Units

    /// The troy pound unit of mass.
    public static let troyPound: Self = .init(
        coefficient: Self.troyOunce.coefficient * 12,
        symbol: "tlb"
    )

    /// The troy ounce unit of mass.
    public static let troyOunce: Self = .init(
        coefficient: Self.grain.coefficient * 480,
        symbol: "toz"
    )

    // MARK: U.S. Customary and Imperial Units

    /// The pound unit of mass.
    public static let pound: Self = .init(
        coefficient: 4.5359237e-1,
        symbol: "lb"
    )

    /// The ounce unit of mass.
    public static let ounce: Self = .init(
        coefficient: Self.pound.coefficient / 16,
        symbol: "oz"
    )

    /// The dram unit of mass.
    public static let dram: Self = .init(
        coefficient: Self.ounce.coefficient / 16,
        symbol: "dr"
    )

    /// The pennyweight unit of mass.
    public static let pennyweight: Self = .init(
        coefficient: Self.grain.coefficient * 24,
        symbol: "dwt"
    )

    /// The grain unit of mass.
    public static let grain: Self = .init(
        coefficient: Self.pound.coefficient / 7e+3,
        symbol: "gr"
    )

    // MARK: U.S. Customary Units

    /// The U.S. ton unit of mass.
    public static let usTon: Self = .init(
        coefficient: Self.pound.coefficient * 2e+3,
        symbol: "US ton"
    )

    /// The U.S. hundredweight unit of mass.
    public static let usHundredweight: Self = .init(
        coefficient: Self.pound.coefficient * 1e+2,
        symbol: "US cwt"
    )

    /// The slug unit of mass.
    public static let slug: Self = .init(
        coefficient: 1.45939e+1,
        symbol: "slg"
    )

    /// The blob unit of mass.
    public static let blob: Self = .init(
        coefficient: Self.slug.coefficient / 12,
        symbol: "blb"
    )
}

// MARK: - Codable

extension Mass: Codable {}

// MARK: - Comparable

extension Mass: Comparable {}

// MARK: - Divisible

extension Mass {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter area: A unit of area.
    /// - returns: A unit of surface density.
    public func dividing(by area: Area) -> SurfaceDensity {
        let coefficient: Double = self.coefficient * (1 / area.coefficient)
        let symbol: String = self.symbol + "/" + area.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }

    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter substanceAmount: A unit of substance amount.
    /// - returns: A unit of molar mass.
    public func dividing(by substanceAmount: SubstanceAmount) -> MolarMass {
        let coefficient: Double = self.coefficient * (1 / substanceAmount.coefficient)
        let symbol: String = self.symbol + "/" + substanceAmount.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }

    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - parameter volume: A unit of volume.
    /// - returns: A unit of concentration.
    public func dividing(by volume: Volume) -> Concentration {
        let coefficient: Double = self.coefficient * (1 / volume.coefficient)
        let symbol: String = self.symbol + "/" + volume.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension Mass: Equatable {}

// MARK: - Hashable

extension Mass: Hashable {}

// MARK: - Measurable

extension Mass: Measurable {
    public static let base: Self = .kilogram
}

// MARK: - Multipliable

extension Mass {
    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - parameter acceleration: A unit of acceleration.
    /// - returns: A unit of force.
    public func multiplying(by acceleration: Acceleration) -> Force {
        let coefficient: Double = self.coefficient * acceleration.coefficient
        let symbol: String = self.symbol + "⋅" + acceleration.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Sendable

extension Mass: Sendable {}
