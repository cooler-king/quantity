import '../number/double.dart';
import '../si/types/resistance.dart';

/// The standard SI unit.
ResistanceUnits ohms = Resistance.ohms;

// Constants.

/// Relates the magnitudes of the electric and magnetic fields of electromagnetic radiation
/// travelling through free space.
const Resistance characteristicImpedanceOfVacuum = Resistance.constant(
    Double.constant(376.730313412),
    uncert: 1.5661070505753646e-10);

/// A synonym for [characteristicImpedanceOfVacuum].
// ignore: constant_identifier_names
const Resistance Z0 = characteristicImpedanceOfVacuum;

/// Relates Planck's constant and the charge of the electron.
const Resistance vonKlitzingConstant =
    Resistance.constant(Double.constant(25812.80745));
