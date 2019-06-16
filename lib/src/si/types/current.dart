part of quantity_si;

/// The flow of electric charge.
/// See the [Wikipedia entry for Electric current](https://en.wikipedia.org/wiki/Electric_current)
/// for more information.
class Current extends Quantity {
  /// Constructs a Current with amperes ([A]) or milliamperes ([mA]).
  /// Optionally specify a relative standard uncertainty.
  Current({dynamic A, dynamic mA, double uncert = 0.0})
      : super(A ?? (mA ?? 0.0), mA != null ? Current.milliamperes : Current.amperes, uncert);

  Current._internal(dynamic conv) : super._internal(conv, Current.electricCurrentDimensions);

  /// Constructs a Current based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Current.inUnits(dynamic value, CurrentUnits units, [double uncert = 0.0])
      : super(value, units ?? Current.amperes, uncert);

  /// Constructs a constant electric Current.
  const Current.constant(Number valueSI, {CurrentUnits units, double uncert = 0.0})
      : super.constant(valueSI, Current.electricCurrentDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions electricCurrentDimensions =
      const Dimensions.constant(const <String, int>{'Current': 1}, qType: Current);

  /// The standard SI unit.
  static final CurrentUnits amperes = new CurrentUnits('amperes', 'A', null, null, 1.0, true);

  /// A common metric derivative.
  static final CurrentUnits milliamperes = amperes.milli() as CurrentUnits;
}

/// Units acceptable for use in describing [Current] quantities.
class CurrentUnits extends Current with Units {
  /// Constructs a new instance.
  CurrentUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => Current;

  /// Derive new CurrentUnits using this CurrentUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new CurrentUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
