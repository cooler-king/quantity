part of quantity_si;

/// The rate of change of position.
///
/// See the [Wikipedia entry for Speed](https://en.wikipedia.org/wiki/Speed)
/// for more information.
///
class Speed extends Quantity {
  /// Construct a Speed with meters per second or [knots].
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Speed({dynamic metersPerSecond, dynamic knots, double uncert = 0.0})
      : super(metersPerSecond ?? (knots ?? 0.0), knots != null ? Speed.knots : Speed.metersPerSecond, uncert);

  Speed._internal(dynamic conv) : super._internal(conv, Speed.speedDimensions);

  /// Constructs a Speed based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Speed.inUnits(dynamic value, SpeedUnits units, [double uncert = 0.0])
      : super(value, units ?? Speed.metersPerSecond, uncert);

  const Speed.constant(Number valueSI, {SpeedUnits units, double uncert = 0.0})
      : super.constant(valueSI, Speed.speedDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions speedDimensions =
      const Dimensions.constant(const <String, int>{'Length': 1, 'Time': -1}, qType: Speed);

  /// The standard SI unit.
  static final SpeedUnits metersPerSecond = new SpeedUnits.lengthTime(Length.meters, Time.seconds);

  /// Accepted for use with the SI, subject to further review.
  static final SpeedUnits knots = new SpeedUnits('knots', null, null, null, 5.144444444e-1, false);
}

/// Units acceptable for use in describing Speed quantities.
///
class SpeedUnits extends Speed with Units {
  /// Constructs a new instance.
  SpeedUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on length and time units.
  SpeedUnits.lengthTime(LengthUnits lu, TimeUnits tu) : super._internal(lu.valueSI / tu.valueSI) {
    name = '${lu.name} per ${tu.singular}';
    singular = '${lu.singular} per ${tu.singular}';
    _convToMKS = lu.valueSI / tu.valueSI;
    _abbrev1 = lu._abbrev1 != null && tu._abbrev1 != null ? '${lu._abbrev1} / ${tu._abbrev1}' : null;
    _abbrev2 = lu._abbrev2 != null && tu._abbrev2 != null ? '${lu._abbrev2}/${tu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Speed;

  /// Derive new SpeedUnits using this SpeedUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new SpeedUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
