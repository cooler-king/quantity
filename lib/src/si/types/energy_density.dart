part of quantity_si;

/// The amount of energy stored in a given system or region of space per unit volume.
///
/// See the [Wikipedia entry for Energy density](https://en.wikipedia.org/wiki/Energy_density)
/// for more information.
///
class EnergyDensity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions energyDensityDimensions = Pressure.pressureDimensions;

  /// The standard SI unit.
  static final EnergyDensityUnits joulesPerCubicMeter =
      new EnergyDensityUnits.energyVolume(Energy.joules, Volume.cubicMeters);

  /// Construct an EnergyDensity with joules per cubic meter ([J_per_m3]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  EnergyDensity({dynamic J_per_m3, double uncert: 0.0})
      : super(J_per_m3 ?? 0.0, EnergyDensity.joulesPerCubicMeter, uncert);

  EnergyDensity._internal(conv) : super._internal(conv, EnergyDensity.energyDensityDimensions);

  /// Constructs a EnergyDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  EnergyDensity.inUnits(value, EnergyDensityUnits units, [double uncert = 0.0])
      : super(value, units ?? EnergyDensity.joulesPerCubicMeter, uncert);

  const EnergyDensity.constant(Number valueSI, {EnergyDensityUnits units, num uncert: 0.0})
      : super.constant(valueSI, EnergyDensity.energyDensityDimensions, units, uncert);
}

/// Units acceptable for use in describing EnergyDensity quantities.
///
class EnergyDensityUnits extends EnergyDensity with Units {
  EnergyDensityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  EnergyDensityUnits.energyVolume(EnergyUnits eu, VolumeUnits vu) : super._internal(eu.valueSI * vu.valueSI) {
    this.name = "${eu.name} per ${vu.singular}";
    this.singular = "${eu.singular} per ${vu.singular}";
    this._convToMKS = eu.valueSI * vu.valueSI;
    this._abbrev1 = eu._abbrev1 != null && vu._abbrev1 != null ? "${eu._abbrev1} / ${vu._abbrev1}" : null;
    this._abbrev2 = eu._abbrev2 != null && vu._abbrev2 != null ? "${eu._abbrev2}/${vu._abbrev2}" : null;
    ;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => EnergyDensity;

  /// Derive new EnergyDensityUnits using this EnergyDensityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new EnergyDensityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
