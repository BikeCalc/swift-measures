# ``CoreMeasureTypes/Measure``

## Topics

### Creating Measures

- ``init(_:_:)-3zs2p``
- ``init(_:_:)-8g4nb``

### Measure Properties

- ``value``
- ``unit``

### Validating Measures

- ``isValid``

### Converting Measures

- ``converted(to:)->Measure<UnitType>``
- ``convert(to:)``

### Adding Values

- ``Addend``
- ``Sum``
- ``+(_:_:)``
- ``+=(_:_:)``
- ``adding(_:)``
- ``add(_:)``

### Subtracting Values

- ``Subtrahend``
- ``Difference``
- ``-(_:_:)``
- ``-=(_:_:)``
- ``subtracting(_:)``
- ``subtract(_:)``

### Multiplying Values

- ``Multiplier``
- ``Product``
- ``*(_:_:)->Measure<UnitType>.Product``
- ``*=(_:_:)``
- ``multiplying(by:)``
- ``multiply(by:)``

### Dividing Values

- ``Divisor``
- ``Quotient``
- ``Measure//(_:_:)->Measure<UnitType>.Quotient``
- ``/=(_:_:)``
- ``dividing(by:)``
- ``divide(by:)``

### Calculating Remainders

- ``RemainderDivisor``
- ``Remainder``
- ``%(_:_:)``
- ``%=(_:_:)``

### Inspecting Values

- ``isInvertible``
- ``reciprocal``
- ``isDivisible(by:)``
- ``isMultiple(of:)``
- ``isFactor(of:)``

### Comparing Values

- ``AbsoluteTolerance``
- ``RelativeTolerance``
- ``isApproximatelyEqual(to:absoluteTolerance:relativeTolerance:)``
- ``isCanonicallyEqual(to:)``
- ``==(_:_:)``
- ``<(_:_:)``
- ``<=(_:_:)``
- ``>(_:_:)``
- ``>=(_:_:)``

### Describing Values

- ``description``
- ``debugDescription``

### Encoding and Decoding

- ``init(from:)``
- ``encode(to:)``

### Hashing Values

- ``hash(into:)``
