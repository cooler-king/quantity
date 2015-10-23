part of quantity_si;

/// Mass per unit volume.
///
/// See the [Wikipedia entry for Density](https://en.wikipedia.org/wiki/Density)
/// for more information.
///
class MassDensity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions massDensityDimensions =
      const Dimensions.constant(const {"Mass": 1, "Length": -3}, type: MassDensity);

  /// The standard SI unit.
  static final MassDensityUnits kilogramsPerCubicMeter =
      new MassDensityUnits.massVolume(Mass.kilograms, Volume.cubicMeters);

  /// Construct a MassDensity with kilograms per cubic meter ([kg_per_m3]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  MassDensity({dynamic kg_per_m3, double uncert: 0.0})
      : super(kg_per_m3 ?? 0.0, MassDensity.kilogramsPerCubicMeter, uncert);

  MassDensity._internal(conv) : super._internal(conv, MassDensity.massDensityDimensions);

  /// Constructs a MassDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  MassDensity.inUnits(value, MassDensityUnits units, [double uncert = 0.0])
      : super(value, units ?? MassDensity.kilogramsPerCubicMeter, uncert);

  const MassDensity.constant(Number valueSI, {MassDensityUnits units, num uncert: 0.0})
      : super.constant(valueSI, MassDensity.massDensityDimensions, units, uncert);
}

/// Units acceptable for use in describing MassDensity quantities.
///
class MassDensityUnits extends MassDensity with Units {
  MassDensityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  MassDensityUnits.massVolume(MassUnits mu, VolumeUnits vu) : super._internal(mu.valueSI * vu.valueSI) {
    this.name = "${mu.name} per ${vu.singular}";
    this.singular = "${mu.singular} per ${vu.singular}";
    this._convToMKS = mu.valueSI * vu.valueSI;
    this._abbrev1 = mu._abbrev1 != null && vu._abbrev1 != null ? "${mu._abbrev1} / ${vu._abbrev1}" : null;
    this._abbrev2 = mu._abbrev2 != null && vu._abbrev2 != null ? "${mu._abbrev2}${vu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => MassDensity;

  /// Derive new MassDensityUnits using this MassDensityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new MassDensityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
