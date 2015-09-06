part of quantity_core;

class LuminousFlux extends Quantity {

  /// Dimensions for this type of quantity
  static const Dimensions luminousFluxDimensions = const Dimensions.constant(const {"Intensity": 1, "Solid Angle": 1});

  /** the standard SI unit **/
  static final LuminousFluxUnits lumens = new LuminousFluxUnits("lumens", null, "lm", null, 1.0, true);

  LuminousFlux({dynamic lm, double uncert: 0.0}) : super(lm != null ? lm : 0.0, LuminousFlux.lumens, uncert);

  LuminousFlux._internal(conv) : super._dimensions(conv, LuminousFlux.luminousFluxDimensions);

  /**
   * Constructs a LuminousFlux based on the [value]
   * and the conversion factor intrinsic to the passed [units].
   */
  LuminousFlux.inUnits(value, LuminousFluxUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : LuminousFlux.lumens, uncert);

  const LuminousFlux.constant(Number valueSI, {LuminousFluxUnits units, num uncert: 0.0})
      : super.constant(valueSI, LuminousFlux.luminousFluxDimensions, units, uncert);
}

/**
 * Units acceptable for use in describing LuminousFlux quantities.
 */
class LuminousFluxUnits extends LuminousFlux with Units {
  LuminousFluxUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => LuminousFlux;

  /**
   * Derive new LuminousFluxUnits using this LuminousFluxUnits object as the base.
   */
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new LuminousFluxUnits("${fullPrefix}${name}", _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null, "${fullPrefix}${singular}", valueSI * conv, false,
        this.offset);
  }
}
