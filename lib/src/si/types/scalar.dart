part of quantity_si;

/// Represents the _scalar_ physical quantity, which is dimensionless or
/// alternatively considered to have a dimension of *1*.
///
class Scalar extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions scalarDimensions = const Dimensions.constant(const {});

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

  Scalar._internal(conv) : super._dimensions(conv, Scalar.scalarDimensions);

  // CONSTRUCTORS
  Scalar.inUnits(value, ScalarUnits units, [double uncert = 0.0]) : super(value, units ?? Scalar.one, uncert);

  const Scalar.constant(value, {ScalarUnits units, double uncert: 0.0})
      : super.constant(value, Scalar.scalarDimensions, units, uncert);

  /// Scalar's hash code is identical to the hash code of its SI value
  /// in order to support functional equality of [Scalar] quantitiess,
  /// [Number]s and [num]s.
  ///
  @override
  int get hashCode => valueSI.hashCode;

  /// Overrides Quantity's addition operator to allow for Scalar addition with
  /// num or Number objects.
  ///
  Quantity operator +(addend) {
    // Scalars can accept numbers as arguments
    if (addend is num || addend is Number) {
      return new Scalar.inUnits(valueSI + addend, Scalar.one, _ur);
    } else if (addend is Scalar) {
      Scalar s2 = addend as Scalar;
      Number sumValue = valueSI + s2.valueSI;
      double sumUr = 0.0;
      if (_ur != 0.0 && s2._ur != 0.0) {
        sumUr = Math.sqrt(_ur * _ur + s2._ur * s2._ur) / sumValue.abs().toDouble();
      }

      return new Scalar.inUnits(valueSI + addend.valueSI, Scalar.one, sumUr);
    } else {
      throw new DimensionsException("Cannot add non-Scalar Quantities to a Scalar");
    }
  }
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
