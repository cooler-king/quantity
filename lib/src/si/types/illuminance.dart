part of quantity_si;

/// The total luminous flux incident on a surface, per unit area.
/// See the [Wikipedia entry for Illuminance](https://en.wikipedia.org/wiki/Illuminance)
/// for more information.
class Illuminance extends Quantity {
  /// Constructs an Illuminance with [lux].
  /// Optionally specify a relative standard uncertainty.
  Illuminance({dynamic lux, double uncert = 0.0}) : super(lux ?? 0.0, Illuminance.lux, uncert);

  Illuminance._internal(dynamic conv) : super._internal(conv, Illuminance.illuminanceDimensions);

  /// Constructs a Illuminance based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Illuminance.inUnits(dynamic value, IlluminanceUnits units, [double uncert = 0.0])
      : super(value, units ?? Illuminance.lux, uncert);

  /// Constructs a constant Illuminance.
  const Illuminance.constant(Number valueSI, {IlluminanceUnits units, double uncert = 0.0})
      : super.constant(valueSI, Illuminance.illuminanceDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions illuminanceDimensions = const Dimensions.constant(
      const <String, int>{'Length': -2, 'Intensity': 1, 'Solid Angle': 1},
      qType: Illuminance);

  /// The standard SI unit.
  // Note: singular same as plural
  static final IlluminanceUnits lux = new IlluminanceUnits('lux', null, 'lx', 'lux', 1.0, true);
}

/// Units acceptable for use in describing Illuminance quantities.
class IlluminanceUnits extends Illuminance with Units {
  /// Constructs a new instance.
  IlluminanceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => Illuminance;

  /// Derive new IlluminanceUnits using this IlluminanceUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new IlluminanceUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
