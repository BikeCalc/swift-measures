import Measures

let length: Measure<Length> = .init(4, .meter)
let width: Measure<Length> = .init(300, .centimeter)
let area: Measure<ComposedUnit> = length * width
