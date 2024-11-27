import 'package:quantity/quantity.dart';

/// Electric charge per unit volume of space.
/// See the [Wikipedia entry for Charge density](https://en.wikipedia.org/wiki/Charge_density)
/// for more information.
class ChargeDensity extends Quantity {
  /// Constructs a ChargeDensity with coulombs per cubic meter.
  /// Optionally specify a relative standard uncertainty.
  ChargeDensity({dynamic coulombsPerCubicMeter, double uncert = 0.0})
      : super(coulombsPerCubicMeter ?? 0.0, ChargeDensity.coulombsPerCubicMeter,
            uncert);

  /// Constructs an instance without preferred units.
  ChargeDensity.misc(dynamic conv)
      : super.misc(conv, ChargeDensity.electricChargeDensityDimensions);

  /// Constructs a ChargeDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ChargeDensity.inUnits(dynamic value, ChargeDensityUnits? units,
      [double uncert = 0.0])
      : super(value, units ?? ChargeDensity.coulombsPerCubicMeter, uncert);

  /// Constructs a constant ChargeDensity.
  const ChargeDensity.constant(Number valueSI,
      {ChargeDensityUnits? units, double uncert = 0.0})
      : super.constant(valueSI, ChargeDensity.electricChargeDensityDimensions,
            units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions electricChargeDensityDimensions = Dimensions.constant(
      <String, int>{'Current': 1, 'Time': 1, 'Length': -3},
      qType: ChargeDensity);

  /// The standard SI unit.
  static final ChargeDensityUnits coulombsPerCubicMeter =
      ChargeDensityUnits.chargePerVolume(Charge.coulombs, Volume.cubicMeters);
}

/// Units acceptable for use in describing ChargeDensity quantities.
class ChargeDensityUnits extends ChargeDensity with Units {
  /// Constructs an instance.
  ChargeDensityUnits(String name, String? abbrev1, String? abbrev2,
      String singular, dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super.misc(conv) {
    this.name = name;
    this.singular = singular;
    convToMKS = objToNumber(conv);
    this.abbrev1 = abbrev1;
    this.abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  /// Constructs an instance based on charge and volume units.
  ChargeDensityUnits.chargePerVolume(ChargeUnits cu, VolumeUnits vu)
      : super.misc(cu.valueSI / vu.valueSI) {
    name = '${cu.name} per ${vu.singular}';
    singular = '${cu.singular} per ${vu.singular}';
    convToMKS = cu.valueSI / vu.valueSI;
    abbrev1 = cu.abbrev1 != null && vu.abbrev1 != null
        ? '${cu.abbrev1} / ${vu.abbrev1}'
        : null;
    abbrev2 = condenseUnicodeSequences(cu.abbrev2 != null && vu.abbrev2 != null
        ? '${cu.abbrev2} ${vu.abbrev2}\u{207b}\u{00b9}'
        : null);
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => ChargeDensity;

  /// Derive ChargeDensityUnits using this ChargeDensityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
      ChargeDensityUnits(
          '$fullPrefix$name',
          abbrev1 != null ? '$abbrevPrefix$abbrev1' : null,
          abbrev2 != null ? '$abbrevPrefix$abbrev2' : null,
          '$fullPrefix$singular',
          valueSI * conv,
          false,
          offset);
}
