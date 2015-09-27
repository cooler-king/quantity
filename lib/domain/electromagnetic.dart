/// Quantity types, units and constants commonly encountered in the fields dealing with
/// electromagnetics
///
library electromagnetic;

import 'package:quantity/quantity.dart';

export 'package:quantity/quantity.dart'
    show
        elementaryCharge,
        magneticConstant,
        conductanceQuantum,
        vonKlitzingConstant,
        Charge,
        MagneticFlux,
        Conductance,
        MiscQuantity,
        Resistance,
        Permeability;

const MagneticFlux magneticFluxQuantum =
    const MagneticFlux.constant(const Double.constant(2.067833831e-15), uncert: 6.1e-9);

const Conductance G0 = conductanceQuantum;

const MiscQuantity josephsonConstant = const MiscQuantity.constant(const Double.constant(483597.8525e9),
    const Dimensions.constant(const {"Length": -2, "Mass": -1, "Current": 1, "Time": 2}),
    uncert: 6.1e-9);
const MiscQuantity KJ = josephsonConstant;

const Resistance RK = vonKlitzingConstant;

const MiscQuantity bohrMagneton = const MiscQuantity.constant(
    const Double.constant(927.4009994e-26), const Dimensions.constant(const {"Length": 2, "Current": 1}),
    uncert: 6.2e-9);
const MiscQuantity muB = bohrMagneton;

const MiscQuantity nuclearMagneton = const MiscQuantity.constant(
    const Double.constant(5.050783699e-27), const Dimensions.constant(const {"Length": 2, "Current": 1}),
    uncert: 6.2e-9);
const MiscQuantity muN = nuclearMagneton;

const Permeability vacuum = magneticConstant;
