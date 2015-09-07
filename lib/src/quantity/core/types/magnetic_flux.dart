part of quantity_core;

class MagneticFlux extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions magneticFluxDimensions = const Dimensions.constant(
      const {"Length": 2, "Time": -2, "Current": -1, "Mass": 1});

  /// The standard SI unit.
  static final MagneticFluxUnits webers =
      new MagneticFluxUnits("webers", null, "Wb", null, 1.0, true);

  MagneticFlux({dynamic Wb, double uncert: 0.0})
      : super(Wb != null ? Wb : 0.0, MagneticFlux.webers, uncert);

  MagneticFlux._internal(conv)
      : super._dimensions(conv, MagneticFlux.magneticFluxDimensions);

  /// Constructs a MagneticFlux based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  MagneticFlux.inUnits(value, MagneticFluxUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : MagneticFlux.webers, uncert);

  const MagneticFlux.constant(Number valueSI,
      {MagneticFluxUnits units, num uncert: 0.0})
      : super.constant(
            valueSI, MagneticFlux.magneticFluxDimensions, units, uncert);
}

/// Units acceptable for use in describing MagneticFlux quantities.
///
class MagneticFluxUnits extends MagneticFlux with Units {
  MagneticFluxUnits(String name, String abbrev1, String abbrev2,
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
  Type get quantityType => MagneticFlux;

  /// Derive new MagneticFluxUnits using this MagneticFluxUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new MagneticFluxUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
