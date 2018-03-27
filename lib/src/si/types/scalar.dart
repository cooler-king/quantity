part of quantity_si;

/// A one-dimensional physical quantity that can be described by a single real number.
///
/// See the [Wikipedia entry for Scalar (physics)](https://en.wikipedia.org/wiki/Scalar_%28physics%29)
/// for more information.
///
class Scalar extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions scalarDimensions = const Dimensions.constant(const <String, int>{}, qType: Scalar);

  // Units

  /// The standard SI unit; may be represented by '1' but is typically not displayed at all.
  static final ScalarUnits one = new ScalarUnits('1', null, null, '1', Double.one, false);

  /// Acceptable for use with the SI; percent (%) represents the number 0.01
  static final ScalarUnits percent =
      new ScalarUnits('percent', null, '%', 'percent', const Double.constant(0.01), false);

  /// Construct a Scalar with [value] or [percent].
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Scalar({dynamic value, dynamic percent, double uncert: 0.0})
      : super(percent ?? (value ?? 0.0), percent != null ? Scalar.percent : Scalar.one, uncert);

  Scalar._internal(dynamic conv) : super._internal(conv, Scalar.scalarDimensions);

  // CONSTRUCTORS
  Scalar.inUnits(dynamic value, ScalarUnits units, [double uncert = 0.0]) : super(value, units ?? Scalar.one, uncert);

  const Scalar.constant(Number value, {ScalarUnits units, double uncert: 0.0})
      : super.constant(value, Scalar.scalarDimensions, units, uncert);

  /// Scalar's hash code is identical to the hash code of its SI value
  /// in order to support functional equality of [Scalar] quantities,
  /// [Number]s and [num]s.
  @override
  int get hashCode => valueSI.hashCode;

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  /// Compares this Scalar to [q2] by comparing MKS values or if q2 is a [num] or [Number], by comparing
  /// the values directly.  If [q2] is a Quantity it need not have Scalar dimensions.
  ///
  /// This method overrides the Quantity.compareTo() method in order to allow for Scalar to be compared
  /// directly to nums and Numbers.
  ///
  /// Returns a negative integer, zero, or a positive integer as this Quantity is
  /// less than, equal to, or greater than [q2].
  ///
  @override
  int compareTo(dynamic q2) {
    if (q2 is num || q2 is Number) return valueSI.compareTo(q2);
    return super.compareTo(q2);
  }
}

/// Units acceptable for use in describing Scalar quantities.
///
class ScalarUnits extends Scalar with Units {
  /// Constructs a new instance.
  ScalarUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => Scalar;

  /// Derive new ScalarUnits using this ScalarUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new ScalarUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
  
}
