part of quantity_si;

/// The amount of energy stored in a given system or region of space per unit volume.
///
/// See the [Wikipedia entry for Energy density](https://en.wikipedia.org/wiki/Energy_density)
/// for more information.
///
class EnergyDensity extends Quantity {
  /// Construct an EnergyDensity with joules per cubic meter.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  EnergyDensity({dynamic joulesPerCubicMeter, double uncert = 0.0})
      : super(joulesPerCubicMeter ?? 0.0, EnergyDensity.joulesPerCubicMeter, uncert);

  EnergyDensity._internal(dynamic conv) : super._internal(conv, EnergyDensity.energyDensityDimensions);

  /// Constructs a EnergyDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  EnergyDensity.inUnits(dynamic value, EnergyDensityUnits units, [double uncert = 0.0])
      : super(value, units ?? EnergyDensity.joulesPerCubicMeter, uncert);

  const EnergyDensity.constant(Number valueSI, {EnergyDensityUnits units, double uncert = 0.0})
      : super.constant(valueSI, EnergyDensity.energyDensityDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions energyDensityDimensions =
      const Dimensions.constant(const <String, int>{'Length': -1, 'Mass': 1, 'Time': -2}, qType: EnergyDensity);

  /// The standard SI unit.
  static final EnergyDensityUnits joulesPerCubicMeter =
      new EnergyDensityUnits.energyVolume(Energy.joules, Volume.cubicMeters);
}

/// Units acceptable for use in describing EnergyDensity quantities.
///
class EnergyDensityUnits extends EnergyDensity with Units {
  /// Constructs a new instance.
  EnergyDensityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super._internal(conv) {
    this.name = name;
    this.singular = singular;
    _convToMKS = objToNumber(conv);
    _abbrev1 = abbrev1;
    _abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  /// Constructs a new instance based on energy and volume units.
  EnergyDensityUnits.energyVolume(EnergyUnits eu, VolumeUnits vu) : super._internal(eu.valueSI * vu.valueSI) {
    name = '${eu.name} per ${vu.singular}';
    singular = '${eu.singular} per ${vu.singular}';
    _convToMKS = eu.valueSI * vu.valueSI;
    _abbrev1 = eu._abbrev1 != null && vu._abbrev1 != null ? '${eu._abbrev1} / ${vu._abbrev1}' : null;
    _abbrev2 = eu._abbrev2 != null && vu._abbrev2 != null ? '${eu._abbrev2}/${vu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => EnergyDensity;

  /// Derive new EnergyDensityUnits using this EnergyDensityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new EnergyDensityUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
