part of quantity_si;

/// The radiant flux emitted, reflected, transmitted or received by a surface,
/// per unit solid angle per unit projected area.
/// See the [Wikipedia entry for Radiance](https://en.wikipedia.org/wiki/Radiance)
/// for more information.
class Radiance extends Quantity {
  /// Constructs a Radiance with watts per square meter steradian.
  /// Optionally specify a relative standard uncertainty.
  Radiance({dynamic wattsPerSquareMeterSteradian, double uncert = 0.0})
      : super(wattsPerSquareMeterSteradian ?? 0.0, Radiance.wattsPerSquareMeterSteradian, uncert);

  Radiance._internal(dynamic conv) : super._internal(conv, Radiance.radianceDimensions);

  /// Constructs a Radiance based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Radiance.inUnits(dynamic value, RadianceUnits units, [double uncert = 0.0])
      : super(value, units ?? Radiance.wattsPerSquareMeterSteradian, uncert);

  /// Constructs a constant Radiance.
  const Radiance.constant(Number valueSI, {RadianceUnits units, double uncert = 0.0})
      : super.constant(valueSI, Radiance.radianceDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions radianceDimensions =
      const Dimensions.constant(const <String, int>{'Mass': 1, 'Solid Angle': -1, 'Time': -3}, qType: Radiance);

  /// The standard SI unit.
  static final RadianceUnits wattsPerSquareMeterSteradian =
      new RadianceUnits.powerAreaSolidAngle(Power.watts, Area.squareMeters, SolidAngle.steradians);
}

/// Units acceptable for use in describing Radiance quantities.
class RadianceUnits extends Radiance with Units {
  /// Constructs a new instance.
  RadianceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance from power, area and solid angle units.
  RadianceUnits.powerAreaSolidAngle(PowerUnits ecu, AreaUnits mu, SolidAngleUnits sau)
      : super._internal(ecu.valueSI / (mu.valueSI * sau.valueSI)) {
    name = '${ecu.name} per ${mu.singular} ${sau.singular}';
    singular = '${ecu.singular} per ${mu.singular} ${sau.singular}';
    _convToMKS = ecu.valueSI / (mu.valueSI * sau.valueSI);
    _abbrev1 = ecu._abbrev1 != null && mu._abbrev1 != null ? '${ecu._abbrev1} / ${mu._abbrev1} ${sau.singular}' : null;
    _abbrev2 = ecu._abbrev2 != null && mu._abbrev2 != null ? '${ecu._abbrev2}/${mu._abbrev2}${sau.singular}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => Radiance;

  /// Derive new RadianceUnits using this RadianceUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new RadianceUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
