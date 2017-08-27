part of quantity_si;

/// The property of matter that causes it to experience a force when placed in an
/// electromagnetic field
///
/// See the [Wikipedia entry for Electric charge](https://en.wikipedia.org/wiki/Electric_charge)
/// for more information.
///
class Charge extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions electricChargeDimensions =
      const Dimensions.constant(const {"Current": 1, "Time": 1}, type: Charge);

  /// The standard SI unit.
  static final ChargeUnits coulombs = new ChargeUnits("coulombs", null, "C", null, 1.0, true);

  /// Construct a Charge with coulombs ([C]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Charge({dynamic C, double uncert: 0.0}) : super(C ?? 0.0, Charge.coulombs, uncert);

  Charge._internal(dynamic conv) : super._internal(conv, Charge.electricChargeDimensions);

  /// Constructs a Charge based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Charge.inUnits(dynamic value, ChargeUnits units, [double uncert = 0.0])
      : super(value, units ?? Charge.coulombs, uncert);

  const Charge.constant(Number valueSI, {ChargeUnits units, double uncert: 0.0})
      : super.constant(valueSI, Charge.electricChargeDimensions, units, uncert);
}

/// Units acceptable for use in describing Charge quantities.
///
class ChargeUnits extends Charge with Units {
  ChargeUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  ChargeUnits.currentTime(CurrentUnits cu, TimeUnits tu) : super._internal(cu.valueSI * tu.valueSI) {
    this.name = "${cu.name} ${tu.name}";
    this.singular = "${cu.singular} ${tu.singular}";
    this._convToMKS = cu.valueSI * tu.valueSI;
    this._abbrev1 = cu._abbrev1 != null && tu._abbrev1 != null ? "${cu._abbrev1}${tu._abbrev1}" : null;
    this._abbrev2 = cu._abbrev2 != null && tu._abbrev2 != null ? "${cu._abbrev2}${tu._abbrev2}" : null;
    ;
    this.metricBase = false;
    this.offset = 0.0;
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
