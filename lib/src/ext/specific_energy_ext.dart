part of quantity_ext;

/// The standard SI unit.
SpecificEnergyUnits joulesPerKilogram = SpecificEnergy.joulesPerKilogram;

/// Square meters per second as a unit.
SpecificEnergyUnits squareMetersPerSquareSecond = new SpecificEnergyUnits.lengthTime(meters, seconds);

/// The square of the speed of light in a vacuum.
SpecificEnergyUnits speedOfLightSquared = new SpecificEnergyUnits.speed(speedOfLightUnits);
