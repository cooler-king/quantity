part of quantity_si;

/// The property of matter that causes it to experience a force when placed in an
/// electromagnetic field
///
/// See the [Wikipedia entry for Electric charge](https://en.wikipedia.org/wiki/Electric_charge)
/// for more information.
///
class Charge extends Quantity {
  /// Construct a Charge with coulombs ([C]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Charge({dynamic C, double uncert = 0.0}) : super(C ?? 0.0, Charge.coulombs, uncert);

  Charge._internal(dynamic conv) : super._internal(conv, Charge.electricChargeDimensions);

  /// Constructs a Charge based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Charge.inUnits(dynamic value, ChargeUnits units, [double uncert = 0.0])
      : super(value, units ?? Charge.coulombs, uncert);

  const Charge.constant(Number valueSI, {ChargeUnits units, double uncert = 0.0})
      : super.constant(valueSI, Charge.electricChargeDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions electricChargeDimensions =
      const Dimensions.constant(const <String, int>{'Current': 1, 'Time': 1}, qType: Charge);

  /// The standard SI unit.
  static final ChargeUnits coulombs = new ChargeUnits('coulombs', null, 'C', null, 1.0, true);
}

/// Units acceptable for use in describing Charge quantities.
///
class ChargeUnits extends Charge with Units {
  ChargeUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  ChargeUnits.currentTime(CurrentUnits cu, TimeUnits tu) : super._internal(cu.valueSI * tu.valueSI) {
    name = '${cu.name} ${tu.name}';
    singular = '${cu.singular} ${tu.singular}';
    _convToMKS = cu.valueSI * tu.valueSI;
    _abbrev1 = cu._abbrev1 != null && tu._abbrev1 != null ? '${cu._abbrev1}${tu._abbrev1}' : null;
    _abbrev2 = cu._abbrev2 != null && tu._abbrev2 != null ? '${cu._abbrev2}${tu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Charge;

  /// Derive new ChargeUnits using this ChargeUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new ChargeUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
