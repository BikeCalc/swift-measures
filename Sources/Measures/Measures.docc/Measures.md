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

### Articles

- <doc:UnderstandingTheInternationalSystemOfUnits>

### Tutorials

- <doc:/tutorials/Measures/CreatingACustomDimension>

### Converting Values

- ``Measure``
- ``Converted``
- ``Convertible``

### Measuring Values

- ``Measurable``

### Base Units

Dimensions defined by the seven base units of the International System of Units.

- ``ElectricCurrent``
- ``Length``
- ``LuminousIntensity``
- ``Mass``
- ``SubstanceAmount``
- ``ThermodynamicTemperature``
- ``Time``

### Derived Units

Dimensions derived from the base dimensions of the International System of Units.

- ``AbsorbedDose``
- ``Acceleration``
- ``Area``
- ``CatalyticActivity``
- ``Concentration``
- ``ElectricCharge``
- ``ElectricConductance``
- ``ElectricPotential``
- ``ElectricalCapacitance``
- ``ElectricalInductance``
- ``ElectricalResistance``
- ``Energy``
- ``EquivalentDose``
- ``Force``
- ``Frequency``
- ``Illuminance``
- ``LuminousFlux``
- ``MagneticFlux``
- ``MagneticFluxDensity``
- ``MolarMass``
- ``Power``
- ``Pressure``
- ``Radioactivity``
- ``Speed``
- ``SurfaceDensity``
- ``Volume``

### Additional Units

Dimensions provided beyond the International System of Units, including generally useful and community-requested
additions.

- ``Cadence``
- ``Memory``
