# Package Architecture

Understand how the targets in Measures are organized and how they depend on one another.

## Overview

Measures separates its core measure types from its core and additional units. Core measure types provide measures, unit
protocols, physical dimensions, and conversion to a fixed unit. Core measure units provide predefined SI-compatible base
and derived units, composed units, and dimensional arithmetic. Additional measure units extend the package with units
outside that collection. The macro targets generate units with consistent prefixes. An optional target provides
Foundation integration for locale-aware formatting of measures.

The package also contains a command plugin and three test targets. These targets support development and validation
without becoming part of the public library product.

## Package Tooling

The linter plugin invokes Swift Format, while each test target checks its corresponding library and macro behavior.

```text
MeasuresFoundationUnitTests
└─> depends on Measures and MeasuresFoundation

MeasuresLinterPlugin
└─> invokes swift-format

MeasuresMacroTests
└─> depends on Measures and MeasuresMacroPlugin

MeasuresUnitTests
└─> depends on Measures
```

## Library Targets

`Measures` collects the public source targets into the package's library, while the individual targets preserve those
architectural boundaries internally. The macro plugin remains a build-time implementation detail.

`Measures` re-exports `MeasuresFoundation` when `canImport(Foundation)` succeeds. Foundation itself is not re-exported,
so applications import Foundation explicitly when referring to its types.

```text
                            +-------------------------+
                            |        Measures         |
                            +------------+------------+
                                         |
                           +-------------+-------------+
                           |                           |
                           v                           v
              +-------------------------+ +-------------------------+
              | AdditionalMeasureUnits  | |   MeasuresFoundation    |
              +------------+------------+ +------------+------------+
                           |                           |
                           v                           |
              +-------------------------+              |
              |    CoreMeasureUnits     |              |
              +------------+------------+              |
                           |                           |
             +-------------+-------------+             |
             |                           |             |
             v                           |             |
+-------------------------+              |             |
|      MeasuresMacro      |              |             |
+------------+------------+              |             |
             |                           |             |
             v                           |             |
+-------------------------+              |             |
|   MeasuresMacroPlugin   |              |             |
+------------+------------+              |             |
             |                           |             |
             +------------>+<------------+<------------+
                           |
                           v
              +-------------------------+
              |    CoreMeasureTypes     |
              +-------------------------+
```

Read each arrow from a target to one of its direct dependencies. Some direct edges are omitted to keep the routes
readable, so the absence of an arrow does not prove that two targets are unrelated. Vertical placement keeps the
dependency flow clear rather than assigning targets to semantic tiers; consult the package manifest for the complete,
authoritative definitions.
