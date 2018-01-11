part of quantity_ext;

PressureUnits pascals = Pressure.pascals;

PressureUnits bars = Pressure.bars;

PressureUnits atmospheres = new PressureUnits('atmospheres (std)', null, null, 'atmosphere (std)', 1.01325e5, false);

PressureUnits atmospheresTechnical =
    new PressureUnits('atmospheres (tech)', null, null, 'atmosphere (tech)', 9.80665e4, false);

PressureUnits baryes = new PressureUnits('baryes', null, null, null, 1.0e-1, false);

PressureUnits cmMercury0 = new PressureUnits(
    'centimeters of mercury (0 deg C)', null, null, 'centimeter of mercury (0 deg C)', 1.33322e3, false);

PressureUnits cmWater4 =
    new PressureUnits('centimeters of water (4 deg C)', null, null, 'centimeter of water (4 deg C)', 9.80638e1, false);

PressureUnits ftWater39 =
    new PressureUnits('feet of water (39.2 deg F)', null, null, 'foot of water (39.2 deg F)', 2.98898e3, false);

PressureUnits inMercury32 =
    new PressureUnits('inches of mercury (32 deg F)', null, null, 'inch of mercury (32 deg F)', 3.386389e3, false);

PressureUnits inWater39 =
    new PressureUnits('inches of water (39.2 deg F)', null, null, 'inch of water (39.2 deg F)', 2.49082e2, false);

PressureUnits psi = new PressureUnits.forceArea(poundsForceAvoirdupois, squareInches);

PressureUnits torrs = new PressureUnits('torrs', null, null, null, 1.33322e2, false);

/// A pressure often used as the reference pressure for calculation of
///  sound pressure __levels__.
PressureUnits referenceSoundAir =
    new PressureUnits('reference sound pressure (air)', null, null, 'reference sound pressure (air)', 2.0e-5, false);

/// A pressure commonly used as the reference pressure for calculation of
///  sound pressure __levels__.
PressureUnits referenceSoundWater = new PressureUnits(
    'reference sound pressure (water)', null, null, 'reference sound pressure (water)', 1.0e-6, false);

// convenience units
PressureUnits newtonsPerSquareMeter = pascals;
PressureUnits millibars = pascals.hecto() as PressureUnits;
