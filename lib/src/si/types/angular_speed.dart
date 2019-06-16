part of quantity_si;

/// The rate of change of an angle.
/// See the [Wikipedia entry for Angular_velocity](https://en.wikipedia.org/wiki/Angular_velocity)
/// for more information.
class AngularSpeed extends Quantity {
  /// Construct an AngularSpeed with either radians per second or degrees per second.
  /// Optionally specify a relative standard uncertainty.
  AngularSpeed({dynamic radiansPerSecond, dynamic degreesPerSecond, double uncert = 0.0})
      : super(radiansPerSecond ?? (degreesPerSecond ?? 0.0),
            degreesPerSecond != null ? AngularSpeed.degreesPerSecond : AngularSpeed.radiansPerSecond, uncert);

  AngularSpeed._internal(dynamic conv) : super._internal(conv, AngularSpeed.angularSpeedDimensions);

  /// Constructs a AngularSpeed based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  AngularSpeed.inUnits(dynamic value, AngularSpeedUnits units, [double uncert = 0.0])
      : super(value, units ?? AngularSpeed.radiansPerSecond, uncert);

  /// Constructs a constant AngularSpeed.
  const AngularSpeed.constant(Number valueSI, {AngularSpeedUnits units, double uncert = 0.0})
      : super.constant(valueSI, AngularSpeed.angularSpeedDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions angularSpeedDimensions =
      const Dimensions.constant(const <String, int>{'Angle': 1, 'Time': -1}, qType: AngularSpeed);

  /// The standard SI unit.
  static final AngularSpeedUnits radiansPerSecond = new AngularSpeedUnits.angleTime(Angle.radians, Time.seconds);

  /// Accepted for use with the SI.
  static final AngularSpeedUnits degreesPerSecond = new AngularSpeedUnits.angleTime(Angle.degrees, Time.seconds);
}

/// Units acceptable for use in describing AngularSpeed quantities.
class AngularSpeedUnits extends AngularSpeed with Units {
  /// Constructs a new instance.
  AngularSpeedUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on angle and time units.
  AngularSpeedUnits.angleTime(AngleUnits au, TimeUnits tu) : super._internal(au.valueSI * tu.valueSI) {
    name = '${au.name} per ${tu.singular} squared';
    singular = '${au.singular} per ${tu.singular} squared';
    _convToMKS = au.valueSI * tu.valueSI;
    _abbrev1 = au._abbrev1 != null && tu._abbrev1 != null ? '${au._abbrev1} / ${tu._abbrev1}' : null;
    _abbrev2 = au._abbrev2 != null && tu._abbrev2 != null ? '${au._abbrev2}${tu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => AngularSpeed;

  /// Derive new AngularSpeedUnits using this AngularSpeedUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new AngularSpeedUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
