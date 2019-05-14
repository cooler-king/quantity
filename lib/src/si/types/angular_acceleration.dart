part of quantity_si;

/// The rate of change of angular speed.
///
/// See the [Wikipedia entry for Angular acceleration](https://en.wikipedia.org/wiki/Angular_acceleration)
/// for more information.
///
class AngularAcceleration extends Quantity {
  /// Construct an AngularAcceleration with either radians per second squared
  /// or degrees per second squared).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  AngularAcceleration({dynamic radiansPerSecondSquared, dynamic degreesPerSecondSquared, double uncert = 0.0})
      : super(radiansPerSecondSquared ?? (degreesPerSecondSquared ?? 0.0), AngularAcceleration.radiansPerSecondSquared,
            uncert);

  AngularAcceleration._internal(dynamic conv)
      : super._internal(conv, AngularAcceleration.angularAccelerationDimensions);

  /// Constructs a AngularAcceleration based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  AngularAcceleration.inUnits(dynamic value, AngularAccelerationUnits units, [double uncert = 0.0])
      : super(value, units ?? AngularAcceleration.radiansPerSecondSquared, uncert);

  const AngularAcceleration.constant(Number valueSI, {AngularAccelerationUnits units, double uncert = 0.0})
      : super.constant(valueSI, AngularAcceleration.angularAccelerationDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions angularAccelerationDimensions =
      const Dimensions.constant(const <String, int>{'Angle': 1, 'Time': -2}, qType: AngularAcceleration);

  /// The Standard SI unit.
  static final AngularAccelerationUnits radiansPerSecondSquared =
      new AngularAccelerationUnits.angleTime(Angle.radians, Time.seconds);

  /// Accepted for use with the SI.
  static final AngularAccelerationUnits degreesPerSecondSquared =
      new AngularAccelerationUnits.angleTime(Angle.degrees, Time.seconds);
}

/// Units acceptable for use in describing AngularAcceleration quantities.
///
class AngularAccelerationUnits extends AngularAcceleration with Units {
  AngularAccelerationUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super._internal(conv) {
    this.name = name;
    this.singular = singular;
    _convToMKS = objToNumber(conv);
    _abbrev1 = abbrev1;
    _abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  AngularAccelerationUnits.angleTime(AngleUnits au, TimeUnits tu) : super._internal(au.valueSI * tu.valueSI) {
    name = '${au.name} per ${tu.singular} squared';
    singular = '${au.singular} per ${tu.singular} squared';
    _convToMKS = au.valueSI * tu.valueSI;
    _abbrev1 = au._abbrev1 != null && tu._abbrev1 != null ? '${au._abbrev1} / ${tu._abbrev1}' : null;
    _abbrev2 = au._abbrev2 != null && tu._abbrev2 != null ? '${au._abbrev2}${tu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => AngularAcceleration;

  /// Derive new AngularAccelerationUnits using this AngularAccelerationUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new AngularAccelerationUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
