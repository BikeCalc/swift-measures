// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for force.
@MetricUnits(name: "newton", symbol: "N")
public struct Force {
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

    // MARK: Composed Units

    /// The kilogram-meter per square second unit of force.
    public static let kilogramMeterPerSquareSecond: Self = Mass.kilogram.multiplying(
        by: Acceleration.meterPerSquareSecond
    )

    // MARK: U.S. Customary and Imperial Units

    /// The pound-force unit of force.
    public static let poundForce: Self = .init(
        coefficient: Mass.pound.coefficient * 9.80665,
        symbol: "lbf"
    )

    // MARK: Other Units

    /// The gravity unit of force.
    public static var gravity: Self {
        return .init(
            coefficient: 9.80665 * Mass.kilogram.coefficient,
            symbol: "G"
        )
    }
}

// MARK: - Codable

extension Force: Codable {}

// MARK: - Comparable

extension Force: Comparable {}

// MARK: - Divisible

extension Force {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - Parameter area: A unit of area.
    /// - Returns: A unit of pressure.
    public func dividing(by area: Area) -> Pressure {
        let coefficient: Double = self.coefficient * (1 / area.coefficient)
        let symbol: String = self.symbol + "/" + area.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension Force: Equatable {}

// MARK: - Hashable

extension Force: Hashable {}

// MARK: - Measurable

extension Force: Measurable {
    public static let base: Self = .newton
}

// MARK: - Multipliable

extension Force {
    /// Returns the product of multiplying this value by the specified value.
    ///
    /// - Parameter length: A unit of length.
    /// - Returns: A unit of energy.
    public func multiplying(by length: Length) -> Energy {
        let coefficient: Double = self.coefficient * length.coefficient
        let symbol: String = self.symbol + "⋅" + length.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Sendable

extension Force: Sendable {}
