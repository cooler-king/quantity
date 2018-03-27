part of quantity_si;

/// A measure of the difficulty passing an electric current through a conductor.
///
/// See the [Wikipedia entry for Electrical resistance and conductance](https://en.wikipedia.org/wiki/Electrical_resistance_and_conductance)
/// for more information.
///
class Resistance extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions electricResistanceDimensions =
      const Dimensions.constant(const <String, int>{'Current': -2, 'Time': -3, 'Length': 2, 'Mass': 1}, qType: Resistance);

  /// The standard SI unit.
  static final ResistanceUnits ohms = new ResistanceUnits('ohms', '\u2126', '\u03a9', null, 1.0, true);

  /// Construct a Resistance with [ohms].
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Resistance({dynamic ohms, double uncert: 0.0}) : super(ohms ?? 0.0, Resistance.ohms, uncert);

  Resistance._internal(dynamic conv) : super._internal(conv, Resistance.electricResistanceDimensions);

  /// Constructs a Resistance based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Resistance.inUnits(dynamic value, ResistanceUnits units, [double uncert = 0.0])
      : super(value, units ?? Resistance.ohms, uncert);

  const Resistance.constant(Number valueSI, {ResistanceUnits units, double uncert: 0.0})
      : super.constant(valueSI, Resistance.electricResistanceDimensions, units, uncert);
}

/// Units acceptable for use in describing Resistance quantities.
///
class ResistanceUnits extends Resistance with Units {
  /// Constructs a new instance.
  ResistanceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => Resistance;

  /// Derive new ResistanceUnits using this ResistanceUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new ResistanceUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);

}
