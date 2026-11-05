// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import Measures

extension UnitRegistry {
    /// Every predefined composable unit, excluding duplicate base aliases.
    internal static var definitions: Array<UnitToken> {
        var definitions: Array<UnitToken> = []

        definitions.append(contentsOf: ElectricCurrent.allCases.map { .init($0) })
        definitions.append(contentsOf: Length.allCases.map { .init($0) })
        definitions.append(contentsOf: LuminousIntensity.allCases.map { .init($0) })
        definitions.append(contentsOf: Mass.allCases.map { .init($0) })
        definitions.append(contentsOf: SubstanceAmount.allCases.map { .init($0) })
        definitions.append(contentsOf: ThermodynamicTemperature.allCases.map { .init($0) })
        definitions.append(contentsOf: Time.allCases.map { .init($0) })
        definitions.append(contentsOf: AbsorbedDose.allCases.map { .init($0) })
        definitions.append(contentsOf: Acceleration.allCases.map { .init($0) })
        definitions.append(contentsOf: Area.allCases.map { .init($0) })
        definitions.append(contentsOf: CatalyticActivity.allCases.map { .init($0) })
        definitions.append(contentsOf: Concentration.allCases.map { .init($0) })
        definitions.append(contentsOf: ElectricCharge.allCases.map { .init($0) })
        definitions.append(contentsOf: ElectricConductance.allCases.map { .init($0) })
        definitions.append(contentsOf: ElectricPotential.allCases.map { .init($0) })
        definitions.append(contentsOf: ElectricalCapacitance.allCases.map { .init($0) })
        definitions.append(contentsOf: ElectricalInductance.allCases.map { .init($0) })
        definitions.append(contentsOf: ElectricalResistance.allCases.map { .init($0) })
        definitions.append(contentsOf: Energy.allCases.map { .init($0) })
        definitions.append(contentsOf: EquivalentDose.allCases.map { .init($0) })
        definitions.append(contentsOf: Force.allCases.map { .init($0) })
        definitions.append(contentsOf: Frequency.allCases.map { .init($0) })
        definitions.append(contentsOf: Illuminance.allCases.map { .init($0) })
        definitions.append(contentsOf: LuminousFlux.allCases.map { .init($0) })
        definitions.append(contentsOf: MagneticFlux.allCases.map { .init($0) })
        definitions.append(contentsOf: MagneticFluxDensity.allCases.map { .init($0) })
        definitions.append(contentsOf: MolarMass.allCases.map { .init($0) })
        definitions.append(contentsOf: Power.allCases.map { .init($0) })
        definitions.append(contentsOf: Pressure.allCases.map { .init($0) })
        definitions.append(contentsOf: Radioactivity.allCases.map { .init($0) })
        definitions.append(contentsOf: Speed.allCases.map { .init($0) })
        definitions.append(contentsOf: SurfaceDensity.allCases.map { .init($0) })
        definitions.append(contentsOf: Volume.allCases.map { .init($0) })

        return definitions
    }
}
