part of quantity_ext;

// Metric units?

// Synonyms for terseness
final AngleUnits rad = Angle.radians;
final AngleUnits deg = Angle.degrees;

/// Converts degrees to radians
double degToRad(num deg) => 0.0174532925 * deg;

/// Convert radians to degrees
double radToDeg(num rad) => rad / 0.0174532925;

// Trig functions
double cosecant(Angle a) => a.cosecant();
double cotangent(Angle a) => a.cotangent();
double secant(Angle a) => a.secant();

// Constants
const double tau = twoPi;

// top level SI units
final AngleUnits radians = Angle.radians;
final AngleUnits degrees = Angle.degrees;
final AngleUnits minutesArc = Angle.minutesArc;
final AngleUnits secondsArc = Angle.secondsArc;

// non-SI angle units

/// One grad is 0.9 of a degree, exactly
final AngleUnits grads = new AngleUnits("grads", null, null, null, 0.9 * 1.7453292519943e-2, false);

/// Synonym for grads
final AngleUnits grades = grads;

/// Synonym for grads
final AngleUnits gons = grads;

/// One angular mil is 0.05625 of a degree, exactly
final AngleUnits angularMils = new AngleUnits("mils", null, null, null, 0.05625 * 1.7453292519943e-2, false);

final AngleUnits revolutions = new AngleUnits("revolutions", null, "revs", null, twoPi, false);

final AngleUnits cycles = revolutions;

final AngleUnits signs = new AngleUnits("signs", null, null, null, 0.523599, false);

/// Based on earth's rotation (approximately 15 degrees)
final AngleUnits hoursTime = new AngleUnits("hours time", "hrs time", "hr", "hour time", 2.6179939e-1, false);

/// based on earth's rotation
final AngleUnits minutesTime =
    new AngleUnits("minutes time", "min time", "min (t)", "minute time", 4.3633231e-3, false);

/// Based on earth's rotation
final AngleUnits secondsTime =
    new AngleUnits("seconds time", "sec time", "sec (t)", "second time", 7.2722052e-5, false);

// Commonly Used Angles
final Angle angle0 = new Angle(deg: 0.0);
final Angle angle30 = new Angle(deg: 30.0);
final Angle angle45 = new Angle(deg: 45.0);
final Angle angle60 = new Angle(deg: 60.0);
final Angle angle90 = new Angle(deg: 90.0);
final Angle angle180 = new Angle(deg: 180.0);
final Angle angle270 = new Angle(deg: 270.0);
final Angle angle360 = new Angle(deg: 360.0);
final Angle anglePi = angle180;
final Angle angleTau = angle360;

// Common trig values
final double sin0 = 0.0;
final double sin30 = 0.5;
final double sin45 = sine(angle45);
final double sin60 = sine(angle60);
final double sin90 = 1.0;
final double cos0 = 1.0;
final double cos30 = cosine(angle30);
final double cos45 = cosine(angle45);
final double cos60 = 0.5;
final double cos90 = 0.0;
final double tan0 = 0.0;
final double tan30 = tangent(angle30);
final double tan45 = 1.0;
final double tan60 = tangent(angle60);

// Alternative construction
Angle angleFromHourMinSec(int hour, int minute, double second, [double uncert = 0.0]) {
  double mks =
      hoursTime.toMks(hour).toDouble() + minutesTime.toMks(minute).toDouble() + secondsTime.toMks(second).toDouble();
  return new Angle.inUnits(mks, Angle.radians, uncert);
}
