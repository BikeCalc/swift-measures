# ``Measures``

A Swift package for defining, converting, and composing units of measure.

## Overview

Measures provides strongly typed values and units for physical dimensions. It includes SI base and derived units,
metric and binary prefixes, commonly used customary and imperial units, and dimensional composition for related
units such as area, volume, speed, force, energy, and electrical quantities.

Applications can define domain-specific dimensions by creating a unit type that conforms to `Measurable`. Values can
then be represented with `Measure`, converted between compatible units, or converted automatically with `Converted`.

## Topics

### Start Here

- <doc:Installation>
- <doc:PackageArchitecture>

### Articles

- <doc:UnderstandingTheInternationalSystemOfUnits>

### Tutorials

- <doc:/tutorials/Measures/CreatingACustomDimension>

### Converting Values

- ``/CoreMeasureTypes/Measure``
- ``/CoreMeasureTypes/Converted``
- ``/CoreMeasureTypes/Convertible``

### Measuring Values

- ``/CoreMeasureTypes/Measurable``

### Base Units

Dimensions defined by the seven base units of the International System of Units.

- ``/CoreMeasureUnits/ElectricCurrent``
- ``/CoreMeasureUnits/Length``
- ``/CoreMeasureUnits/LuminousIntensity``
- ``/CoreMeasureUnits/Mass``
- ``/CoreMeasureUnits/SubstanceAmount``
- ``/CoreMeasureUnits/ThermodynamicTemperature``
- ``/CoreMeasureUnits/Time``

### Derived Units

Dimensions derived from the base dimensions of the International System of Units.

- ``/CoreMeasureUnits/AbsorbedDose``
- ``/CoreMeasureUnits/Acceleration``
- ``/CoreMeasureUnits/Area``
- ``/CoreMeasureUnits/CatalyticActivity``
- ``/CoreMeasureUnits/Concentration``
- ``/CoreMeasureUnits/ElectricCharge``
- ``/CoreMeasureUnits/ElectricConductance``
- ``/CoreMeasureUnits/ElectricPotential``
- ``/CoreMeasureUnits/ElectricalCapacitance``
- ``/CoreMeasureUnits/ElectricalInductance``
- ``/CoreMeasureUnits/ElectricalResistance``
- ``/CoreMeasureUnits/Energy``
- ``/CoreMeasureUnits/EquivalentDose``
- ``/CoreMeasureUnits/Force``
- ``/CoreMeasureUnits/Frequency``
- ``/CoreMeasureUnits/Illuminance``
- ``/CoreMeasureUnits/LuminousFlux``
- ``/CoreMeasureUnits/MagneticFlux``
- ``/CoreMeasureUnits/MagneticFluxDensity``
- ``/CoreMeasureUnits/MolarMass``
- ``/CoreMeasureUnits/Power``
- ``/CoreMeasureUnits/Pressure``
- ``/CoreMeasureUnits/Radioactivity``
- ``/CoreMeasureUnits/Speed``
- ``/CoreMeasureUnits/SurfaceDensity``
- ``/CoreMeasureUnits/Volume``

### Additional Units

Dimensions provided beyond the International System of Units, including generally useful and community-requested
additions.

- ``/AdditionalMeasureUnits/Cadence``
- ``/AdditionalMeasureUnits/Memory``
