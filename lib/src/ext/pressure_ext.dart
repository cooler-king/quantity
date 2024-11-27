import '../si/types/pressure.dart';
import 'area_ext.dart';
import 'force_ext.dart';

/// The standard SI unit.
PressureUnits pascals = Pressure.pascals;

/// Shorthand bars unit.
PressureUnits bars = Pressure.bars;

/// Standard atmospheres as a unit.
PressureUnits atmospheres = PressureUnits(
    'atmospheres (std)', null, null, 'atmosphere (std)', 1.01325e5, false);

/// Technical atmospheres as a unit.
PressureUnits atmospheresTechnical = PressureUnits('atmospheres (tech)',
    'atm (tech)', 'atm (tech)', 'atmosphere (tech)', 9.80665e4, false);

/// Baryes as a unit.
PressureUnits baryes =
    PressureUnits('baryes', 'baryes', 'baryes', 'barye', 1.0e-1, false);

/// Centimeters of mercury at 0 degrees Celsius.
PressureUnits cmMercury0 = PressureUnits(
    'centimeters of mercury (0 deg C)',
    'cm of Hg (0C)',
    'cm of Hg (0C)',
    'centimeter of mercury (0 deg C)',
    1.33322e3,
    false);

/// Centimeters of water at 4 degrees Celsius.
PressureUnits cmWater4 = PressureUnits(
    'centimeters of water (4 deg C)',
    'cm of H2O (4C)',
    'cm of H2O (4C)',
    'centimeter of water (4 deg C)',
    9.80638e1,
    false);

/// Feet of water at 39.2 degrees Fahrenheit.
PressureUnits ftWater39 = PressureUnits(
    'feet of water (39.2 deg F)',
    'ft of H20 (39.2F)',
    'ft of H20 (39.2F)',
    'foot of water (39.2 deg F)',
    2.98898e3,
    false);

/// Inches of mercury at 32 degrees Fahrenheit.
PressureUnits inMercury32 = PressureUnits(
    'inches of mercury (32 deg F)',
    'in of Hg (32F)',
    'in of Hg (32F)',
    'inch of mercury (32 deg F)',
    3.386389e3,
    false);

/// Inches of water at 39.2 degrees Fahrenheit.
PressureUnits inWater39 = PressureUnits(
    'inches of water (39.2 deg F)',
    'in of H2O (39.2F)',
    'in of H2O (39.2F)',
    'inch of water (39.2 deg F)',
    2.49082e2,
    false);

/// Pounds per square inch as a unit.
PressureUnits psi =
    PressureUnits.forcePerArea(poundsForceAvoirdupois, squareInches);

/// Torrs as a unit.
PressureUnits torrs =
    PressureUnits('torrs', 'torrs', 'torrs', 'torr', 1.33322e2, false);

/// A pressure often used as the reference pressure for calculation of
///  sound pressure __levels__.
PressureUnits referenceSoundAir = PressureUnits(
    'reference sound pressure (air)',
    'reference sound pressure (air)',
    'reference sound pressure (air)',
    'reference sound pressure (air)',
    2.0e-5,
    false);

/// A pressure commonly used as the reference pressure for calculation of
///  sound pressure __levels__.
PressureUnits referenceSoundWater = PressureUnits(
    'reference sound pressure (water)',
    'reference sound pressure (water)',
    'reference sound pressure (water)',
    'reference sound pressure (water)',
    1.0e-6,
    false);

// Convenience units.

/// A synonym for pascals.
PressureUnits newtonsPerSquareMeter = pascals;

/// A millibar as a unit.
PressureUnits millibars = pascals.hecto() as PressureUnits;
