part of quantity_si;

/// The rate of mean energy imparted to matter per unit mass by ionizing radiation.
///
/// See the [Wikipedia entry for Absorbed Dose](https://en.wikipedia.org/wiki/Absorbed_dose)
/// for more information.
///
class AbsorbedDoseRate extends Quantity {
  /// Construct an AbsorbedDoseRate with either grays per second or rads per second.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  AbsorbedDoseRate({dynamic graysPerSecond, dynamic radsPerSecond, double uncert = 0.0})
      : super(graysPerSecond ?? (radsPerSecond ?? 0.0),
            radsPerSecond != null ? AbsorbedDoseRate.radsPerSecond : AbsorbedDoseRate.graysPerSecond, uncert);

  AbsorbedDoseRate._internal(dynamic conv) : super._internal(conv, AbsorbedDoseRate.absorbedDoseRateDimensions);

  /// Constructs an AbsorbedDoseRate based on the [value]
  /// and the conversion factor intrinsic to the provided [units].
  ///
  AbsorbedDoseRate.inUnits(dynamic value, AbsorbedDoseRateUnits units, [double uncert = 0.0])
      : super(value, units ?? AbsorbedDoseRate.graysPerSecond, uncert);

  /// Construct a constant AbsorbedDoseRate with its SI value.
  const AbsorbedDoseRate.constant(Number valueSI, {AbsorbedDoseRateUnits units, double uncert = 0.0})
      : super.constant(valueSI, AbsorbedDoseRate.absorbedDoseRateDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions absorbedDoseRateDimensions =
      const Dimensions.constant(const <String, int>{'Length': 2, 'Time': -3}, qType: AbsorbedDoseRate);

  /// The standard SI unit.
  static final AbsorbedDoseRateUnits graysPerSecond =
      new AbsorbedDoseRateUnits.absorbedDoseTime(AbsorbedDose.grays, Time.seconds);

  /// Accepted for use with the SI.
  static final AbsorbedDoseRateUnits radsPerSecond =
      new AbsorbedDoseRateUnits.absorbedDoseTime(AbsorbedDose.rads, Time.seconds);
}

/// Units acceptable for use in describing AbsorbedDoseRate quantities.
///
class AbsorbedDoseRateUnits extends AbsorbedDoseRate with Units {
  /// Constructs a new instance.
  AbsorbedDoseRateUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on absorbed dose and time units.
  AbsorbedDoseRateUnits.absorbedDoseTime(AbsorbedDoseUnits adu, TimeUnits tu)
      : super._internal(adu.valueSI * tu.valueSI) {
    name = '${adu.name} per ${tu.singular} squared';
    singular = '${adu.singular} per ${tu.singular} squared';
    _convToMKS = adu.valueSI * tu.valueSI;
    _abbrev1 = adu._abbrev1 != null && tu._abbrev1 != null ? '${adu._abbrev1} / ${tu._abbrev1}' : null;
    _abbrev2 = adu._abbrev2 != null && tu._abbrev2 != null ? '${adu._abbrev2}${tu._abbrev2}' : null;
    metricBase = metricBase;
    offset = offset.toDouble();
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => AbsorbedDoseRate;

  /// Derive new AbsorbedDoseRateUnits using this AbsorbedDoseRateUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new AbsorbedDoseRateUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
