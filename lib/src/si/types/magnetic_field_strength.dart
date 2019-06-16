part of quantity_si;

/// The intensity of a magnetic field.
///
/// See the [Wikipedia entry for Magnetic field](https://en.wikipedia.org/wiki/Magnetic_field)
/// for more information.
///
class MagneticFieldStrength extends Quantity {
  /// Constructs a MagneticFieldStrength with amperes per meter.
  ///
  /// Optionally specify a relative standard uncertainty.
  ///
  MagneticFieldStrength({dynamic amperesPerMeter, double uncert = 0.0})
      : super(amperesPerMeter ?? 0.0, MagneticFieldStrength.amperesPerMeter, uncert);

  MagneticFieldStrength._internal(dynamic conv)
      : super._internal(conv, MagneticFieldStrength.magneticFieldStrengthDimensions);

  /// Constructs a MagneticFieldStrength based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  MagneticFieldStrength.inUnits(dynamic value, MagneticFieldStrengthUnits units, [double uncert = 0.0])
      : super(value, units ?? MagneticFieldStrength.amperesPerMeter, uncert);

  /// Constructs a constant MagneticFieldStrength.
  const MagneticFieldStrength.constant(Number valueSI, {MagneticFieldStrengthUnits units, double uncert = 0.0})
      : super.constant(valueSI, MagneticFieldStrength.magneticFieldStrengthDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions magneticFieldStrengthDimensions =
      const Dimensions.constant(const <String, int>{'Length': -1, 'Current': 1}, qType: MagneticFieldStrength);

  /// The standard SI unit.
  static final MagneticFieldStrengthUnits amperesPerMeter =
      new MagneticFieldStrengthUnits.currentLength(Current.amperes, Length.meters);
}

/// Units acceptable for use in describing MagneticFieldStrength quantities.
///
class MagneticFieldStrengthUnits extends MagneticFieldStrength with Units {
  /// Constructs a new instance.
  MagneticFieldStrengthUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on electric current and length units.
  MagneticFieldStrengthUnits.currentLength(CurrentUnits ecu, LengthUnits lu)
      : super._internal(ecu.valueSI * lu.valueSI) {
    name = '${ecu.name} per ${lu.singular}';
    singular = '${ecu.singular} per ${lu.singular}';
    _convToMKS = ecu.valueSI * lu.valueSI;
    _abbrev1 = ecu._abbrev1 != null && lu._abbrev1 != null ? '${ecu._abbrev1} / ${lu._abbrev1}' : null;
    _abbrev2 = ecu._abbrev2 != null && lu._abbrev2 != null ? '${ecu._abbrev2}${lu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => MagneticFieldStrength;

  /// Derive new MagneticFieldStrengthUnits using this MagneticFieldStrengthUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new MagneticFieldStrengthUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
