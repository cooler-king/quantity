part of quantity_si;

/// The electric current per unit area of cross section.
/// See the [Wikipedia entry for Current density](https://en.wikipedia.org/wiki/Current_density)
/// for more information.
class CurrentDensity extends Quantity {
  /// Constructs a CurrentDensity with amperes per square meter.
  /// Optionally specify a relative standard uncertainty.
  CurrentDensity({dynamic amperesPerSquareMeter, double uncert = 0.0})
      : super(amperesPerSquareMeter ?? 0.0, CurrentDensity.amperesPerSquareMeter, uncert);

  CurrentDensity._internal(dynamic conv) : super._internal(conv, CurrentDensity.electricCurrentDensityDimensions);

  /// Constructs a CurrentDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  CurrentDensity.inUnits(dynamic value, CurrentDensityUnits units, [double uncert = 0.0])
      : super(value, units ?? CurrentDensity.amperesPerSquareMeter, uncert);

  /// Constructs a constant CurrentDensity.
  const CurrentDensity.constant(Number valueSI, {CurrentDensityUnits units, double uncert = 0.0})
      : super.constant(valueSI, CurrentDensity.electricCurrentDensityDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions electricCurrentDensityDimensions =
      const Dimensions.constant(const <String, int>{'Current': 1, 'Length': -2}, qType: CurrentDensity);

  /// The standard SI unit.
  static final CurrentDensityUnits amperesPerSquareMeter =
      new CurrentDensityUnits.currentArea(Current.amperes, Area.squareMeters);
}

/// Units acceptable for use in describing CurrentDensity quantities.
class CurrentDensityUnits extends CurrentDensity with Units {
  /// Constructs a new instance.
  CurrentDensityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance from current and area quantities.
  CurrentDensityUnits.currentArea(CurrentUnits ecu, AreaUnits au) : super._internal(ecu.valueSI * au.valueSI) {
    name = '${ecu.name} per ${au.singular}';
    singular = '${ecu.singular} per ${au.singular}';
    _convToMKS = ecu.valueSI * au.valueSI;
    _abbrev1 = ecu._abbrev1 != null && au._abbrev1 != null ? '${ecu._abbrev1} / ${au._abbrev1}' : null;
    _abbrev2 = ecu._abbrev2 != null && au._abbrev2 != null ? '${ecu._abbrev2}/${au._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => CurrentDensity;

  /// Derive new CurrentDensityUnits using this CurrentDensityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new CurrentDensityUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
