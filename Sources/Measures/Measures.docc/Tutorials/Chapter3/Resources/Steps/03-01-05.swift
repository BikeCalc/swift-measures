import Foundation
import Measures

let measure: Measure<Length> = .init(1_234.5, .meter)
let formatter: Measure<Length>.FormatStyle = .measure()

print(measure.formatted(formatter))
// Prints "1,234.5 m" when the current locale is en_US.
