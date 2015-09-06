part of quantity_core;

class AbsorbedDoseRate extends Quantity {

  /// Dimensions for this type of quantity
  static const Dimensions ABSORBED_DOSE_RATE_DIMENSIONS = const Dimensions.constant(const {"Length": 2, "Time": -3});

  /** the standard SI unit **/
  static final AbsorbedDoseRateUnits grayPerSecond =
      new AbsorbedDoseRateUnits.absorbedDoseTime(AbsorbedDose.grays, Time.seconds);

  /** accepted for use with the SI **/
  static final AbsorbedDoseRateUnits radsPerSecond =
      new AbsorbedDoseRateUnits.absorbedDoseTime(AbsorbedDose.rads, Time.seconds);

  AbsorbedDoseRate({dynamic Gy_per_s, dynamic rads_per_s, double uncert: 0.0}) : super(
          Gy_per_s != null ? Gy_per_s : (rads_per_s != null ? rads_per_s : 0.0),
          rads_per_s != null ? AbsorbedDoseRate.radsPerSecond : AbsorbedDoseRate.grayPerSecond, uncert);

  AbsorbedDoseRate._internal(conv) : super._dimensions(conv, AbsorbedDoseRate.ABSORBED_DOSE_RATE_DIMENSIONS);

  /**
   * Constructs a AbsorbedDoseRate based on the [value]
   * and the conversion factor intrinsic to the passed [units].
   */
  AbsorbedDoseRate.inUnits(value, AbsorbedDoseRateUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : AbsorbedDoseRate.grayPerSecond, uncert);

  const AbsorbedDoseRate.constant(Number valueSI, {AbsorbedDoseRateUnits units, num uncert: 0.0})
      : super.constant(valueSI, AbsorbedDoseRate.ABSORBED_DOSE_RATE_DIMENSIONS, units, uncert);
}

/**
 * Units acceptable for use in describing AbsorbedDoseRate quantities.
 */
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
    this.offset = offset;
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
    this.offset = offset;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => AbsorbedDoseRate;

  /**
   * Derive new AbsorbedDoseRateUnits using this AbsorbedDoseRateUnits object as the base.
   */
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new AbsorbedDoseRateUnits("${fullPrefix}${name}", _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null, "${fullPrefix}${singular}", valueSI * conv, false,
        this.offset);
  }
}
