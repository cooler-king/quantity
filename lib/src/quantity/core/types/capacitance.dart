part of quantity_core;

class Capacitance extends Quantity {

  /// Dimensions for this type of quantity
  static const Dimensions electricCapacitanceDimensions =
      const Dimensions.constant(const {"Time": 4, "Current": 2, "Length": -2, "Mass": -1});

  /** the standard SI unit **/
  static final CapacitanceUnits farads = new CapacitanceUnits("farads", null, "F", null, 1.0, true);

  Capacitance({dynamic F, double uncert: 0.0}) : super(F != null ? F : 0.0, Capacitance.farads, uncert);

  Capacitance._internal(conv) : super._dimensions(conv, Capacitance.electricCapacitanceDimensions);

  /**
   * Constructs a Capacitance based on the [value]
   * and the conversion factor intrinsic to the passed [units].
   */
  Capacitance.inUnits(value, CapacitanceUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Capacitance.farads, uncert);

  const Capacitance.constant(Number valueSI, {CapacitanceUnits units, num uncert: 0.0})
      : super.constant(valueSI, Capacitance.electricCapacitanceDimensions, units, uncert);
}

/**
 * Units acceptable for use in describing Capacitance quantities.
 */
class CapacitanceUnits extends Capacitance with Units {
  CapacitanceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => Capacitance;

  /**
   * Derive new CapacitanceUnits using this CapacitanceUnits object as the base.
   */
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new CapacitanceUnits("${fullPrefix}${name}", _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null, "${fullPrefix}${singular}", valueSI * conv, false,
        this.offset);
  }
}
