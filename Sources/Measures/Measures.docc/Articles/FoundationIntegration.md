# Foundation Integration

Format Measures values using Foundation's formatting APIs.

## Overview

Foundation Integration adds locale-aware formatting to `Measure`. It combines Foundation's numeric formatting with the
measure's existing unit symbol, allowing measures to participate in APIs that accept a Foundation `FormatStyle`.

## Using the Integration

Add the `Measures` product to your target's dependencies and import `Measures`. The formatting APIs are included when
Foundation is available; no separate integration product or import is required. Import `Foundation` when referring to
its types, such as `Locale`.

The formatting declarations require macOS 12, iOS 15, tvOS 15, or watchOS 8 or later, subject to the package's
deployment requirements. They are unavailable on platforms where Foundation cannot be imported.

## Supported Capabilities

- ``/FoundationIntegration/Formattable`` provides default formatting and formatting with an explicit style.
- `Measure` conforms to `Formattable`, providing `formatted()` and `formatted(_:)`.
- ``/FoundationIntegration/MeasureFormatStyle`` formats a measure's numeric value and unit symbol. Its numeric style
  controls precision, rounding, grouping, and locale.
- Foundation's `FormatStyle.measure(numberFormatStyle:)` factory provides a shorthand for creating a measure style.

See ``/FoundationIntegration/MeasureFormatStyle`` for a usage example and the available configuration.

## Behavior and Limitations

Default formatting follows the current locale. An explicit locale changes the numeric presentation, while the unit
symbol remains unchanged. A nonempty symbol is separated from the number by a nonbreaking space; an empty symbol
produces only the formatted number.

Formatting preserves the stored value and unit. It does not convert units, canonicalize composed units, or localize
unit symbols. Convert or canonicalize a measure before formatting when a different representation is needed.

Measures whose `isNaT` property is true produce `NaT` without a number or unit symbol. Other values are formatted even
when they fall outside the unit's valid range. The integration provides formatting, not parsing.
