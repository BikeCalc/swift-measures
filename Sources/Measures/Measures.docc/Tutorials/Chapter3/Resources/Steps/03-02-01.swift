import Foundation
import Measures

let measure: Measure<Length> = .nat
let formatter: Measure<Length>.FormatStyle = .measure()

print(measure.formatted(formatter))
// Prints "NaT"
