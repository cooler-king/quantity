part of quantity_si;

/// The volume of fluid which passes per unit time.
///
/// See the [Wikipedia entry for Volumetric flow rate](https://en.wikipedia.org/wiki/Volumetric_flow_rate)
/// for more information.
///
class VolumeFlowRate extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions volumeFlowRateDimensions =
      const Dimensions.constant(const <String, int>{'Length': 3, 'Time': -1}, qType: VolumeFlowRate);

  /// The standard SI unit.
  static final VolumeFlowRateUnits cubicMetersPerSecond =
      new VolumeFlowRateUnits.volumeTime(Volume.cubicMeters, Time.seconds);

  /// Construct a VolumeFlowRate with cubic meters per second.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  VolumeFlowRate({dynamic cubicMetersPerSecond, double uncert = 0.0})
      : super(cubicMetersPerSecond ?? 0.0, VolumeFlowRate.cubicMetersPerSecond, uncert);

  VolumeFlowRate._internal(dynamic conv) : super._internal(conv, VolumeFlowRate.volumeFlowRateDimensions);

  /// Constructs a VolumeFlowRate based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  VolumeFlowRate.inUnits(dynamic value, VolumeFlowRateUnits units, [double uncert = 0.0])
      : super(value, units ?? VolumeFlowRate.cubicMetersPerSecond, uncert);

  const VolumeFlowRate.constant(Number valueSI, {VolumeFlowRateUnits units, double uncert = 0.0})
      : super.constant(valueSI, VolumeFlowRate.volumeFlowRateDimensions, units, uncert);
}

/// Units acceptable for use in describing VolumeFlowRate quantities.
///
class VolumeFlowRateUnits extends VolumeFlowRate with Units {
  /// Constructs a new instance.
  VolumeFlowRateUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on volume and time units.
  VolumeFlowRateUnits.volumeTime(VolumeUnits vu, TimeUnits tu) : super._internal(vu.valueSI / tu.valueSI) {
    name = '${vu.name} per ${tu.singular}';
    singular = '${vu.singular} per ${tu.singular}';
    _convToMKS = vu.valueSI / tu.valueSI;
    _abbrev1 = vu._abbrev1 != null && tu._abbrev1 != null ? '${vu._abbrev1} / ${tu._abbrev1}' : null;
    _abbrev2 = vu._abbrev2 != null && tu._abbrev2 != null ? '${vu._abbrev2}/${tu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => VolumeFlowRate;

  /// Derive new VolumeFlowRateUnits using this VolumeFlowRateUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new VolumeFlowRateUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);

}
