part of quantity_ext;

/// The standard SI unit.
ResistanceUnits ohms = Resistance.ohms;

// Constants.

/// Relates the magnitudes of the electric and magnetic fields of electromagnetic radiation
/// travelling through free space.
const Resistance characteristicImpedanceOfVacuum = const Resistance.constant(const Double.constant(376.73031346177));

/// A synonym for [characteristicImpedanceOfVacuum].
// ignore: constant_identifier_names
const Resistance Z0 = characteristicImpedanceOfVacuum;

/// Relates Planck's constant and the charge of the electron.
const Resistance vonKlitzingConstant =
    const Resistance.constant(const Double.constant(25812.807455555555));
