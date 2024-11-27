import '../number/double.dart';
import '../si/types/speed.dart';
import 'length_ext.dart';
import 'time_ext.dart';

/// The standard SI unit.
SpeedUnits metersPerSecond = Speed.metersPerSecond;

/// The speed of light as a unit.
SpeedUnits speedOfLightUnits = SpeedUnits(
    'speed of light', 'c0', 'c', 'speed of light', 2.99792458e8, false);

/// Feet per hour as a unit.
SpeedUnits feetPerHour = SpeedUnits.lengthPerTime(feet, hours);

/// Feet per minute as a unit.
SpeedUnits feetPerMinute = SpeedUnits.lengthPerTime(feet, minutes);

/// Feet per second as a unit.
SpeedUnits feetPerSecond = SpeedUnits.lengthPerTime(feet, seconds);

/// Inches per second as a unit.
SpeedUnits inchesPerSecond = SpeedUnits.lengthPerTime(inches, seconds);

/// Kilometers per hour as a unit.
SpeedUnits kilometersPerHour = SpeedUnits.lengthPerTime(kilometers, hours);

/// Miles per hour as a unit.
SpeedUnits milesPerHour = SpeedUnits.lengthPerTime(miles, hours);

/// Miles per minute as a unit.
SpeedUnits milesPerMinute = SpeedUnits.lengthPerTime(miles, minutes);

/// Miles per second as a unit.
SpeedUnits milesPerSecond = SpeedUnits.lengthPerTime(miles, seconds);

/// Knots, tersely.
SpeedUnits knots = Speed.knots;

// CONSTANTS.

/// Speed of light in a vacuum.
const Speed speedOfLightVacuum = Speed.constant(Double.constant(299792458));

/// Speed of sound in air at 0 deg C.
const Speed speedOfSoundAir0C = Speed.constant(Double.constant(331.6));
