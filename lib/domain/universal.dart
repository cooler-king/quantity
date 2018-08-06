/// Quantity types and constants with universal application.
///
library universal;

import 'package:quantity/quantity.dart';

export 'package:quantity/quantity.dart'
    show
        characteristicImpedanceOfVacuum,
        speedOfLightVacuum,
        magneticConstant,
        planckConstant,
        hBar,
        planckLength,
        planckMass,
        planckTemperature,
        planckTime,
        electricConstant,
        Length,
        Mass,
        Speed,
        Permeability,
        Permittivity,
        Resistance,
        Temperature,
        Time,
        MiscQuantity,
        AngularMomentum,
        WaveNumber;

/// The symbol for the speed of light constant.
const Speed c = speedOfLightVacuum;

/// An alternative symbol for the speed of light constant.
const Speed c0 = c;

/// The symbol for the magnetic constant.
Permeability mu0 = magneticConstant;

/// The symbol for the electric constant.
Permittivity eps0 = electricConstant;

/// The symbol for the characteristic impedance of vacuum.
// ignore: non_constant_identifier_names
Resistance Z0 = characteristicImpedanceOfVacuum;

/// An empirical physical constant involved in the calculation of gravitational effects.
const MiscQuantity newtonianConstantOfGravitation = const MiscQuantity.constant(const Double.constant(6.67408e-11),
    const Dimensions.constant(const <String, int>{'Length': 3, 'Mass': -1, 'Time': -2}),
    uncert: 4.64483494354278e-5);

/// The symbol for the Newtonian constant of gravitation.
const MiscQuantity G = newtonianConstantOfGravitation;

/// The symbol for the Planck constant.
const AngularMomentum h = planckConstant;

/// Appears in the Balmer formula for spectral lines of the hydrogen atom. For a hydrogen atom, the effective mass
/// must be taken as the reduced mass of the proton and electron. In MKS, this gives the Rydberg constant.
const WaveNumber rydberg =
    const WaveNumber.constant(const Double.constant(10973731.568508), uncert: 5.92323582859768e-12);
