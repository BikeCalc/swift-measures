# Testing

Run tests and inspect code coverage.

## Overview

The unit test runner executes the library and demo tests with coverage enabled and generates separate reports for
both packages. CI and local runs use the same scripts. The report shows which source code was
exercised; it does not establish assertion quality.

## Requirements

Use Swift 6.3 or later; CI runs on macOS 26. Run commands from the repository root. Package resolution needs network
access when dependencies are not cached.

## Continuous Integration

The [Unit Tests workflow](/.github/workflows/unit-tests.yml) runs on pushes to `main` and pull requests targeting `main`
or `release/**` when opened, reopened, or updated. Its `Run Unit Tests` job invokes the runner below, appends the
coverage report to the GitHub Actions summary, and uploads `.build/code-coverage/` as the `code-coverage` artifact. Test
or report-generation failures fail the job. New runs cancel superseded runs for the same branch or pull request.

## Unit Test Runner

[RunUnitTests.swift](/Scripts/RunUnitTests.swift) runs the tests and generates the report:

```shell
swift Scripts/RunUnitTests.swift
```

The runner executes `swift test --enable-code-coverage` at the repository root, followed by
`swift test --package-path Demos/MeasuresCalc --enable-code-coverage`. A failure in either package fails the run.
It locates each package's coverage JSON and invokes `GenerateCodeCoverageReport.swift` with that package's source
directory, keeping dependency sources out of the Markdown report.

The runner saves `measures.json`, `measures.md`, `measures-calc.json`, and `measures-calc.md` in
`.build/code-coverage/`. Test output goes to standard error; standard output contains both Markdown reports labelled
Measures and Measures Calc. The existing workflow includes both in its summary and uploads the coverage directory. Test
or report-generation failures fail the script.

To run tests individually without generating a coverage report, use `swift test` for the library or
`swift test --package-path Demos/MeasuresCalc` for the demo. The demo is a separate Swift package, so testing the root
package does not run its tests. In Xcode, open the demo package and select its test scheme to run its tests.

## Code Coverage Report Script

[GenerateCodeCoverageReport.swift](/Scripts/GenerateCodeCoverageReport.swift) regenerates the report from existing
coverage data without rerunning tests:

```shell
swift Scripts/GenerateCodeCoverageReport.swift \
    --report "$(swift test --show-codecov-path)" \
    --sources Sources
```

For the demo report, use:

```shell
swift Scripts/GenerateCodeCoverageReport.swift \
    --report "$(swift test --package-path Demos/MeasuresCalc --show-codecov-path)" \
    --sources Demos/MeasuresCalc/Sources
```

First run `RunUnitTests.swift`, or collect coverage with `swift test --enable-code-coverage`. The generator reads the
JSON export and reports coverage by target and source file, including package-wide totals. Only files beneath the
supplied source directory are included. It does not run tests or collect coverage itself.
