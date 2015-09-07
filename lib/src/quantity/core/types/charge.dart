part of quantity_core;

class Charge extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions electricChargeDimensions =
      const Dimensions.constant(const {"Current": 1, "Time": 1});

  /// The standard SI unit.
  static final ChargeUnits coulombs =
      new ChargeUnits("coulombs", null, "C", null, 1.0, true);

  Charge({dynamic C, double uncert: 0.0})
      : super(C != null ? C : 0.0, Charge.coulombs, uncert);

  Charge._internal(conv)
      : super._dimensions(conv, Charge.electricChargeDimensions);

  /// Constructs a Charge based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Charge.inUnits(value, ChargeUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Charge.coulombs, uncert);

  const Charge.constant(Number valueSI, {ChargeUnits units, num uncert: 0.0})
      : super.constant(valueSI, Charge.electricChargeDimensions, units, uncert);
}

/// Units acceptable for use in describing Charge quantities.
///
class ChargeUnits extends Charge with Units {
  ChargeUnits(String name, String abbrev1, String abbrev2, String singular,
      dynamic conv,
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
  Type get quantityType => Charge;

  /// Derive new ChargeUnits using this ChargeUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new ChargeUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
