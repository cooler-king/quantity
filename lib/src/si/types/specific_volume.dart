part of quantity_si;

class SpecificVolume extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions specificVolumeDimensions = const Dimensions.constant(const {"Length": 3, "Mass": -1});

  /// The standard SI unit.
  static final SpecificVolumeUnits cubicMetersPerKilogram =
      new SpecificVolumeUnits.lengthMass(Length.meters, Mass.kilograms);

  /// Construct a SpecificVolume with cubic meters per kilogram ([m3_per_kg]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  SpecificVolume({dynamic m3_per_kg, double uncert: 0.0})
      : super(m3_per_kg ?? 0.0, SpecificVolume.cubicMetersPerKilogram, uncert);

  SpecificVolume._internal(conv) : super._dimensions(conv, SpecificVolume.specificVolumeDimensions);

  /// Constructs a SpecificVolume based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  SpecificVolume.inUnits(value, SpecificVolumeUnits units, [double uncert = 0.0])
      : super(value, units ?? SpecificVolume.cubicMetersPerKilogram, uncert);

  const SpecificVolume.constant(Number valueSI, {SpecificVolumeUnits units, num uncert: 0.0})
      : super.constant(valueSI, SpecificVolume.specificVolumeDimensions, units, uncert);
}

/// Units acceptable for use in describing SpecificVolume quantities.
///
class SpecificVolumeUnits extends SpecificVolume with Units {
  SpecificVolumeUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  SpecificVolumeUnits.lengthMass(LengthUnits lu, MassUnits mu) : super._internal(lu.valueSI / mu.valueSI) {
    this.name = "${lu.name} per ${mu.singular}";
    this.singular = "${lu.singular} per ${mu.singular}";
    this._convToMKS = lu.valueSI / mu.valueSI;
    this._abbrev1 = lu._abbrev1 != null && mu._abbrev1 != null ? "${lu._abbrev1} / ${mu._abbrev1}" : null;
    this._abbrev2 = lu._abbrev2 != null && mu._abbrev2 != null ? "${lu._abbrev2}${mu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => SpecificVolume;

  /// Derive new SpecificVolumeUnits using this SpecificVolumeUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new SpecificVolumeUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
