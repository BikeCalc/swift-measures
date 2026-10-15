# ``CoreMeasureUnits/ComposedUnit``

## Topics

### Creating Units

- ``init(_:)``

### Unit Properties

- ``coefficient``
- ``constant``
- ``symbol``
- ``dimension``
- ``validRange``

### Multiplying Units

- ``*(_:_:)``

### Dividing Units

- ``ComposedUnit//(_:_:)``

### Raising Units to Powers

- ``**(_:_:)``

### Canonicalization

- ``simplified()``
- ``normalized()``
- ``canonicalized()``
- ``canonicalize()``
- ``isCanonicalizable``
- ``isCanonicalized``

### Encoding and Decoding

- ``init(from:)``
- ``encode(to:)``

### Comparing Units

- ``==(_:_:)``
- ``isCanonicallyEqual(to:)``
- ``isCompatible(with:)``

### Hashing Units

- ``hash(into:)``
