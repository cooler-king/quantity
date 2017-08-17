part of quantity_si;

/// The rate of mean energy imparted to matter per unit mass by ionizing radiation.
///
/// See the [Wikipedia entry for Absorbed Dose](https://en.wikipedia.org/wiki/Absorbed_dose)
/// for more information.
///
class AbsorbedDoseRate extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions absorbedDoseRateDimensions =
      const Dimensions.constant(const {"Length": 2, "Time": -3}, type: AbsorbedDoseRate);

  /// The standard SI unit.
  static final AbsorbedDoseRateUnits graysPerSecond =
      new AbsorbedDoseRateUnits.absorbedDoseTime(AbsorbedDose.grays, Time.seconds);

  /// Accepted for use with the SI.
  static final AbsorbedDoseRateUnits radsPerSecond =
      new AbsorbedDoseRateUnits.absorbedDoseTime(AbsorbedDose.rads, Time.seconds);

  /// Construct an AbsorbedDoseRate with either grays per second ([Gy_per_s])
  /// or rads per second ([rads_per_s]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  AbsorbedDoseRate({dynamic Gy_per_s, dynamic rads_per_s, double uncert: 0.0})
      : super(Gy_per_s ?? (rads_per_s ?? 0.0),
            rads_per_s != null ? AbsorbedDoseRate.radsPerSecond : AbsorbedDoseRate.graysPerSecond, uncert);

  AbsorbedDoseRate._internal(conv) : super._internal(conv, AbsorbedDoseRate.absorbedDoseRateDimensions);

  /// Constructs an AbsorbedDoseRate based on the [value]
  /// and the conversion factor intrinsic to the provided [units].
  ///
  AbsorbedDoseRate.inUnits(value, AbsorbedDoseRateUnits units, [double uncert = 0.0])
      : super(value, units ?? AbsorbedDoseRate.graysPerSecond, uncert);

  /// Construct a constant AbsorbedDoseRate with its SI value.
  ///
  ///
  ///
  const AbsorbedDoseRate.constant(Number valueSI, {AbsorbedDoseRateUnits  units, double uncert: 0.0})
      : super.constant(valueSI, AbsorbedDoseRate.absorbedDoseRateDimensions, units, uncert);
}

/// Units acceptable for use in describing AbsorbedDoseRate quantities.
///
class AbsorbedDoseRateUnits extends AbsorbedDoseRate with Units {
  AbsorbedDoseRateUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  AbsorbedDoseRateUnits.absorbedDoseTime(AbsorbedDoseUnits adu, TimeUnits tu)
      : super._internal(adu.valueSI * tu.valueSI) {
    this.name = "${adu.name} per ${tu.singular} squared";
    this.singular = "${adu.singular} per ${tu.singular} squared";
    this._convToMKS = adu.valueSI * tu.valueSI;
    this._abbrev1 = adu._abbrev1 != null && tu._abbrev1 != null ? "${adu._abbrev1} / ${tu._abbrev1}" : null;
    this._abbrev2 = adu._abbrev2 != null && tu._abbrev2 != null ? "${adu._abbrev2}${tu._abbrev2}" : null;
    ;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => AbsorbedDoseRate;

  /// Derive new AbsorbedDoseRateUnits using this AbsorbedDoseRateUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new AbsorbedDoseRateUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
