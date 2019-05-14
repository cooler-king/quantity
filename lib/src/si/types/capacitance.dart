part of quantity_si;

/// The ability of a body to store an electrical charge,
///
/// See the [Wikipedia entry for Capacitance](https://en.wikipedia.org/wiki/Capacitance)
/// for more information.
///
class Capacitance extends Quantity {
  /// Construct a Capacitance with farads ([F]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Capacitance({dynamic F, double uncert = 0.0}) : super(F ?? 0.0, Capacitance.farads, uncert);

  Capacitance._internal(dynamic conv) : super._internal(conv, Capacitance.electricCapacitanceDimensions);

  /// Constructs a Capacitance based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Capacitance.inUnits(dynamic value, CapacitanceUnits units, [double uncert = 0.0])
      : super(value, units ?? Capacitance.farads, uncert);

  const Capacitance.constant(Number valueSI, {CapacitanceUnits units, double uncert = 0.0})
      : super.constant(valueSI, Capacitance.electricCapacitanceDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions electricCapacitanceDimensions = const Dimensions.constant(
      const <String, int>{'Time': 4, 'Current': 2, 'Length': -2, 'Mass': -1},
      qType: Capacitance);

  /// The standard SI unit.
  static final CapacitanceUnits farads = new CapacitanceUnits('farads', null, 'F', null, 1.0, true);
}

/// Units acceptable for use in describing Capacitance quantities.
///
class CapacitanceUnits extends Capacitance with Units {
  /// Constructs a new instance.
  CapacitanceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Capacitance;

  /// Derive new CapacitanceUnits using this CapacitanceUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new CapacitanceUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
