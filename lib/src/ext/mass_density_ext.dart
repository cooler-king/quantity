part of quantity_ext;

/// The standard SI unit.
MassDensityUnits kilogramsPerCubicMeter = MassDensity.kilogramsPerCubicMeter;

/// Grams per cubic centimeter as a unit.
MassDensityUnits gramsPerCubicCentimeter = new MassDensityUnits.massVolume(grams, cubicCentimeters);

/// Pounds per cubic inch as a unit.
MassDensityUnits poundsPerCubicInch = new MassDensityUnits.massVolume(poundsAvoirdupois, cubicInches);

/// Pounds per cubic foot as a unit.
MassDensityUnits poundsPerCubicFoot = new MassDensityUnits.massVolume(poundsAvoirdupois, cubicFeet);

/// Slugs per cubic foot as a unit.
MassDensityUnits slugsPerCubicFoot = new MassDensityUnits.massVolume(slugs, cubicFeet);
