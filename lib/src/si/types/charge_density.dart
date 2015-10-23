part of quantity_si;

/// Electric charge per unit volume of space.
///
/// See the [Wikipedia entry for Charge density](https://en.wikipedia.org/wiki/Charge_density)
/// for more information.
///
class ChargeDensity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions electricChargeDensityDimensions =
      const Dimensions.constant(const {"Current": 1, "Time": 1, "Length": -3}, type: ChargeDensity);

  /// The standard SI unit.
  static final ChargeDensityUnits coulombsPerCubicMeter =
      new ChargeDensityUnits.chargeVolume(Charge.coulombs, Volume.cubicMeters);

  /// Construct a ChargeDensity with coulombs per cubic meter ([C_per_m3]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  ChargeDensity({dynamic C_per_m3, double uncert: 0.0})
      : super(C_per_m3 ?? 0.0, ChargeDensity.coulombsPerCubicMeter, uncert);

  ChargeDensity._internal(conv) : super._internal(conv, ChargeDensity.electricChargeDensityDimensions);

  /// Constructs a ChargeDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  ChargeDensity.inUnits(value, ChargeDensityUnits units, [double uncert = 0.0])
      : super(value, units ?? ChargeDensity.coulombsPerCubicMeter, uncert);

  const ChargeDensity.constant(Number valueSI, {ChargeDensityUnits units, num uncert: 0.0})
      : super.constant(valueSI, ChargeDensity.electricChargeDensityDimensions, units, uncert);
}

/// Units acceptable for use in describing ChargeDensity quantities.
///
class ChargeDensityUnits extends ChargeDensity with Units {
  ChargeDensityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  ChargeDensityUnits.chargeVolume(ChargeUnits ecu, VolumeUnits vu) : super._internal(ecu.valueSI * vu.valueSI) {
    this.name = "${ecu.name} per ${vu.singular}";
    this.singular = "${ecu.singular} per ${vu.singular}";
    this._convToMKS = ecu.valueSI * vu.valueSI;
    this._abbrev1 = ecu._abbrev1 != null && vu._abbrev1 != null ? "${ecu._abbrev1}/${vu._abbrev1}" : null;
    this._abbrev2 = ecu._abbrev2 != null && vu._abbrev2 != null ? "${ecu._abbrev2}/${vu._abbrev2}" : null;
    ;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => ChargeDensity;

  /// Derive new ChargeDensityUnits using this ChargeDensityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new ChargeDensityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
