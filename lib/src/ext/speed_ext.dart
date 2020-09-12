import '../number/double.dart';
import '../si/types/speed.dart';
import 'length_ext.dart';
import 'time_ext.dart';

/// The standard SI unit.
SpeedUnits metersPerSecond = Speed.metersPerSecond;

/// The speed of light as a unit.
SpeedUnits speedOfLightUnits = new SpeedUnits('speed of light', 'c0', 'c', 'speed of light', 2.99792458e8, false);

/// Feet per hour as a unit.
SpeedUnits feetPerHour = new SpeedUnits.lengthTime(feet, hours);

/// Feet per minute as a unit.
SpeedUnits feetPerMinute = new SpeedUnits.lengthTime(feet, minutes);

/// Feet per second as a unit.
SpeedUnits feetPerSecond = new SpeedUnits.lengthTime(feet, seconds);

/// Inches per second as a unit.
SpeedUnits inchesPerSecond = new SpeedUnits.lengthTime(inches, seconds);

/// Kilometers per hour as a unit.
SpeedUnits kilometersPerHour = new SpeedUnits.lengthTime(kilometers, hours);

/// Miles per hour as a unit.
SpeedUnits milesPerHour = new SpeedUnits.lengthTime(miles, hours);

/// Miles per minute as a unit.
SpeedUnits milesPerMinute = new SpeedUnits.lengthTime(miles, minutes);

/// Miles per second as a unit.
SpeedUnits milesPerSecond = new SpeedUnits.lengthTime(miles, seconds);

/// Knots, tersely.
SpeedUnits knots = Speed.knots;

// CONSTANTS.

/// Speed of light in a vacuum.
const Speed speedOfLightVacuum = const Speed.constant(const Double.constant(299792458));

/// Speed of sound in air at 0 deg C.
const Speed speedOfSoundAir0C = const Speed.constant(const Double.constant(331.6));
