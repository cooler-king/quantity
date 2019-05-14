/// Quantity types, units and constants commonly encountered in the field of
/// thermodynamics and related sciences.
///
library thermodynamic;

import 'package:quantity/quantity.dart';

export 'package:quantity/quantity.dart'
    show
        unifiedAtomicMassUnits,
        boltzmannUnit,
        boltzmannConstant,
        sackurTetrode100kPa,
        sackurTetrodeStdAtm,
        Entropy,
        EntropyUnits,
        MiscQuantity,
        MassUnits,
        Scalar;

// CONSTANTS

/// Avogadro's Number ('NA' or 'L')
const MiscQuantity avogadro = const MiscQuantity.constant(
    const Double.constant(6.022140857e23), const Dimensions.constant(const <String, int>{'Amount': -1}),
    uncert: 1.2287988899161014e-8);

/// The common symbol for Avogadro's Number.
// ignore: constant_identifier_names
const MiscQuantity NA = avogadro;

/// An alternative symbol for Avogadro's Number.
// ignore: constant_identifier_names
const MiscQuantity L = avogadro;

/// Boltzmann constant ('k')
Entropy k = boltzmannConstant;

/// Faraday constant ('F')
const MiscQuantity faradayConstant = const MiscQuantity.constant(const Double.constant(96485.33289),
    const Dimensions.constant(const <String, int>{'Current': 1, 'Time': 1, 'Amount': -1}),
    uncert: 6.114919048604424e-9);

/// First Radiation Constant ('c1')
const MiscQuantity firstRadiationConstant = const MiscQuantity.constant(const Double.constant(3.741771790e-16),
    const Dimensions.constant(const <String, int>{'Length': 3, 'Mass': 1, 'Time': -3}),
    uncert: 1.2293641243150215e-8);

/// Locshmidt Constant ('n0') at 273.15 K and 101.325 kPa
const MiscQuantity loschmidtStdAtm = const MiscQuantity.constant(
    const Double.constant(2.6867811e25), const Dimensions.constant(const <String, int>{'Length': -3}),
    uncert: 5.582888758596672e-7);

/// Molar Gas Constant ('R')
const MolarEntropy gasConstantMolar =
    const MolarEntropy.constant(const Double.constant(8.3144598), uncert: 5.773074998811107e-7);

/// Molar Planck Constant ('Nah')
const MiscQuantity molarPlanck = const MiscQuantity.constant(const Double.constant(3.9903127110e-10),
    const Dimensions.constant(const <String, int>{'Length': 2, 'Mass': 1, 'Time': -1, 'Amount': 1}),
    uncert: 4.5109246577041013e-10);

/// Molar Volume of Ideal Gas at 273.15 K and 100 kPa ('Vm')
const MiscQuantity molarVolume100kPa = const MiscQuantity.constant(
    const Double.constant(22.710947e-3), const Dimensions.constant(const <String, int>{'Length': 3, 'Amount': -1}),
    uncert: 5.724111812686631e-7);

/// Molar Volume of Ideal Gas at 273.15 K and 101.325 kPa ('Vm')
const MiscQuantity molarVolumeStdAtm = const MiscQuantity.constant(
    const Double.constant(22.413962e-3), const Dimensions.constant(const <String, int>{'Length': 3, 'Amount': -1}),
    uncert: 5.799956295098564e-7);

/// Second Radiation Constant ('c2')
const MiscQuantity secondRadiationConstant = const MiscQuantity.constant(
    const Double.constant(1.43877736e-2), const Dimensions.constant(const <String, int>{'Length': 1, 'Temperature': 1}),
    uncert: 5.768786909463185e-7);

/// Stefan-Boltzmann constant (sigma)
const MiscQuantity stefanBoltzmann = const MiscQuantity.constant(const Double.constant(5.670367e-8),
    const Dimensions.constant(const <String, int>{'Mass': 1, 'Time': -3, 'Temperature': -4}),
    uncert: 2.292620565829337e-6);

/// Wien Displacement Law Constant ('b')
const MiscQuantity wienDisplacement = const MiscQuantity.constant(
    const Double.constant(2.8977729e-3), const Dimensions.constant(const <String, int>{'Length': 1, 'Temperature': 1}),
    uncert: 5.866574292278045e-7);
