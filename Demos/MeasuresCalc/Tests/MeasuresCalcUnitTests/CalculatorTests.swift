// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Testing

@testable import MeasuresCalc

@Suite("Calculator Tests")
internal struct CalculatorTests {
    private let accuracy: Double = 1e-10

    @Test(
        "Evaluates expressions",
        arguments: [
            ("2 + 3 * 4", nil, 14.0, ""),
            ("(2 m) * (300 cm)", "m²", 6.0, "m²"),
            ("(2 m) * (300 cm) * (4 m)", "m³", 24.0, "m³"),
            ("24 m³ / (4 m)", "m²", 6.0, "m²"),
            ("6 m² / (300 cm)", "m", 2.0, "m"),
            ("36 km/h", "m/s", 10.0, "m·s⁻¹"),
            ("1 km/h^2", "m/s^2", 1000.0 / (3600 * 3600), "m·s⁻²"),
            ("2 m^2", nil, 2.0, "m²"),
            ("2^2 m", nil, 4.0, "m"),
            ("(2 m)^2", nil, 4.0, "m²"),
            ("(2 m)^3", nil, 8.0, "m³"),
            ("(2 m)^0", nil, 1.0, ""),
            ("(2 m)^1", nil, 2.0, "m"),
            ("(2 m)^-2", nil, 0.25, "m⁻²"),
            ("2 m·s⁻²", nil, 2.0, "m·s⁻²"),
            ("0^0", nil, 1.0, ""),
            ("2^(200 cm/m)", nil, 4.0, ""),
            ("1 m + 30 cm", "cm", 130.0, "cm"),
            ("1 m - 30 cm", "cm", 70.0, "cm"),
            ("1,000.5 m + 1_000.5 m", nil, 2001.0, "m"),
            ("10 °C", "°F", 50.0, "°F"),
            ("-10 °C", "K", 263.15, "K"),
            ("0 °C + 0 °C", "°C", 0.0, "°C"),
            ("10 °C - 20 °C", "°C", -10.0, "°C"),
            ("(10 °C) * (2 s)", nil, 566.3, "s·K"),
            ("(10 °C) / (2 s)", nil, 141.575, "s⁻¹·K"),
            ("(10 °C)^2", nil, 80173.9225, "K²"),
            ("(10 °F) * (10 min)", nil, (10.0 + 459.67) * 5 / 9 * 600, "s·K"),
            ("-1000 K", nil, -1000.0, "K"),
            ("1 N * 2 m", "J", 2.0, "J"),
            ("1e-300 * 1e-300", nil, 0.0, "")
        ] as Array<(String, String?, Double, String)>
    )
    internal func evaluatesExpression(
        _ expression: String,
        _ output: String?,
        _ expected: Double,
        _ symbol: String
    ) throws {
        let calculator: Calculator = .init()
        let result: CalculationResult = try calculator.evaluate(
            expression,
            to: output
        )

        #expect(abs(result.value - expected) <= self.accuracy * max(1, abs(expected)))
        #expect(result.unit == symbol)
    }

    @Test(
        "Solves equations",
        arguments: [
            ("2 * x + 30 cm = 1 m", "cm", 35.0),
            ("x * 2 s = 10 m", "m/s", 5.0),
            ("x / 2 = 3 m", "m", 6.0),
            ("x m = 2 m", nil, 2.0),
            ("x + 2 K = 300 K", "K", 298.0)
        ] as Array<(String, String?, Double)>
    )
    internal func solvesEquation(
        _ expression: String,
        _ output: String?,
        _ expected: Double
    ) throws {
        let calculator: Calculator = .init()
        let result: CalculationResult = try calculator.solve(
            expression,
            to: output
        )

        #expect(abs(result.value - expected) < self.accuracy)
    }

    @Test(
        "Rejects invalid expressions",
        arguments: [
            ("1 m + 1 s", nil, CalculationError.Code.incompatibleDimensions),
            ("1 m", "s", .incompatibleDimensions),
            ("1 m", "2 m", .invalidOutputUnit),
            ("°C * s", nil, .invalidUnit),
            ("10 °C^2", nil, .invalidUnit),
            ("1 K", "°C/s", .invalidUnit),
            ("(1 m)^0.5", nil, .invalidPower),
            ("2^(cm/m)", nil, .invalidPower),
            ("(1 m)^(2 s)", nil, .invalidPower),
            ("(m^64)^64", nil, .limitExceeded),
            ("m^64 * m", nil, .limitExceeded),
            ("1 / 0", nil, .nonFiniteResult),
            ("0^-1", nil, .nonFiniteResult),
            ("1e308 * 1e308", nil, .nonFiniteResult),
            ("(1 m", nil, .invalidSyntax),
            ("1 m +", nil, .invalidSyntax),
            ("1 unknown", nil, .unknownIdentifier),
            ("1 meter", nil, .unknownIdentifier),
            ("1 m⁻", nil, .invalidSyntax)
        ] as Array<(String, String?, CalculationError.Code)>
    )
    internal func rejectsInvalidExpression(
        _ expression: String,
        _ output: String?,
        _ expected: CalculationError.Code
    ) {
        do {
            let calculator: Calculator = .init()
            _ = try calculator.evaluate(
                expression,
                to: output
            )

            Issue.record("Expected a calculation diagnostic.")
        } catch let error as CalculationError {
            #expect(error.code == expected)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test(
        "Rejects unsupported or inconsistent equations",
        arguments: [
            ("x * x = 4", CalculationError.Code.unsupportedEquation),
            ("1 / x = 4", .unsupportedEquation),
            ("x °C = 10 °C", .unsupportedEquation),
            ("x + 10 °C = 300 K", .unsupportedEquation),
            ("x + 1 m = x + 1 s", .incompatibleDimensions),
            ("x = x", .infiniteSolutions),
            ("x + 1 m = x + 2 m", .noSolution)
        ]
    )
    internal func rejectsUnsupportedOrInconsistentEquation(
        _ expression: String,
        _ expected: CalculationError.Code
    ) {
        do {
            let calculator: Calculator = .init()
            _ = try calculator.solve(expression)

            Issue.record("Expected an equation diagnostic.")
        } catch let error as CalculationError {
            #expect(error.code == expected)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }
}
