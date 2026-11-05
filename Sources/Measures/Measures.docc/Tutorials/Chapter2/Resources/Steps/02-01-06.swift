import Measures

let length: Measure<Length> = .init(4, .meter)
let width: Measure<Length> = .init(300, .centimeter)
let area: Measure<ComposedUnit> = length * width

print(area)
// Prints "12.0 m·m"

var areaUnit: ComposedUnit = area.unit
