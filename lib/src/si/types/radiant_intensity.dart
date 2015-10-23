part of quantity_si;

/// The radiant flux emitted, reflected, transmitted or received, per unit solid angle.
///
/// See the [Wikipedia entry for Radiant intensity](https://en.wikipedia.org/wiki/Radiant_intensity)
/// for more information.
///
class RadiantIntensity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions radiantIntensityDimensions =
      const Dimensions.constant(const {"Length": 2, "Mass": 1, "Time": -3, "Solid Angle": -1}, type: RadiantIntensity);

  /// The standard SI unit.
  static final RadiantIntensityUnits wattsPerSteradian =
      new RadiantIntensityUnits.powerSolidAngle(Power.watts, SolidAngle.steradians);

  /// Construct a RadiantIntensity with watts per steradian ([W_per_sr]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  RadiantIntensity({dynamic W_per_sr, double uncert: 0.0})
      : super(W_per_sr ?? 0.0, RadiantIntensity.wattsPerSteradian, uncert);

  RadiantIntensity._internal(conv) : super._internal(conv, RadiantIntensity.radiantIntensityDimensions);

  /// Constructs a RadiantIntensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  RadiantIntensity.inUnits(value, RadiantIntensityUnits units, [double uncert = 0.0])
      : super(value, units ?? RadiantIntensity.wattsPerSteradian, uncert);

  const RadiantIntensity.constant(Number valueSI, {RadiantIntensityUnits units, num uncert: 0.0})
      : super.constant(valueSI, RadiantIntensity.radiantIntensityDimensions, units, uncert);
}

/// Units acceptable for use in describing RadiantIntensity quantities.
///
class RadiantIntensityUnits extends RadiantIntensity with Units {
  RadiantIntensityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  RadiantIntensityUnits.powerSolidAngle(PowerUnits pu, SolidAngleUnits sau)
      : super._internal(pu.valueSI / sau.valueSI) {
    this.name = "${pu.name} per ${sau.singular}";
    this.singular = "${pu.singular} per ${sau.singular}";
    this._convToMKS = pu.valueSI / sau.valueSI;
    this._abbrev1 = pu._abbrev1 != null && sau._abbrev1 != null ? "${pu._abbrev1} / ${sau._abbrev1}" : null;
    this._abbrev2 = pu._abbrev2 != null && sau._abbrev2 != null ? "${pu._abbrev2}/${sau._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => RadiantIntensity;

  /// Derive new RadiantIntensityUnits using this RadiantIntensityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new RadiantIntensityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
