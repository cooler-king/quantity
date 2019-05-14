part of quantity_ext;

/// The standard SI unit.
MassDensityUnits kilogramsPerCubicMeter = MassDensity.kilogramsPerCubicMeter;

MassDensityUnits gramsPerCubicCentimeter = new MassDensityUnits.massVolume(grams, cubicCentimeters);

MassDensityUnits poundsPerCubicInch = new MassDensityUnits.massVolume(poundsAvoirdupois, cubicInches);

MassDensityUnits poundsPerCubicFoot = new MassDensityUnits.massVolume(poundsAvoirdupois, cubicFeet);

MassDensityUnits slugsPerCubicFoot = new MassDensityUnits.massVolume(slugs, cubicFeet);
