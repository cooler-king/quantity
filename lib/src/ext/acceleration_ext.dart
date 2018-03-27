part of quantity_ext;

/// A synonym for the standard SI-MKS unit of acceleration.
final AccelerationUnits meterPerSecondSquared = Acceleration.metersPerSecondSquared;

/// A commonly used English unit of acceleration.
final AccelerationUnits footPerSecondSquared = new AccelerationUnits.lengthTimeUnits(feet, seconds);

/// A commonly used English unit of acceleration.
final AccelerationUnits inchPerSecondSquared = new AccelerationUnits.lengthTimeUnits(inches, seconds);

/// A unit based on the acceleration experienced by a free-falling body at the Earth's surface.
// Note:  don't use 'g' as abbreviation (conflict with grams and presents problems for parsing)
final AccelerationUnits gees = new AccelerationUnits('gees', null, null, null, 9.80665, false);

/// The more formal name for [gees].
final AccelerationUnits standardAccelerationOfGravity = gees;

/// Defined as 0.01 meter per second squared.
final AccelerationUnits galileos = new AccelerationUnits('galileos', 'gals', null, null, 0.01, true);

/// Synonymous with [galileos].
final AccelerationUnits gals = galileos;
