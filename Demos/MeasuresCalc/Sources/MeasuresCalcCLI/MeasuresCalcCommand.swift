// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import ArgumentParser
import MeasuresCalc

/// The command-line entry point for arithmetic, unit conversion, and linear equation solving.
@main
internal struct MeasuresCalcCommand {
    /// The expression or equation supplied on the command line, required unless listing units.
    @Argument(help: "An arithmetic expression or linear equation. Required unless using --list-units.")
    internal var expression: String?

    /// The optional destination unit expression selected with `--convert-to`.
    @Option(
        name: .customLong("convert-to"),
        help: "The desired output unit, such as m or m/s."
    )
    internal var outputUnit: String?

    /// The optional unknown identifier selected with `--solve`.
    @Option(
        name: .long,
        help: "Solve a linear equation for this unknown, such as x."
    )
    internal var solve: String?

    /// A boolean value indicating whether to print registered symbols instead of evaluating an expression.
    @Flag(
        name: .long,
        help: "List the supported case-sensitive unit symbols."
    )
    internal var listUnits: Bool = false

    /// Creates a command with its default argument values.
    internal init() {}
}

// MARK: - ParsableCommand

extension MeasuresCalcCommand: ParsableCommand {
    internal static let configuration: CommandConfiguration = .init(
        commandName: "measures-calc",
        abstract: "Evaluating expressions, convert units, and solve linear equations with measurements.",
        discussion: """
            Put the expression first, in quotes, followed by any options.

            Examples:
              measures-calc "2 + 3 * 4"
              measures-calc "2 m * 300 cm"
              measures-calc "36 km/h" --convert-to "m/s"
              measures-calc "(2 m)^3"
              measures-calc "2 * x + 30 cm = 1 m" --solve "x" --convert-to "cm"
            """
    )

    internal mutating func run() throws {
        let calculator: Calculator = .init()

        if self.listUnits {
            print(calculator.supportedUnits.joined(separator: ", "))
            return
        }

        guard let expression: String = self.expression else {
            throw ValidationError("Provide a quoted expression or equation, or use --list-units to list units.")
        }

        do {
            if let variable: String = self.solve {
                let result: CalculationResult = try calculator.solve(
                    expression,
                    for: variable,
                    to: self.outputUnit
                )

                print("\(variable) = \(result)")
            } else {
                let result: CalculationResult = try calculator.evaluate(
                    expression,
                    to: self.outputUnit
                )
                print(result)
            }
        } catch let error as CalculationError {
            throw ValidationError(error.description)
        }
    }
}
