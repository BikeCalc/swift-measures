// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

/// A unit of measure for volume.
@MetricUnits(name: "liter", symbol: "L", coefficient: 1e-3)
public struct Volume {
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

    /// The cubic mile unit of volume.
    public static let cubicMile: Self = Length.mile.cubed()

    /// The cubic kilometer unit of volume.
    public static let cubicKilometer: Self = Length.kilometer.cubed()

    /// The cubic meter unit of volume.
    public static let cubicMeter: Self = Length.meter.cubed()

    /// The cubic yard unit of volume.
    public static let cubicYard: Self = Length.yard.cubed()

    /// The cubic foot unit of volume.
    public static let cubicFoot: Self = Length.foot.cubed()

    /// The cubic inch unit of volume.
    public static let cubicInch: Self = Length.inch.cubed()

    /// The cubic centimeter unit of volume.
    public static let cubicCentimeter: Self = Length.centimeter.cubed()

    /// The cubic millimeter unit of volume.
    public static let cubicMillimeter: Self = Length.millimeter.cubed()

    // MARK: Imperial Units

    /// The imperial gallon unit of volume.
    public static let imperialGallon: Self = .init(
        coefficient: 4.54609e-3,
        symbol: "imp gal"
    )

    /// The imperial bushel unit of volume.
    public static let imperialBushel: Self = .init(
        coefficient: Self.imperialGallon.coefficient * 8,
        symbol: "imp bu"
    )

    /// The imperial peck unit of volume.
    public static let imperialPeck: Self = .init(
        coefficient: Self.imperialBushel.coefficient / 4,
        symbol: "imp pk"
    )

    /// The imperial quart unit of volume.
    public static let imperialQuart: Self = .init(
        coefficient: Self.imperialGallon.coefficient / 4,
        symbol: "imp qt"
    )

    /// The imperial pint unit of volume.
    public static let imperialPint: Self = .init(
        coefficient: Self.imperialGallon.coefficient / 8,
        symbol: "imp pt"
    )

    /// The imperial gill unit of volume.
    public static let imperialGill: Self = .init(
        coefficient: Self.imperialGallon.coefficient / 32,
        symbol: "imp gi"
    )

    /// The imperial fluid ounce unit of volume.
    public static let imperialFluidOunce: Self = .init(
        coefficient: Self.imperialGallon.coefficient / 160,
        symbol: "imp fl oz"
    )

    /// The imperial tablespoon unit of volume.
    public static let imperialTablespoon: Self = .init(
        coefficient: Self.imperialFluidOunce.coefficient * 5 / 8,
        symbol: "imp tbsp"
    )

    /// The imperial teaspoon unit of volume.
    public static let imperialTeaspoon: Self = .init(
        coefficient: Self.imperialFluidOunce.coefficient * 5 / 24,
        symbol: "imp tsp"
    )

    /// The imperial fluid dram unit of volume.
    public static let imperialFluidDram: Self = .init(
        coefficient: Self.imperialGallon.coefficient / 1_280,
        symbol: "imp fl dr"
    )

    /// The imperial fluid scruple unit of volume.
    public static let imperialFluidScruple: Self = .init(
        coefficient: Self.imperialFluidDram.coefficient / 3,
        symbol: "imp fl s"
    )

    /// The imperial minim unit of volume.
    public static let imperialMinim: Self = .init(
        coefficient: Self.imperialGallon.coefficient / 76_800,
        symbol: "imp min"
    )

    // MARK: U.S. Dry Units

    /// The U.S. dry bushel unit of volume.
    public static let usDryBushel: Self = .init(
        coefficient: Self.cubicInch.coefficient * 2_150.42,
        symbol: "US bu"
    )

    /// The U.S. dry peck unit of volume.
    public static let usDryPeck: Self = .init(
        coefficient: Self.usDryBushel.coefficient / 4,
        symbol: "US pk"
    )

    /// The U.S. dry quart unit of volume.
    public static let usDryQuart: Self = .init(
        coefficient: Self.usDryBushel.coefficient / 32,
        symbol: "US dry qt"
    )

    /// The U.S. dry pint unit of volume.
    public static let usDryPint: Self = .init(
        coefficient: Self.usDryBushel.coefficient / 64,
        symbol: "US dry pt"
    )

    // MARK: U.S. Liquid Units

    /// The U.S. liquid gallon unit of volume.
    public static let usLiquidGallon: Self = .init(
        coefficient: Self.cubicInch.coefficient * 231,
        symbol: "US gal"
    )

    /// The U.S. liquid quart unit of volume.
    public static let usLiquidQuart: Self = .init(
        coefficient: Self.usLiquidGallon.coefficient / 4,
        symbol: "US qt"
    )

    /// The U.S. liquid pint unit of volume.
    public static let usLiquidPint: Self = .init(
        coefficient: Self.usLiquidGallon.coefficient / 8,
        symbol: "US pt"
    )

    /// The U.S. customary cup unit of volume.
    public static let usCup: Self = .init(
        coefficient: Self.usLiquidGallon.coefficient / 16,
        symbol: "US cup"
    )

    /// The U.S. gill unit of volume.
    public static let usGill: Self = .init(
        coefficient: Self.usLiquidGallon.coefficient / 32,
        symbol: "US gi"
    )

    /// The U.S. fluid ounce unit of volume.
    public static let usFluidOunce: Self = .init(
        coefficient: Self.usLiquidGallon.coefficient / 128,
        symbol: "US fl oz"
    )

    /// The U.S. tablespoon unit of volume.
    public static let usTablespoon: Self = .init(
        coefficient: Self.usLiquidGallon.coefficient / 256,
        symbol: "US tbsp"
    )

    /// The U.S. teaspoon unit of volume.
    public static let usTeaspoon: Self = .init(
        coefficient: Self.usLiquidGallon.coefficient / 768,
        symbol: "US tsp"
    )

    /// The U.S. fluid dram unit of volume.
    public static let usFluidDram: Self = .init(
        coefficient: Self.usLiquidGallon.coefficient / 1_024,
        symbol: "US fl dr"
    )

    /// The U.S. minim unit of volume.
    public static let usMinim: Self = .init(
        coefficient: Self.usLiquidGallon.coefficient / 61_440,
        symbol: "US min"
    )

    /// The acre-foot unit of volume.
    public static let acreFoot: Self = Area.acre.multiplying(by: .foot)

    // MARK: U.S. Nutrition Labeling Units

    /// The U.S. nutrition-label cup unit of volume.
    public static let usNutritionCup: Self = .init(
        coefficient: 240e-6,
        symbol: "US nutrition cup"
    )

    /// The U.S. nutrition-label fluid ounce unit of volume.
    public static let usNutritionFluidOunce: Self = .init(
        coefficient: 30e-6,
        symbol: "US nutrition fl oz"
    )

    /// The U.S. nutrition-label tablespoon unit of volume.
    public static let usNutritionTablespoon: Self = .init(
        coefficient: 15e-6,
        symbol: "US nutrition tbsp"
    )

    /// The U.S. nutrition-label teaspoon unit of volume.
    public static let usNutritionTeaspoon: Self = .init(
        coefficient: 5e-6,
        symbol: "US nutrition tsp"
    )
}

// MARK: - Codable

extension Volume: Codable {}

// MARK: - Comparable

extension Volume: Comparable {}

// MARK: - Equatable

extension Volume: Equatable {}

// MARK: - Hashable

extension Volume: Hashable {}

// MARK: - Measurable

extension Volume: Measurable {
    public static let base: Self = .cubicMeter
}

// MARK: - Sendable

extension Volume: Sendable {}
