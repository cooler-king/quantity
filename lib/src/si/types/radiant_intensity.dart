part of quantity_si;

/// The radiant flux emitted, reflected, transmitted or received, per unit solid angle.
///
/// See the [Wikipedia entry for Radiant intensity](https://en.wikipedia.org/wiki/Radiant_intensity)
/// for more information.
///
class RadiantIntensity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions radiantIntensityDimensions =
      const Dimensions.constant(const <String, int>{'Length': 2, 'Mass': 1, 'Time': -3, 'Solid Angle': -1}, qType: RadiantIntensity);

  /// The standard SI unit.
  static final RadiantIntensityUnits wattsPerSteradian =
      new RadiantIntensityUnits.powerSolidAngle(Power.watts, SolidAngle.steradians);

  /// Construct a RadiantIntensity with watts per steradian.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  RadiantIntensity({dynamic wattsPerSteradian, double uncert: 0.0})
      : super(wattsPerSteradian ?? 0.0, RadiantIntensity.wattsPerSteradian, uncert);

  RadiantIntensity._internal(dynamic conv) : super._internal(conv, RadiantIntensity.radiantIntensityDimensions);

  /// Constructs a RadiantIntensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  RadiantIntensity.inUnits(dynamic value, RadiantIntensityUnits units, [double uncert = 0.0])
      : super(value, units ?? RadiantIntensity.wattsPerSteradian, uncert);

  const RadiantIntensity.constant(Number valueSI, {RadiantIntensityUnits units, double uncert: 0.0})
      : super.constant(valueSI, RadiantIntensity.radiantIntensityDimensions, units, uncert);
}

/// Units acceptable for use in describing RadiantIntensity quantities.
///
class RadiantIntensityUnits extends RadiantIntensity with Units {
  /// Constructs a new instance.
  RadiantIntensityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on power nad solid angle units.
  RadiantIntensityUnits.powerSolidAngle(PowerUnits pu, SolidAngleUnits sau)
      : super._internal(pu.valueSI / sau.valueSI) {
    name = '${pu.name} per ${sau.singular}';
    singular = '${pu.singular} per ${sau.singular}';
    _convToMKS = pu.valueSI / sau.valueSI;
    _abbrev1 = pu._abbrev1 != null && sau._abbrev1 != null ? '${pu._abbrev1} / ${sau._abbrev1}' : null;
    _abbrev2 = pu._abbrev2 != null && sau._abbrev2 != null ? '${pu._abbrev2}/${sau._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => RadiantIntensity;

  /// Derive new RadiantIntensityUnits using this RadiantIntensityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new RadiantIntensityUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
  
}
