part of quantity_si;

/// Electric charge per unit volume of space.
///
/// See the [Wikipedia entry for Charge density](https://en.wikipedia.org/wiki/Charge_density)
/// for more information.
///
class ChargeDensity extends Quantity {
  /// Construct a ChargeDensity with coulombs per cubic meter.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  ChargeDensity({dynamic coulombsPerCubicMeter, double uncert = 0.0})
      : super(coulombsPerCubicMeter ?? 0.0, ChargeDensity.coulombsPerCubicMeter, uncert);

  ChargeDensity._internal(dynamic conv) : super._internal(conv, ChargeDensity.electricChargeDensityDimensions);

  /// Constructs a ChargeDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  ChargeDensity.inUnits(dynamic value, ChargeDensityUnits units, [double uncert = 0.0])
      : super(value, units ?? ChargeDensity.coulombsPerCubicMeter, uncert);

  const ChargeDensity.constant(Number valueSI, {ChargeDensityUnits units, double uncert = 0.0})
      : super.constant(valueSI, ChargeDensity.electricChargeDensityDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions electricChargeDensityDimensions =
      const Dimensions.constant(const <String, int>{'Current': 1, 'Time': 1, 'Length': -3}, qType: ChargeDensity);

  /// The standard SI unit.
  static final ChargeDensityUnits coulombsPerCubicMeter =
      new ChargeDensityUnits.chargeVolume(Charge.coulombs, Volume.cubicMeters);
}

/// Units acceptable for use in describing ChargeDensity quantities.
///
class ChargeDensityUnits extends ChargeDensity with Units {
  /// Constructs a new instance.
  ChargeDensityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on charge and volume units.
  ChargeDensityUnits.chargeVolume(ChargeUnits ecu, VolumeUnits vu) : super._internal(ecu.valueSI * vu.valueSI) {
    name = '${ecu.name} per ${vu.singular}';
    singular = '${ecu.singular} per ${vu.singular}';
    _convToMKS = ecu.valueSI * vu.valueSI;
    _abbrev1 = ecu._abbrev1 != null && vu._abbrev1 != null ? '${ecu._abbrev1}/${vu._abbrev1}' : null;
    _abbrev2 = ecu._abbrev2 != null && vu._abbrev2 != null ? '${ecu._abbrev2}/${vu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => ChargeDensity;

  /// Derive new ChargeDensityUnits using this ChargeDensityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new ChargeDensityUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
