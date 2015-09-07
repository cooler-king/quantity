part of quantity_core;

class MagneticFluxDensity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions magneticFluxDensityDimensions =
      const Dimensions.constant(const {"Mass": 1, "Current": -1, "Time": -2});

  /// The standard SI unit.
  static final MagneticFluxDensityUnits teslas =
      new MagneticFluxDensityUnits("teslas", null, "T", null, 1.0, true);

  MagneticFluxDensity({dynamic T, double uncert: 0.0})
      : super(T != null ? T : 0.0, MagneticFluxDensity.teslas, uncert);

  MagneticFluxDensity._internal(conv)
      : super._dimensions(
            conv, MagneticFluxDensity.magneticFluxDensityDimensions);

  /// Constructs a MagneticFluxDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  MagneticFluxDensity.inUnits(value, MagneticFluxDensityUnits units,
      [double uncert = 0.0])
      : super(
            value, units != null ? units : MagneticFluxDensity.teslas, uncert);

  const MagneticFluxDensity.constant(Number valueSI,
      {MagneticFluxDensityUnits units, num uncert: 0.0})
      : super.constant(valueSI,
            MagneticFluxDensity.magneticFluxDensityDimensions, units, uncert);
}

/// Units acceptable for use in describing MagneticFluxDensity quantities.
///
class MagneticFluxDensityUnits extends MagneticFluxDensity with Units {
  MagneticFluxDensityUnits(String name, String abbrev1, String abbrev2,
      String singular, dynamic conv,
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
  Type get quantityType => MagneticFluxDensity;

  /// Derive new MagneticFluxDensityUnits using this MagneticFluxDensityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new MagneticFluxDensityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
