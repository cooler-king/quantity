part of quantity_core;

class Resistance extends Quantity {

  /// Dimensions for this type of quantity
  static const Dimensions electricResistanceDimensions =
      const Dimensions.constant(const {"Current": -2, "Time": -3, "Length": 2, "Mass": 1});

  /** the standard SI unit **/
  static final ResistanceUnits ohms = new ResistanceUnits("ohms", "\u2126", "\u03a9", null, 1.0, true);

  Resistance({dynamic ohms, double uncert: 0.0}) : super(ohms != null ? ohms : 0.0, Resistance.ohms, uncert);

  Resistance._internal(conv) : super._dimensions(conv, Resistance.electricResistanceDimensions);

  /**
   * Constructs a Resistance based on the [value]
   * and the conversion factor intrinsic to the passed [units].
   */
  Resistance.inUnits(value, ResistanceUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Resistance.ohms, uncert);

  const Resistance.constant(Number valueSI, {ResistanceUnits units, num uncert: 0.0})
      : super.constant(valueSI, Resistance.electricResistanceDimensions, units, uncert);
}

/**
 * Units acceptable for use in describing Resistance quantities.
 */
class ResistanceUnits extends Resistance with Units {
  ResistanceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Resistance;

  /**
   * Derive new ResistanceUnits using this ResistanceUnits object as the base.
   */
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new ResistanceUnits("${fullPrefix}${name}", _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null, "${fullPrefix}${singular}", valueSI * conv, false,
        this.offset);
  }
}
