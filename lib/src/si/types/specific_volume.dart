part of quantity_si;

/// The ratio of the substance's volume to its mass.
///
/// See the [Wikipedia entry for Specific volume](https://en.wikipedia.org/wiki/Specific_volume)
/// for more information.
///
class SpecificVolume extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions specificVolumeDimensions =
      const Dimensions.constant(const <String, int>{'Length': 3, 'Mass': -1}, qType: SpecificVolume);

  /// The standard SI unit.
  static final SpecificVolumeUnits cubicMetersPerKilogram =
      new SpecificVolumeUnits.lengthMass(Length.meters, Mass.kilograms);

  /// Construct a SpecificVolume with cubic meters per kilogram.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  SpecificVolume({dynamic cubicMetersPerKilogram, double uncert = 0.0})
      : super(cubicMetersPerKilogram ?? 0.0, SpecificVolume.cubicMetersPerKilogram, uncert);

  SpecificVolume._internal(dynamic conv) : super._internal(conv, SpecificVolume.specificVolumeDimensions);

  /// Constructs a SpecificVolume based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  SpecificVolume.inUnits(dynamic value, SpecificVolumeUnits units, [double uncert = 0.0])
      : super(value, units ?? SpecificVolume.cubicMetersPerKilogram, uncert);

  const SpecificVolume.constant(Number valueSI, {SpecificVolumeUnits units, double uncert = 0.0})
      : super.constant(valueSI, SpecificVolume.specificVolumeDimensions, units, uncert);
}

/// Units acceptable for use in describing SpecificVolume quantities.
///
class SpecificVolumeUnits extends SpecificVolume with Units {
  /// Constructs a new instance.
  SpecificVolumeUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance base don length and mass units.
  SpecificVolumeUnits.lengthMass(LengthUnits lu, MassUnits mu) : super._internal(lu.valueSI / mu.valueSI) {
    name = '${lu.name} per ${mu.singular}';
    singular = '${lu.singular} per ${mu.singular}';
    _convToMKS = lu.valueSI / mu.valueSI;
    _abbrev1 = lu._abbrev1 != null && mu._abbrev1 != null ? '${lu._abbrev1} / ${mu._abbrev1}' : null;
    _abbrev2 = lu._abbrev2 != null && mu._abbrev2 != null ? '${lu._abbrev2}${mu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => SpecificVolume;

  /// Derive new SpecificVolumeUnits using this SpecificVolumeUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new SpecificVolumeUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);

}
