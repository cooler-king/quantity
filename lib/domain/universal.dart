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
        electricConstant;

const Speed c = speedOfLightVacuum;
const Speed c0 = c;

Permeability mu0 = magneticConstant;

Permittivity eps0 = electricConstant;

Resistance Z0 = characteristicImpedanceOfVacuum;

const MiscQuantity newtonianConstantOfGravitation = const MiscQuantity.constant(
    const Double.constant(6.67408e-11), const Dimensions.constant(const {"length": 3, "mass": -1, "time": -2}),
    uncert: 4.7e-5);

const MiscQuantity G = newtonianConstantOfGravitation;

const AngularMomentum h = planckConstant;

const WaveNumber rydberg = const WaveNumber.constant(const Double.constant(10973731.568508), uncert: 5.9e-12);
