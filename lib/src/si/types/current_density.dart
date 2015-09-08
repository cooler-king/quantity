part of quantity_si;

class CurrentDensity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions electricCurrentDensityDimensions =
      const Dimensions.constant(const {"Current": 1, "Length": -2});

  /// The standard SI unit.
  static final CurrentDensityUnits amperesPerSquareMeter =
      new CurrentDensityUnits.currentArea(Current.amperes, Area.squareMeters);

  CurrentDensity({dynamic A_per_m2, double uncert: 0.0})
      : super(A_per_m2 != null ? A_per_m2 : 0.0, CurrentDensity.amperesPerSquareMeter, uncert);

  CurrentDensity._internal(conv) : super._dimensions(conv, CurrentDensity.electricCurrentDensityDimensions);

  /// Constructs a CurrentDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  CurrentDensity.inUnits(value, CurrentDensityUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : CurrentDensity.amperesPerSquareMeter, uncert);

  const CurrentDensity.constant(Number valueSI, {CurrentDensityUnits units, num uncert: 0.0})
      : super.constant(valueSI, CurrentDensity.electricCurrentDensityDimensions, units, uncert);
}

/// Units acceptable for use in describing CurrentDensity quantities.
///
class CurrentDensityUnits extends CurrentDensity with Units {
  CurrentDensityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  CurrentDensityUnits.currentArea(CurrentUnits ecu, AreaUnits au) : super._internal(ecu.valueSI * au.valueSI) {
    this.name = "${ecu.name} per ${au.singular}";
    this.singular = "${ecu.singular} per ${au.singular}";
    this._convToMKS = ecu.valueSI * au.valueSI;
    this._abbrev1 = ecu._abbrev1 != null && au._abbrev1 != null ? "${ecu._abbrev1} / ${au._abbrev1}" : null;
    this._abbrev2 = ecu._abbrev2 != null && au._abbrev2 != null ? "${ecu._abbrev2}/${au._abbrev2}" : null;
    ;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => CurrentDensity;

  /// Derive new CurrentDensityUnits using this CurrentDensityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new CurrentDensityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
