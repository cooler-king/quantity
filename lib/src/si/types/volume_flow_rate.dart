part of quantity_si;

/// The volume of fluid which passes per unit time.
///
/// See the [Wikipedia entry for Volumetric flow rate](https://en.wikipedia.org/wiki/Volumetric_flow_rate)
/// for more information.
///
class VolumeFlowRate extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions volumeFlowRateDimensions = const Dimensions.constant(const {"Length": 3, "Time": -1});

  /// The standard SI unit.
  static final VolumeFlowRateUnits cubicMetersPerSecond =
      new VolumeFlowRateUnits.volumeTime(Volume.cubicMeters, Time.seconds);

  /// Construct a VolumeFlowRate with cubic meters per second ([m3_per_s]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  VolumeFlowRate({dynamic m3_per_s, double uncert: 0.0})
      : super(m3_per_s ?? 0.0, VolumeFlowRate.cubicMetersPerSecond, uncert);

  VolumeFlowRate._internal(conv) : super._dimensions(conv, VolumeFlowRate.volumeFlowRateDimensions);

  /// Constructs a VolumeFlowRate based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  VolumeFlowRate.inUnits(value, VolumeFlowRateUnits units, [double uncert = 0.0])
      : super(value, units ?? VolumeFlowRate.cubicMetersPerSecond, uncert);

  const VolumeFlowRate.constant(Number valueSI, {VolumeFlowRateUnits units, num uncert: 0.0})
      : super.constant(valueSI, VolumeFlowRate.volumeFlowRateDimensions, units, uncert);
}

/// Units acceptable for use in describing VolumeFlowRate quantities.
///
class VolumeFlowRateUnits extends VolumeFlowRate with Units {
  VolumeFlowRateUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  VolumeFlowRateUnits.volumeTime(VolumeUnits vu, TimeUnits tu) : super._internal(vu.valueSI / tu.valueSI) {
    this.name = "${vu.name} per ${tu.singular}";
    this.singular = "${vu.singular} per ${tu.singular}";
    this._convToMKS = vu.valueSI / tu.valueSI;
    this._abbrev1 = vu._abbrev1 != null && tu._abbrev1 != null ? "${vu._abbrev1} / ${tu._abbrev1}" : null;
    this._abbrev2 = vu._abbrev2 != null && tu._abbrev2 != null ? "${vu._abbrev2}/${tu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => VolumeFlowRate;

  /// Derive new VolumeFlowRateUnits using this VolumeFlowRateUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new VolumeFlowRateUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
