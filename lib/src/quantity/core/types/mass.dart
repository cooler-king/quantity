part of quantity_core;

/**
 * Represents the *mass* physical quantity (one of the seven base SI quantities).
 */
class Mass extends Quantity {

  /// Dimensions for this type of quantity
  static const Dimensions massDimensions = const Dimensions.constant(const {"Mass": 1});

  /** the standard SI unit **/
  static final MassUnits kilograms = new MassUnits("kilograms", "kg", null, null, 1.0, false);

  /**
   * Note: kilograms are the standard MKS unit for mass, but grams is used here
   * to generate the appropriate prefixes.  Gram conversion value is set to 0.001
   * in order to generate the correct units.
   */
  static final MassUnits grams = new MassUnits("grams", "g", null, null, 0.001, true);

  /** accepted for use with the SI **/
  static final MassUnits metricTons = grams.mega();

  /** accepted for use with the SI **/
  static final MassUnits tonnes = metricTons;

  /** accepted for use with the SI **/
  static final MassUnits unifiedAtomicMassUnits =
      new MassUnits("unified atomic mass units", null, "u", null, 1.66053886e-27, false);

  Mass({dynamic kg, dynamic g, dynamic au, double uncert: 0.0}) : super(
          kg != null ? kg : (g != null ? g : (au != null ? au : 0.0)),
          g != null ? Mass.grams : (au != null ? Mass.unifiedAtomicMassUnits : Mass.kilograms), uncert);

  Mass._internal(conv) : super._dimensions(conv, Mass.massDimensions);

  /**
   * Constructs a Mass based on the [value]
   * and the conversion factor intrinsic to the passed [units].
   */
  Mass.inUnits(value, MassUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Mass.kilograms, uncert);

  const Mass.constant(Number valueSI, {MassUnits units, num uncert: 0.0})
      : super.constant(valueSI, Mass.massDimensions, units, uncert);
}

/**
 * Units acceptable for use in describing [Mass] quantities.
 */
class MassUnits extends Mass with Units {
  MassUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => Mass;

  /**
   * Derive new MassUnits using this MassUnits object as the base.
   */
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new MassUnits("${fullPrefix}${name}", _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null, "${fullPrefix}${singular}", valueSI * conv, false,
        this.offset);
  }
}
