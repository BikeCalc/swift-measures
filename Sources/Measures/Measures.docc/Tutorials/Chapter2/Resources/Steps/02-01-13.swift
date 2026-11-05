import Measures

let length: Measure<Length> = .init(4, .meter)
let width: Measure<Length> = .init(300, .centimeter)
let area: Measure<ComposedUnit> = length * width

print(area)
// Prints "12.0 m·m"

@Canonicalized var areaUnit: ComposedUnit = area.unit

print(areaUnit.symbol)
// Prints "m²"

print(areaUnit == area.unit)
// Prints "false"

print(areaUnit.isCanonicallyEqual(to: area.unit))
// Prints "true"

let namedArea: Measure<Area> = area.converted(to: .squareMeter)

print(namedArea)
// Prints "12.0 m²"

let height: Measure<Length> = .init(2.5, .meter)
