part of quantity_si;

/// Represents the _length_ physical quantity (one of the seven base SI quantities).
/// See the [Wikipedia entry for Length](https://en.wikipedia.org/wiki/Length)
/// for more information.
class Length extends Quantity {
  /// Constructs a Length with meters ([m]), kilometers ([km]), millimeters ([mm]), astronomical units ([ua])
  /// or nautical miles ([NM]).
  /// Optionally specify a relative standard uncertainty.
  // ignore: non_constant_identifier_names
  Length({dynamic m, dynamic km, dynamic mm, dynamic ua, dynamic NM, double uncert = 0.0})
      : super(
            m ?? (km ?? (mm ?? (ua ?? (NM ?? 0.0)))),
            km != null
                ? Length.kilometers
                : (mm != null
                    ? Length.millimeters
                    : (ua != null ? Length.astronomicalUnits : (NM != null ? Length.nauticalMiles : Length.meters))),
            uncert);

  Length._internal(dynamic conv) : super._internal(conv, Length.lengthDimensions);

  /// Constructs a Length based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Length.inUnits(dynamic value, LengthUnits units, [double uncert = 0.0])
      : super(value, units ?? Length.meters, uncert);

  /// Constructs constant Length.
  const Length.constant(Number valueSI, {LengthUnits units, double uncert = 0.0})
      : super.constant(valueSI, Length.lengthDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions lengthDimensions = const Dimensions.constant(const <String, int>{'Length': 1}, qType: Length);

  /// The standard SI unit.
  static final LengthUnits meters = new LengthUnits('meters', 'm', null, null, 1.0, true);

  /// Accepted for use with the SI... the value of the astronomical unit must be
  /// obtained by experiment and is therefore not known exactly... its value is
  /// such that, when used to describe the motion of bodies in the solar system,
  /// the heliocentric gravitation constant is 0.017 202 098 85 squared (in units
  /// of ua+3 d-2, where d is day).
  static final LengthUnits astronomicalUnits =
      new LengthUnits('astronomical units', 'AU', 'ua', null, 1.495978707e11, false);

  /// Accepted for use with the SI, subject to further review.
  static final LengthUnits angstroms = new LengthUnits('angstroms', '\u212b', '\u00c5', null, 1.0e-10, true);

  /// Accepted for use with the SI, subject to further review.
  static final LengthUnits nauticalMiles = new LengthUnits('nautical miles', null, 'NM', null, 1.852e3, false);

  // Convenience Units.

  /// The metric unit for one thousand meters.
  static final LengthUnits kilometers = Length.meters.kilo() as LengthUnits;

  /// The metric unit for one hundredth of a meter.
  static final LengthUnits centimeters = Length.meters.centi() as LengthUnits;

  /// The metric unit for one thousandth of a meter.
  static final LengthUnits millimeters = Length.meters.milli() as LengthUnits;

  /// The metric unit for one billionth of a meter.
  static final LengthUnits nanometers = Length.meters.nano() as LengthUnits;
}

/// Units acceptable for use in describing Length quantities.
class LengthUnits extends Length with Units {
  /// Constructs a new instance.
  LengthUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Length;

  /// Derive new LengthUnits using this LengthUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new LengthUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
