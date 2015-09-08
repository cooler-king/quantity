part of quantity_ext;

final AccelerationUnits meterPerSecondSquared = Acceleration.meterPerSecondSquared;

final AccelerationUnits footPerSecondSquared = new AccelerationUnits.lengthTimeUnits(feet, seconds);

final AccelerationUnits inchPerSecondSquared = new AccelerationUnits.lengthTimeUnits(inches, seconds);

// Note:  don't use "g" as abbreviation (conflict with grams and
// presents problems for parsing)
final AccelerationUnits gees = new AccelerationUnits("gees", null, null, null, 9.80665, false);
final AccelerationUnits standardAccelerationOfGravity = gees;

/// Defined as 0.01 meter per second squared
final AccelerationUnits galileos = new AccelerationUnits("galileos", "gals", null, null, 0.01, true);

// convenience units
final AccelerationUnits gals = galileos;
