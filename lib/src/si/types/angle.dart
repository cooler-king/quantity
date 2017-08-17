part of quantity_si;

// Common trig functions

/// Calculates the cosine of an [Angle] (adjacent divided by hypotenuse)
double cosine(Angle a) => a.cosine();

/// Calculates the sine of an [Angle] (opposite divided by hypotenuse)
double sine(Angle a) => a.sine();

/// Calculates the tangent of an [Angle] (opposite divided by adjacent)
double tangent(Angle a) => a.tangent();

// Constant
const double twoPi = 2.0 * Math.PI;

/// A planar (2-dimensional) angle, which has dimensions of _1_ and is a
/// measure of the ratio of the length of a circular arc to its radius.
///
/// Example usage:
///
///     // Construct an Angle in radians
///     var ang = new Angle(rad: 1.1);
///
///     // Construct an Angle in degrees
///     var ang2 = new Angle(deg: 270);
///
///     // Find the difference
///     var diff = ang2 - ang;
///
///     // Display the result in degrees
///     print(diff.valueInUnits(Angle.degrees);
///
/// See the [Wikipedia entry for Angle](https://en.wikipedia.org/wiki/Angle)
/// for more information.
///
class Angle extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions angleDimensions = const Dimensions.constant(const {"Angle": 1}, type: Angle);

  /// The standard SI unit.
  static final AngleUnits radians = new AngleUnits("radians", null, "rad", null, Integer.one, true);

  /// Accepted for use with the SI.
  static final AngleUnits degrees =
      new AngleUnits("degrees", "\u{00b0}", "deg", null, const Double.constant(1.7453292519943e-2), false);

  /// Accepted for use with the SI.
  static final AngleUnits minutesArc =
      new AngleUnits("arc minutes", "\'", "arc min", null, const Double.constant(2.9088821e-4), false);

  /// Accepted for use with the SI.
  static final AngleUnits secondsArc =
      new AngleUnits("arc seconds", "\"", "arc sec", null, const Double.constant(4.8481368e-6), false);

  // convenience units

  /// Accepted for use with the SI; equivalent to [minutesArc].
  static final AngleUnits minutes = minutesArc;

  /// Accepted for use with the SI; equivalent to [secondsArc].
  static final AngleUnits seconds = secondsArc;

  /// Construct an Angle with either radians ([rad]) or degrees ([deg]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Angle({dynamic rad, dynamic deg, double uncert: 0.0})
      : super(deg ?? (rad ?? 0.0), deg != null ? Angle.degrees : Angle.radians, uncert);

  Angle._internal(conv) : super._internal(conv, Angle.angleDimensions);

  /// Constructs an Angle based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  /// Unlike other Quantity subclasses, the Angle constructor requires
  /// both value _and units_ to be provided.  This is to avoid any confusion
  /// between radians and degrees, which is a common source of programming
  /// errors.
  ///
  /// The dimension is set to the static [angleDimensions] parameter.
  ///
  /// The internal value is automatically bounded between -PI and PI
  /// radians (-180 to 180 degrees)
  ///
  Angle.inUnits(value, AngleUnits units, [double uncert = 0.0]) : super(value, units ?? Angle.radians, uncert);

  const Angle.constant(Number valueSI, {AngleUnits  units, double uncert: 0.0})
      : super.constant(valueSI, Angle.angleDimensions, units, uncert);

  ///  This constructor creates an angle value from the three values
  ///  passed in for degrees, minutes, and seconds of arc OR hours, minutes and
  ///  seconds of time.  The final parameter is a flag to dostinguish between the
  ///  two cases:  true indicates degrees, false indicates hours.
  ///
  Angle.fromDegMinSec(int d, int m, double s, [double uncert = 0.0])
      : super(degrees.toMks(d) + minutesArc.toMks(m) + secondsArc.toMks(s), Angle.radians, uncert);

  /// Return an equivalent angle bounded to between -PI and PI
  /// (-180 and 180 degrees).
  ///
  /// If this Angle is already within that range then it is returned directly.
  ///
  Angle get angle180 {
    if (valueSI >= -Math.PI && valueSI <= Math.PI) return this;

    double rad = valueSI.toDouble();
    while (rad < -Math.PI) rad += twoPi;
    while (rad > Math.PI) rad -= twoPi;
    return new Angle(rad: rad);
  }

  /// Returns an equivalent angle bounded to between 0 and 2PI
  /// (0 and 360 degrees).
  ///
  /// If this Angle is already within that range then it is returned directly.
  ///
  Angle get angle360 {
    if (valueSI >= 0.0 && valueSI <= twoPi) return this;
    double rad = valueSI.toDouble();
    rad = rad.remainder(twoPi);
    if (valueSI < 0) rad += twoPi;
    return new Angle(rad: rad);
  }

  /// Calculates the cosine of this angle.
  ///
  double cosine() => Math.cos(mks.toDouble());

  /// Calculates the sine of this angle.
  ///
  double sine() => Math.sin(mks.toDouble());

  /// Calculates the tangent of this angle.
  ///
  double tangent() => Math.tan(mks.toDouble());

  /// Calculates and returns the secant of this angle.
  ///
  /// The secant of an angle is equivalent to 1 over the cosine.
  ///
  double secant() => 1.0 / Math.cos(mks.toDouble());

  /// Calculates and returns the cosecant of this angle.
  ///
  /// The cosecant of an angle is equivalent to 1 over the sine.
  ///
  double cosecant() => 1.0 / Math.sin(mks.toDouble());

  ///  Calculates and returns the cotangent of this angle.
  ///
  /// The cotangent is equivalent to 1 over the tangent.
  ///
  double cotangent() => 1.0 / Math.tan(mks.toDouble());

  /// Returns an array of three values representing the value of this Angle
  /// in degrees, minutes arc and seconds arc.  The first value (degrees) may
  /// be either positive or negative; the other two values will be positive.
  ///
  List<double> get degMinSec {
    List<double> dms = new List<double>.generate(3, null, growable: false);

    double decimalDegrees = valueInUnits(degrees).toDouble();

    // Degrees
    dms[0] = decimalDegrees.toInt().toDouble();

    // Minutes
    double remainder1 = decimalDegrees.abs() - dms[0].abs();
    double decimalMinutes = remainder1 * 60.0;
    dms[1] = decimalMinutes.toInt().toDouble();

    // Seconds
    double remainder2 = decimalMinutes - dms[1];
    dms[2] = remainder2 * 60.0;

    return dms;
  }

  /// Gets the value of this angle in terms of hours, minutes and seconds
  /// (where there are 24 hours in a complete circle).  The first value (hours)
  /// may be either positive or negative; the other two values will be positive.
  ///
  List<double> get hrMinSec {
    List<double> hms = new List<double>.generate(3, null, growable: false);

    double decimalHours = valueInUnits(degrees).toDouble() / 15.0;

    // Hours
    hms[0] = decimalHours.toInt().toDouble();

    // Minutes
    double remainder1 = decimalHours.abs() - hms[0].abs();
    double decimalMinutes = remainder1 * 60.0;
    hms[1] = decimalMinutes.toInt().toDouble();

    // Seconds
    double remainder2 = decimalMinutes - hms[1];
    hms[2] = remainder2 * 60.0;

    return hms;
  }
}

/// Units acceptable for use in describing Angle quantities.
///
class AngleUnits extends Angle with Units {
  AngleUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super._internal(conv) {
    this.name = name;
    this.singular = singular;
    this._convToMKS = objToNumber(conv);
    this._abbrev1 = abbrev1;
    this._abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Angle;

  /// Derive new AngleUnits using this AngleUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new AngleUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
