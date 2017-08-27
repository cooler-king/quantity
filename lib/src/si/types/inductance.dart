part of quantity_si;

/// The property of an electrical conductor by which a change in current flowing through
/// it induces an electromotive force in both the conductor itself and in any nearby
/// conductors by mutual inductance.
///
/// See the [Wikipedia entry for Inductance](https://en.wikipedia.org/wiki/Inductance)
/// for more information.
///
class Inductance extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions inductanceDimensions =
      const Dimensions.constant(const {"Length": 2, "Mass": 1, "Current": -2, "Time": -2}, type: Inductance);

  /// The standard SI unit.
  static final InductanceUnits henries = new InductanceUnits("henries", null, "H", "henry", 1.0, true);

  /// Construct an Inductance with henries ([H]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Inductance({dynamic H, double uncert: 0.0}) : super(H ?? 0.0, Illuminance.lux, uncert);

  Inductance._internal(dynamic conv) : super._internal(conv, Inductance.inductanceDimensions);

  /// Constructs a Inductance based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Inductance.inUnits(dynamic value, InductanceUnits units, [double uncert = 0.0])
      : super(value, units ?? Inductance.henries, uncert);

  const Inductance.constant(Number valueSI, {InductanceUnits units, double uncert: 0.0})
      : super.constant(valueSI, Inductance.inductanceDimensions, units, uncert);
}

/// Units acceptable for use in describing Inductance quantities.
///
class InductanceUnits extends Inductance with Units {
  InductanceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Inductance;

  /// Derive new InductanceUnits using this InductanceUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new InductanceUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
