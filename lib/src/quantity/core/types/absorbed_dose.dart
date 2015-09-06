part of quantity_core;

//TODO typedef
class AbsorbedDose extends Quantity {
  //SpecificEnergy {

  /// Dimensions for this type of quantity
  static const Dimensions absorbedDoseDimensions = SpecificEnergy.specificEnergyDimensions;

  /** the standard SI unit **/
  static final AbsorbedDoseUnits grays = new AbsorbedDoseUnits("grays", null, "Gy", null, 1.0, true);

  /** accepted for use with the SI, subject to further review **/
  // Note:  do not use "rad" for singular to avoid confusiion with
  // Angle's radians during parsing & output
  static final AbsorbedDoseUnits rads = new AbsorbedDoseUnits("rads", null, null, "rads", 1.0e-2, true);

  AbsorbedDose({dynamic Gy, dynamic rads, double uncert: 0.0}) : super(
          Gy != null ? Gy : (rads != null ? rads : 0.0), rads != null ? AbsorbedDose.rads : AbsorbedDose.grays, uncert);

  AbsorbedDose._internal(conv) : super._dimensions(conv, AbsorbedDose.absorbedDoseDimensions);

  /**
   * Constructs a AbsorbedDose based on the [value]
   * and the conversion factor intrinsic to the passed [units].
   */
  AbsorbedDose.inUnits(value, AbsorbedDoseUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : AbsorbedDose.grays, uncert);

  const AbsorbedDose.constant(Number valueSI, {AbsorbedDoseUnits units, num uncert: 0.0})
      : super.constant(valueSI, AbsorbedDose.absorbedDoseDimensions, units, uncert);
}

/**
 * Units acceptable for use in describing AbsorbedDose quantities.
 */
class AbsorbedDoseUnits extends AbsorbedDose with Units {
  AbsorbedDoseUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  AbsorbedDoseUnits.lengthTimeUnits(LengthUnits lu, TimeUnits su) : super._internal(lu.valueSI * su.valueSI) {
    this.name = "${lu.name} per ${su.singular} squared";
    this.singular = "${lu.singular} per ${su.singular} squared";
    this._convToMKS = lu.valueSI * su.valueSI;
    this._abbrev1 = lu._abbrev1 != null && su._abbrev1 != null ? "${lu._abbrev1} / ${su._abbrev1}" : null;
    this._abbrev2 = lu._abbrev2 != null && su._abbrev2 != null ? "${lu._abbrev2}${su._abbrev2}" : null;
    ;
    this.metricBase = metricBase;
    this.offset = offset;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => AbsorbedDose;

  /**
   * Derive new AbsorbedDoseUnits using this AbsorbedDoseUnits object as the base.
   */
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new AbsorbedDoseUnits("${fullPrefix}${name}", _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null, "${fullPrefix}${singular}", valueSI * conv, false,
        this.offset);
  }
}
