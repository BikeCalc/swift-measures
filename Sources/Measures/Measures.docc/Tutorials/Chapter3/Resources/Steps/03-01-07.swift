import Foundation
import Measures

let measure: Measure<Length> = .init(1234.5, .meter)
let formatter: Measure<Length>.FormatStyle = .measure(
    numberFormatStyle: .number.precision(.fractionLength(2))
)
let locale: Locale = .init(identifier: "fr_FR")

print(measure.formatted(formatter))
// Prints "1,234.50 m" when the current locale is en_US.
