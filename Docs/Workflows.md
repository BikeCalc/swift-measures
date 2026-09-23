# Workflows

Run workflow logic locally using the Swift scripts in `Scripts/`.

## Overview

Workflows define triggers, permissions, runners, checkout, and publishing. Swift scripts handle validation rules,
coverage reports, and documentation generation. Simple commands such as `swift build`, `swift test`, and the formatting
plugin remain directly in the workflows.

Run scripts from the repository root with Swift installed. Scripts accept command-line arguments rather than requiring
GitHub Actions environment variables. They return a nonzero exit status when validation or a subprocess fails.

## BuildDocumentation.swift

Build the combined DocC website:

```shell
swift Scripts/BuildDocumentation.swift
```

This generates the site in `docs/` inside the repository and adds its landing-page redirect after a successful build.
GitHub Pages setup, artifact upload, and deployment remain in the documentation workflow.

## GenerateCodeCoverageReport.swift

Run tests with coverage enabled, then print a Markdown coverage report:

```shell
swift test --enable-code-coverage
swift Scripts/GenerateCodeCoverageReport.swift \
    --report "$(swift test --show-codecov-path)" \
    --sources Sources
```

The first command runs the tests and exports coverage data under `.build/`. The script reads that JSON export and
reports coverage by target and source file, including package-wide totals. Only files beneath the supplied source
directory are included.

The script does not run tests or collect coverage itself. Rerun the tests with coverage enabled to refresh the export.
To save the Markdown output, append `> code-coverage.md` to the script command. GitHub summary updates and artifact
uploads remain in the workflow.

## ValidateBranchRoute.swift

Check whether a source branch is allowed to target a destination branch:

```shell
swift Scripts/ValidateBranchRoute.swift release/1.0.0 feature/example
```

The first argument is the destination branch; the second is the source branch. Any branch may target `main`.
Release branches accept source branches beginning with `feature/`, `bugfix/`, `chore/`, `docs/`, or `test/`.

## ValidateContributors.swift

Check the contributor file against Git history:

```shell
swift Scripts/ValidateContributors.swift
swift Scripts/ValidateContributors.swift main
```

The script compares `CONTRIBUTORS.txt` against history at `HEAD`, or at the optional revision argument. It honors Git's
mailmap, excludes GitHub bot addresses, and prints a diff when the file needs updating. Use a checkout with complete
history, as the workflow does. Validation does not modify the contributor file.

## ValidatePullRequestTitle.swift

Check a title against the repository's Conventional Commit rules:

```shell
swift Scripts/ValidatePullRequestTitle.swift "feat: Add an example"
```

The title is supplied as one quoted argument. It must contain an allowed type, an optional parenthesized scope and
breaking-change marker, and a description after `: `. Invalid titles produce a diagnostic describing the accepted
format and types.

## ValidateTag.swift

Check a release tag:

```shell
swift Scripts/ValidateTag.swift 1.0.0
```

Tags must use three dot-separated ASCII decimal components, with no leading zeros except for a component equal to
zero. Prefixes, prerelease identifiers, and build metadata are not accepted.
