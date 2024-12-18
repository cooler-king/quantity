import 'dart:math';
import '../si/types/angle.dart';

// Useful metric units.

/// A unit of one thousandth of a radian.
final AngleUnits milliradian = Angle.radians.milli() as AngleUnits;

// Synonyms for terseness.

/// Synonymous with radians.
final AngleUnits rad = Angle.radians;

/// Synonymous with degrees.
final AngleUnits deg = Angle.degrees;

/// Converts degrees to radians.
double degToRad(num deg) => 0.0174532925 * deg;

/// Convert radians to degrees.
double radToDeg(num rad) => rad / 0.0174532925;

// Trig functions.

/// The ratio of the hypotenuse to the side opposite an acute angle; the reciprocal of sine.
double cosecant(Angle a) => a.cosecant();

/// The ratio of the side (other than the hypotenuse) adjacent to a particular acute angle to
/// the side opposite the angle.
double cotangent(Angle a) => a.cotangent();

/// The ratio of the hypotenuse to the shorter side adjacent to an acute angle; the reciprocal of a cosine.
double secant(Angle a) => a.secant();

// Constants.

/// The "circle constant", equal to two pi.
const double tau = twoPi;

// Top level SI units.

/// A terse version of [Angle.radians].
final AngleUnits radians = Angle.radians;

/// A terse version of [Angle.degrees].
final AngleUnits degrees = Angle.degrees;

/// A terse version of [Angle.minutesArc].
final AngleUnits minutesArc = Angle.minutesArc;

/// A terse version of [Angle.secondsArc].
final AngleUnits secondsArc = Angle.secondsArc;

// Non-SI angle units.

/// One grad is 0.9 of a degree, exactly.
final AngleUnits grads = AngleUnits(
    'grads', 'grads', 'grads', 'grad', 0.9 * 1.7453292519943e-2, false);

/// Synonym for grads.
final AngleUnits grades = grads;

/// Synonym for grads.
final AngleUnits gons = grads;

/// One angular mil is 0.05625 of a degree, exactly.
final AngleUnits angularMils = AngleUnits(
    'mils', 'mils', 'mils', 'mil', 0.05625 * 1.7453292519943e-2, false);

/// Represents a full circle of two pi radians.
final AngleUnits revolutions =
    AngleUnits('revolutions', 'revs', 'revs', 'revolution', twoPi, false);

/// Synonymous with [revolutions].
final AngleUnits cycles = revolutions;

/// Synonymous with [revolutions].
final AngleUnits circles = revolutions;

/// Represents a half circle of one hundred eighty degrees (pi radians).
final AngleUnits semicircles = AngleUnits(
    'semicircles', 'semicircles', 'semicircles', 'semicircle', pi, false);

/// Represents a quarter circle of ninety degrees.
final AngleUnits quadrants = AngleUnits(
    'quadrants', 'quadrants', 'quadrants', 'quadrant', pi / 2.0, false);

/// A sign unit is a little more than half a radian.
final AngleUnits signs =
    AngleUnits('signs', 'signs', 'signs', 'sign', 0.523599, false);

/// Based on Earth's rotation (approximately 15 degrees).
final AngleUnits hoursTime = AngleUnits(
    'hours time', 'hrs time', 'hrs', 'hour time', 2.6179939e-1, false);

/// Based on Earth's rotation.
final AngleUnits minutesTime = AngleUnits('minutes time', 'mins time',
    'mins (t)', 'minute time', 4.3633231e-3, false);

/// Based on Earth's rotation.
final AngleUnits secondsTime = AngleUnits('seconds time', 'secs time',
    'secs (t)', 'second time', 7.2722052e-5, false);

// Commonly Used Angles.

/// A zero degree angle.
final Angle angle0 = Angle(deg: 0.0);

/// A thirty degree angle.
final Angle angle30 = Angle(deg: 30.0);

/// A forty five degree angle.
final Angle angle45 = Angle(deg: 45.0);

/// A sixty degree angle.
final Angle angle60 = Angle(deg: 60.0);

/// A ninety degree angle.
final Angle angle90 = Angle(deg: 90.0);

/// A one hundred eighty degree angle.
final Angle angle180 = Angle(deg: 180.0);

/// A two hundred seventy degree angle.
final Angle angle270 = Angle(deg: 270.0);

/// A three hundred sixty degree angle.
final Angle angle360 = Angle(deg: 360.0);

/// A one hundred eighty degree angle.
final Angle anglePi = angle180;

/// A three hundred sixty degree angle.
final Angle angleTau = angle360;

// Common trig values.

/// The sine of a zero degree angle (0).
const double sin0 = 0;

/// The sine of a thirty degree angle (0.5).
const double sin30 = 0.5;

/// The sine of a forty five degree angle.
final double sin45 = sine(angle45);

/// The sine of a sixty degree angle.
final double sin60 = sine(angle60);

/// The sine of a ninety degree angle (1).
const double sin90 = 1;

/// The cosine of a ninety degree angle (1).
const double cos0 = 1;

/// The cosine of a thirty degree angle.
final double cos30 = cosine(angle30);

/// The cosine of a forty five degree angle.
final double cos45 = cosine(angle45);

/// The cosine of a sixty degree angle (0.5).
const double cos60 = 0.5;

/// The cosine of a ninety degree angle (1).
const double cos90 = 0;

/// The tangent of a zero degree angle (0).
const double tan0 = 0;

/// The tangent of a thirty degree angle.
final double tan30 = tangent(angle30);

/// The tangent of a forty five degree angle (1).
const double tan45 = 1;

/// The tangent of a sixty degree angle.
final double tan60 = tangent(angle60);

// Alternative construction.

/// Constructs an angle from hours, minutes and seconds of time (as opposed to arc).
Angle angleFromHourMinSec(int hour, int minute, double second,
    [double uncert = 0]) {
  final mks = hoursTime.toMks(hour).toDouble() +
      minutesTime.toMks(minute).toDouble() +
      secondsTime.toMks(second).toDouble();
  return Angle.inUnits(mks, Angle.radians, uncert);
}
