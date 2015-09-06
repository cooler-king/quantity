part of quantity_core;

// also MomentOfForce

class Torque extends Quantity {

  /// Dimensions for this type of quantity (energy per angle rather than LengthxForce)
  static const Dimensions torqueDimensions =
      const Dimensions.constant(const {"Length": 2, "Time": -2, "Mass": 1, "Angle": -1});

  //TODO autoconvert Newton meters to JOules per radian
  // complicated... torque used both with and without angle dimension component
  // without it its same as Energy so we use it

  /** the standard SI unit **/
  static final TorqueUnits newtonMeters = new TorqueUnits.forceLength(Force.newtons, Length.meters);

  Torque({dynamic Nm, double uncert: 0.0}) : super(Nm != null ? Nm : 0.0, Torque.newtonMeters, uncert);

  Torque._internal(conv) : super._dimensions(conv, Torque.torqueDimensions);

  /**
   * Constructs a Torque based on the [value]
   * and the conversion factor intrinsic to the passed [units].
   */
  Torque.inUnits(value, TorqueUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Torque.newtonMeters, uncert);

  const Torque.constant(Number valueSI, {TorqueUnits units, num uncert: 0.0})
      : super.constant(valueSI, Torque.torqueDimensions, units, uncert);
}

/**
 * Units acceptable for use in describing Torque quantities.
 */
class TorqueUnits extends Torque with Units {
  TorqueUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  TorqueUnits.forceLength(ForceUnits fu, LengthUnits lu) : super._internal(fu.valueSI * lu.valueSI) {
    this.name = "${fu.singular} ${lu.name}";
    this.singular = "${fu.singular} ${lu.singular}";
    this._convToMKS = fu.valueSI * lu.valueSI;
    this._abbrev1 = fu._abbrev1 != null && lu._abbrev1 != null ? "${fu._abbrev1} ${lu._abbrev1}" : null;
    this._abbrev2 = fu._abbrev2 != null && lu._abbrev2 != null ? "${fu._abbrev2}${lu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Torque;

  /**
   * Derive new TorqueUnits using this TorqueUnits object as the base.
   */
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new TorqueUnits("${fullPrefix}${name}", _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null, "${fullPrefix}${singular}", valueSI * conv, false,
        this.offset);
  }
}
