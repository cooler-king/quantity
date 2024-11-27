import 'package:quantity/quantity.dart';

/// The intensity of light emitted from a surface per unit area.
/// See the [Wikipedia entry for Luminance](https://en.wikipedia.org/wiki/Luminance)
/// for more information.
class Luminance extends Quantity {
  /// Constructs a Luminance with candelas per square meter.
  /// Optionally specify a relative standard uncertainty.
  Luminance({dynamic candelasPerSquareMeter, double uncert = 0.0})
      : super(candelasPerSquareMeter ?? 0.0, Luminance.candelasPerSquareMeter,
            uncert);

  /// Constructs an instance without preferred units.
  Luminance.misc(dynamic conv)
      : super.misc(conv, Luminance.luminanceDimensions);

  /// Constructs a Luminance based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Luminance.inUnits(dynamic value, LuminanceUnits? units, [double uncert = 0.0])
      : super(value, units ?? Luminance.candelasPerSquareMeter, uncert);

  /// Constructs a constant Luminance.
  const Luminance.constant(Number valueSI,
      {LuminanceUnits? units, double uncert = 0.0})
      : super.constant(valueSI, Luminance.luminanceDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions luminanceDimensions = Dimensions.constant(
      <String, int>{'Length': -2, 'Intensity': 1},
      qType: Luminance);

  /// The standard SI unit.
  static final LuminanceUnits candelasPerSquareMeter =
      LuminanceUnits.intensityPerArea(
          LuminousIntensity.candelas, Area.squareMeters);
}

/// Units acceptable for use in describing Luminance quantities.
class LuminanceUnits extends Luminance with Units {
  /// Constructs an instance.
  LuminanceUnits(String name, String? abbrev1, String? abbrev2, String singular,
      dynamic conv,
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

  /// Constructs an instance from luminous intensity and area units.
  LuminanceUnits.intensityPerArea(LuminousIntensityUnits liu, AreaUnits au)
      : super.misc(liu.valueSI / au.valueSI) {
    name = '${liu.name} per ${au.singular}';
    singular = '${liu.singular} per ${au.singular}';
    convToMKS = liu.valueSI / au.valueSI;
    abbrev1 = liu.abbrev1 != null && au.abbrev1 != null
        ? '${liu.abbrev1} / ${au.abbrev1}'
        : null;
    abbrev2 = condenseUnicodeSequences(liu.abbrev2 != null && au.abbrev2 != null
        ? '${liu.abbrev2} ${au.abbrev2}\u{207b}\u{00b9}'
        : null);
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => Luminance;

  /// Derive LuminanceUnits using this LuminanceUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
      LuminanceUnits(
          '$fullPrefix$name',
          abbrev1 != null ? '$abbrevPrefix$abbrev1' : null,
          abbrev2 != null ? '$abbrevPrefix$abbrev2' : null,
          '$fullPrefix$singular',
          valueSI * conv,
          false,
          offset);
}
