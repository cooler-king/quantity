part of quantity_ext;

/// The standard SI unit.
SpeedUnits metersPerSecond = Speed.metersPerSecond;

SpeedUnits speedOfLightUnits = new SpeedUnits('speed of light', 'c0', 'c', 'speed of light', 2.99792458e8, false);

SpeedUnits feetPerHour = new SpeedUnits.lengthTime(feet, hours);

SpeedUnits feetPerMinute = new SpeedUnits.lengthTime(feet, minutes);

SpeedUnits feetPerSecond = new SpeedUnits.lengthTime(feet, seconds);

SpeedUnits inchesPerSecond = new SpeedUnits.lengthTime(inches, seconds);

SpeedUnits kilometersPerHour = new SpeedUnits.lengthTime(kilometers, hours);

SpeedUnits milesPerHour = new SpeedUnits.lengthTime(miles, hours);

SpeedUnits milesPerMinute = new SpeedUnits.lengthTime(miles, minutes);

SpeedUnits milesPerSecond = new SpeedUnits.lengthTime(miles, seconds);

SpeedUnits knots = Speed.knots;

// CONSTANTS

/// Speed of light in a vacuum.
const Speed speedOfLightVacuum = const Speed.constant(const Double.constant(2.99792458e8));

/// Speed of sound in air at 0 deg C.
const Speed speedOfSoundAir0C = const Speed.constant(const Double.constant(331.6));
