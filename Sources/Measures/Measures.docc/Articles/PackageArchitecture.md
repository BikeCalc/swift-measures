# Package Architecture

Understand how the targets in Measures are organized and how they depend on one another.

## Overview

Measures separates its core measure types from its core and additional units. Core measure types form the foundation;
core measure units provide the base and derived dimensions above them, and additional measure units extend the package
with dimensions outside that primary collection. The macro targets generate consistently prefixed unit families.

The package also contains a command plugin and two test targets. These targets support development and validation
without becoming part of the public library product.

## Package Tooling

The linter plugin invokes Swift Format, while each test target checks its corresponding library and macro behavior.

```text
MeasuresLinterPlugin
└─> invokes swift-format

MeasuresMacroTests
└─> depends on Measures and MeasuresMacroPlugin

MeasuresTests
└─> depends on Measures
```

## Library Targets

`Measures` collects the public source targets into the package's library, while the individual targets preserve those
architectural boundaries internally. The macro plugin remains a build-time implementation detail.

```text
              +-------------------------+
              |        Measures         |
              +------------+------------+
                           |
                           v
              +-------------------------+
              | AdditionalMeasureUnits  |
              +------------+------------+
                           |
                           v
              +-------------------------+
              |    CoreMeasureUnits     |
              +------------+------------+
                           |
             +-------------+-------------+
             |                           |
             v                           |
+-------------------------+              |
|      MeasuresMacro      |              |
+------------+------------+              |
             |                           |
             v                           |
+-------------------------+              |
|   MeasuresMacroPlugin   |              |
+------------+------------+              |
             |                           |
             +------------>+<------------+
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
