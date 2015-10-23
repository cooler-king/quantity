part of quantity_si;

/// A one-dimensional physical quantity that can be described by a single real number.
///
/// See the [Wikipedia entry for Scalar (physics)](https://en.wikipedia.org/wiki/Scalar_%28physics%29)
/// for more information.
///
class Scalar extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions scalarDimensions = const Dimensions.constant(const {}, type: Scalar);

  // Units

  /// The standard SI unit; may be represented by "1" but is typically not displayed at all.
  static final ScalarUnits one = new ScalarUnits("1", null, null, "1", Double.one, false);

  /// Acceptable for use with the SI; percent (%) represents the number 0.01
  static final ScalarUnits percent =
      new ScalarUnits("percent", null, "%", "percent", const Double.constant(0.01), false);

  /// Construct a Scalar with [value] or [percent].
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Scalar({value, percent, double uncert: 0.0})
      : super(percent ?? (value ?? 0.0), percent != null ? Scalar.percent : Scalar.one, uncert);

  Scalar._internal(conv) : super._internal(conv, Scalar.scalarDimensions);

  // CONSTRUCTORS
  Scalar.inUnits(value, ScalarUnits units, [double uncert = 0.0]) : super(value, units ?? Scalar.one, uncert);

  const Scalar.constant(value, {ScalarUnits units, double uncert: 0.0})
      : super.constant(value, Scalar.scalarDimensions, units, uncert);

  /// Scalar's hash code is identical to the hash code of its SI value
  /// in order to support functional equality of [Scalar] quantities,
  /// [Number]s and [num]s.
  ///
  @override
  int get hashCode => valueSI.hashCode;
}

/// Units acceptable for use in describing Scalar quantities.
///
class ScalarUnits extends Scalar with Units {
  ScalarUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => Scalar;

  /// Derive new ScalarUnits using this ScalarUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new ScalarUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
