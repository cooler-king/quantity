part of quantity_si;

// Also Stress

/// Force applied perpendicular to the surface of an object per unit area
/// over which that force is distributed.
///
/// See the [Wikipedia entry for Pressure](https://en.wikipedia.org/wiki/Pressure)
/// for more information.
///
class Pressure extends Quantity {
  /// Construct a pressure with pascals ([Pa]) or [bars].
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  // ignore: non_constant_identifier_names
  Pressure({dynamic Pa, dynamic bars, double uncert = 0.0})
      : super(Pa ?? (bars ?? 0.0), bars != null ? Pressure.bars : Pressure.pascals, uncert);

  Pressure._internal(dynamic conv) : super._internal(conv, Pressure.pressureDimensions);

  /// Constructs a Pressure based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Pressure.inUnits(dynamic value, PressureUnits units, [double uncert = 0.0])
      : super(value, units ?? Pressure.pascals, uncert);

  const Pressure.constant(Number valueSI, {PressureUnits units, double uncert = 0.0})
      : super.constant(valueSI, Pressure.pressureDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions pressureDimensions =
      const Dimensions.constant(const <String, int>{'Length': -1, 'Mass': 1, 'Time': -2}, qType: Pressure);

  /// The standard SI unit.
  static final PressureUnits pascals = new PressureUnits('pascals', null, 'Pa', null, 1.0, true);

  /// Accepted for use with the SI, subject to further review.
  static final PressureUnits bars = new PressureUnits('bars', null, null, null, 1.0e5, true);
}

/// Units acceptable for use in describing Pressure quantities.
///
class PressureUnits extends Pressure with Units {
  PressureUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  PressureUnits.forceArea(ForceUnits fu, AreaUnits au) : super._internal(fu.valueSI * au.valueSI) {
    name = '${fu.name} per ${au.singular}';
    singular = '${fu.singular} per ${au.singular}';
    _convToMKS = fu.valueSI * au.valueSI;
    _abbrev1 = fu._abbrev1 != null && au._abbrev1 != null ? '${fu._abbrev1} / ${au._abbrev1}' : null;
    _abbrev2 = fu._abbrev2 != null && au._abbrev2 != null ? '${fu._abbrev2}${au._abbrev2}' : null;
    metricBase = metricBase;
    offset = offset.toDouble();
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Pressure;

  /// Derive new PressureUnits using this PressureUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new PressureUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
