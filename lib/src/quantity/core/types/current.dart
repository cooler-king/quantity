part of quantity_core;

class Current extends Quantity {

  /// Dimensions for this type of quantity
  static const Dimensions electricCurrentDimensions = const Dimensions.constant(const {"Current": 1});

  /** the standard SI unit **/
  static final CurrentUnits amperes = new CurrentUnits("amperes", "A", null, null, 1.0, true);

  /** a common metric derivative */
  static final CurrentUnits milliamperes = amperes.milli();

  Current({dynamic A, dynamic mA, double uncert: 0.0})
      : super(A != null ? A : (mA != null ? mA : 0.0), mA != null ? Current.milliamperes : Current.amperes, uncert);

  Current._internal(conv) : super._dimensions(conv, Current.electricCurrentDimensions);

  /**
   * Constructs a Current based on the [value]
   * and the conversion factor intrinsic to the passed [units].
   */
  Current.inUnits(value, CurrentUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Current.amperes, uncert);

  const Current.constant(Number valueSI, {CurrentUnits units, num uncert: 0.0})
      : super.constant(valueSI, Current.electricCurrentDimensions, units, uncert);
}

/**
 * Units acceptable for use in describing [Current] quantities.
 */
class CurrentUnits extends Current with Units {
  CurrentUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => Current;

  /**
   * Derive new CurrentUnits using this CurrentUnits object as the base.
   */
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new CurrentUnits("${fullPrefix}${name}", _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null, "${fullPrefix}${singular}", valueSI * conv, false,
        this.offset);
  }
}
