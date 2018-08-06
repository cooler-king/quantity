/// Quantity types, units and constants commonly encountered in the fields dealing with
/// electromagnetics.
///
library electromagnetic;

import 'package:quantity/quantity.dart';

export 'package:quantity/quantity.dart'
    show
        elementaryCharge,
        magneticConstant,
        conductanceQuantum,
        vonKlitzingConstant,
        magneticFluxQuantum,
        Charge,
        MagneticFlux,
        Conductance,
        MiscQuantity,
        Resistance,
        Permeability;

/// The quantized unit of electrical conductance.
/// It appears when measuring the conductance of a quantum point contact
// ignore: constant_identifier_names
const Conductance G0 = conductanceQuantum;

/// The inverse of the magnetic flux quantum.
const MiscQuantity josephsonConstant = const MiscQuantity.constant(const Double.constant(483597.8525e9),
    const Dimensions.constant(const <String, int>{'Length': -2, 'Mass': -1, 'Current': 1, 'Time': 2}),
    uncert: 6.2035014930096286e-9);

/// The common symbol for the Josephson constant.
// ignore: constant_identifier_names
const MiscQuantity KJ = josephsonConstant;

/// The common symbol for the von Klitzing constant.
// ignore: constant_identifier_names
const Resistance RK = vonKlitzingConstant;

/// Useful for expressing the magnetic moment of an electron caused by either its orbital or spin angular momentum.
const MiscQuantity bohrMagneton = const MiscQuantity.constant(
    const Double.constant(927.4009994e-26), const Dimensions.constant(const <String, int>{'Length': 2, 'Current': 1}),
    uncert: 6.146208601983096e-9);

/// The common symbol for the Bohr Magneton constant.
const MiscQuantity muB = bohrMagneton;

/// Useful for expressing magnetic dipole moments of heavy particles.
const MiscQuantity nuclearMagneton = const MiscQuantity.constant(
    const Double.constant(5.050783699e-27), const Dimensions.constant(const <String, int>{'Length': 2, 'Current': 1}),
    uncert: 6.137661370479528e-9);

/// The common symbol for the Nuclear Magneton constant.
const MiscQuantity muN = nuclearMagneton;

/// A synonym for the magnetic constant.
const Permeability vacuum = magneticConstant;
