part of quantity_si;

/// The intensity of light emitted from a surface per unit area.
///
/// See the [Wikipedia entry for Luminance](https://en.wikipedia.org/wiki/Luminance)
/// for more information.
///
class Luminance extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions luminanceDimensions =
      const Dimensions.constant(const <String, int>{'Length': -2, 'Intensity': 1}, qType: Luminance);

  /// The standard SI unit.
  static final LuminanceUnits candelasPerSquareMeter =
      new LuminanceUnits.intensityArea(LuminousIntensity.candelas, Area.squareMeters);

  /// Construct a Luminance with candelas per square meter.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Luminance({dynamic candelasPerSquareMeter, double uncert = 0.0})
      : super(candelasPerSquareMeter ?? 0.0, Luminance.candelasPerSquareMeter, uncert);

  Luminance._internal(dynamic conv) : super._internal(conv, Luminance.luminanceDimensions);

  /// Constructs a Luminance based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Luminance.inUnits(dynamic value, LuminanceUnits units, [double uncert = 0.0])
      : super(value, units ?? Luminance.candelasPerSquareMeter, uncert);

  const Luminance.constant(Number valueSI, {LuminanceUnits units, double uncert = 0.0})
      : super.constant(valueSI, Luminance.luminanceDimensions, units, uncert);
}

/// Units acceptable for use in describing Luminance quantities.
///
class LuminanceUnits extends Luminance with Units {
  LuminanceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  LuminanceUnits.intensityArea(LuminousIntensityUnits liu, AreaUnits au) : super._internal(liu.valueSI * au.valueSI) {
    name = '${liu.name} per ${au.singular}';
    singular = '${liu.singular} per ${au.singular}';
    _convToMKS = liu.valueSI * au.valueSI;
    _abbrev1 = liu._abbrev1 != null && au._abbrev1 != null ? '${liu._abbrev1} / ${au._abbrev1}' : null;
    _abbrev2 = liu._abbrev2 != null && au._abbrev2 != null ? '${liu._abbrev2}${au._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Luminance;

  /// Derive new LuminanceUnits using this LuminanceUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new LuminanceUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
  
}
