// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for speed.
public struct Speed {
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

    // MARK: Customary and Imperial Units

    /// The miles per hour unit of speed.
    public static let milesPerHour: Self = Length.mile.dividing(by: .hour)

    /// The feet per second unit of speed.
    public static let feetPerSecond: Self = Length.foot.dividing(by: .second)

    // MARK: Metric Units

    /// The kilometers per hour unit of speed.
    public static let kilometersPerHour: Self = Length.kilometer.dividing(by: .hour)

    /// The meter per second unit of speed.
    public static let metersPerSecond: Self = Length.meter.dividing(by: .second)

    /// The centimeters per second unit of speed.
    public static let centimetersPerSecond: Self = Length.centimeter.dividing(by: .second)

    // MARK: Other Units

    /// The knot unit of speed.
    public static let knot: Self = Length.nauticalMile.dividing(by: .hour)
}

// MARK: - Codable

extension Speed: Codable {}

// MARK: - Comparable

extension Speed: Comparable {}

// MARK: - Divisible

extension Speed {
    /// Returns the quotient of dividing this value by the specified value.
    ///
    /// - Parameter time: A unit of time.
    /// - Returns: A unit of acceleration.
    public func dividing(by time: Time) -> Acceleration {
        let coefficient: Double = self.coefficient * (1 / time.coefficient)
        let symbol: String = self.symbol + "/" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}

// MARK: - Equatable

extension Speed: Equatable {}

// MARK: - Hashable

extension Speed: Hashable {}

// MARK: - Measurable

extension Speed: Measurable {
    public static let base: Self = .metersPerSecond
}

// MARK: - Sendable

extension Speed: Sendable {}
