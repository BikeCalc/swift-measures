// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Foundation
import Testing

@Suite("Calculator Command Tests")
internal struct CalculatorCommandTests {
    private typealias CommandResult = (
        status: Int32,
        output: String,
        error: String
    )

    @Test(
        "Runs README calculations",
        arguments: [
            (["2 + 3 * 4"], "14.0\n"),
            (["2 m * 300 cm"], "6.0 m²\n"),
            (["36 km/h", "--convert-to", "m/s"], "10.0 m·s⁻¹\n"),
            (["(2 m)^3"], "8.0 m³\n"),
            (["2 * x + 30 cm = 1 m", "--solve", "x", "--convert-to", "cm"], "x = 35.0 cm\n"),
            (["(-2 m)", "--convert-to", "cm"], "-200.0 cm\n")
        ]
    )
    internal func runsREADMECalculations(
        _ arguments: Array<String>,
        _ expected: String
    ) throws {
        let result: Self.CommandResult = try self.run(arguments)

        #expect(result.status == 0)
        #expect(result.output == expected)
        #expect(result.error.isEmpty == true)
    }

    @Test("Displays help without an expression")
    internal func displaysHelp() throws {
        let result: Self.CommandResult = try self.run(["--help"])

        #expect(result.status == 0)
        #expect(result.output.contains("USAGE: measures-calc") == true)
        #expect(result.output.contains("--convert-to") == true)
        #expect(result.output.contains("--solve") == true)
        #expect(result.output.contains("--list-units") == true)
        #expect(result.error.isEmpty == true)
    }

    @Test("Lists units without an expression")
    internal func listsUnits() throws {
        let result: Self.CommandResult = try self.run(["--list-units"])
        let symbols: Array<String> = result.output.trimmingCharacters(in: .newlines).components(separatedBy: ", ")

        #expect(result.status == 0)

        for symbol in ["m", "cm", "km", "h", "s"] {
            #expect(symbols.contains(symbol) == true)
        }

        #expect(result.error.isEmpty == true)
    }

    @Test(
        "Rejects invalid invocations",
        arguments: [
            [],
            ["--unknown-option"],
            ["1 m + 1 s"]
        ] as Array<Array<String>>
    )
    internal func rejectsInvalidInvocations(_ arguments: Array<String>) throws {
        let result: Self.CommandResult = try self.run(arguments)

        #expect(result.status != 0)
        #expect(result.output.isEmpty == true)
        #expect(result.error.contains("Error:") == true)
    }

    private func run(_ arguments: Array<String>) throws -> Self.CommandResult {
        let process: Process = .init()
        let output: Pipe = .init()
        let error: Pipe = .init()

        process.executableURL = try URL.measuresCalcExecutable()
        process.arguments = arguments
        process.standardInput = FileHandle.nullDevice
        process.standardOutput = output
        process.standardError = error

        try process.run()

        let outputData: Data = output.fileHandleForReading.readDataToEndOfFile()
        let errorData: Data = error.fileHandleForReading.readDataToEndOfFile()

        process.waitUntilExit()

        return (
            status: process.terminationStatus,
            output: String(
                decoding: outputData,
                as: UTF8.self
            ),
            error: String(
                decoding: errorData,
                as: UTF8.self
            )
        )
    }
}
