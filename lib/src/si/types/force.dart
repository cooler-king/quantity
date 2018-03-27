part of quantity_si;

/// Any interaction that, when unopposed, changes the motion of an object.
///
/// See the [Wikipedia entry for Force](https://en.wikipedia.org/wiki/Force)
/// for more information.
///
class Force extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions forceDimensions =
      const Dimensions.constant(const <String, int>{'Length': 1, 'Mass': 1, 'Time': -2}, qType: Force);

  /// The standard SI unit.
  static final ForceUnits newtons = new ForceUnits('newtons', null, 'N', null, 1.0, true);

  /// Construct a Force with newtons ([N]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Force({dynamic N, double uncert: 0.0}) : super(N ?? 0.0, Force.newtons, uncert);

  Force._internal(dynamic conv) : super._internal(conv, Force.forceDimensions);

  /// Constructs a Force based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Force.inUnits(dynamic value, ForceUnits units, [double uncert = 0.0]) : super(value, units ?? Force.newtons, uncert);

  const Force.constant(Number valueSI, {ForceUnits units, double uncert: 0.0})
      : super.constant(valueSI, Force.forceDimensions, units, uncert);

  Force.ma(Mass m, Acceleration a)
      : super(m.valueSI * a.valueSI, Force.newtons, math.sqrt(m._ur * m._ur + a._ur * a._ur));
}

/// Units acceptable for use in describing Force quantities.
///
class ForceUnits extends Force with Units {
  ForceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => Force;

  /// Derive new ForceUnits using this ForceUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new ForceUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);

}
