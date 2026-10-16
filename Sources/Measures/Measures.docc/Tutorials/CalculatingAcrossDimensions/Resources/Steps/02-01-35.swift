import Measures

let length: Measure<Length> = .init(4, .meter)
let width: Measure<Length> = .init(300, .centimeter)
let area: Measure<ComposedUnit> = length * width

print(area)
// Prints "12.0 m·m"

@Canonicalized
var areaUnit: ComposedUnit = area.unit

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

@Converted(to: .coherent)
var volume: Measure<ComposedUnit> = area * height

print(volume)
// Prints "30.0 m³"

let namedVolume: Measure<Volume> = volume.converted(to: .cubicMeter)

print(namedVolume)
// Prints "30.0 m³"

let recoveredArea: Measure<ComposedUnit> = volume / height

print(recoveredArea)
// Prints "12.0 m³·m⁻¹"

print(recoveredArea.isCanonicallyEqual(to: area))
// Prints "true"

let recoveredNamedArea: Measure<Area> = recoveredArea.converted(to: .squareMeter)

print(recoveredNamedArea)
// Prints "12.0 m²"

print(recoveredNamedArea == namedArea)
// Prints "true"

let recoveredLength: Measure<ComposedUnit> = recoveredArea / width

print(recoveredLength)
// Prints "4.0 m²·m⁻¹"

print(recoveredLength.isCanonicallyEqual(to: length))
// Prints "true"

let recoveredNamedLength: Measure<Length> = recoveredLength.converted(to: .meter)

print(recoveredNamedLength)
// Prints "4.0 m"

print(recoveredNamedLength == length)
// Prints "true"

let squaredLength: Measure<ComposedUnit> = length ** 2

print(squaredLength)
// Prints "16.0 m²"

let namedSquaredLength: Measure<Area> = squaredLength.converted(to: .squareMeter)

print(namedSquaredLength)
// Prints "16.0 m²"
