part of quantity_si;

/// The mean energy imparted to matter per unit mass by ionizing radiation.
/// See the [Wikipedia entry for Absorbed Dose](https://en.wikipedia.org/wiki/Absorbed_dose)
/// for more information.
class AbsorbedDose extends Quantity {
  /// Construct an AbsorbedDose with either grays ([Gy]) or rads ([rads]).
  /// Optionally specify a relative standard uncertainty.
  // ignore: non_constant_identifier_names
  AbsorbedDose({dynamic Gy, dynamic rads, double uncert = 0.0})
      : super(Gy ?? (rads ?? 0.0), rads != null ? AbsorbedDose.rads : AbsorbedDose.grays, uncert);

  AbsorbedDose._internal(dynamic conv) : super._internal(conv, AbsorbedDose.absorbedDoseDimensions);

  /// Constructs an AbsorbedDose based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  AbsorbedDose.inUnits(dynamic value, AbsorbedDoseUnits units, [double uncert = 0.0])
      : super(value, units ?? AbsorbedDose.grays, uncert);

  /// Constructs a constant AbsorbedDose.
  const AbsorbedDose.constant(Number valueSI, {AbsorbedDoseUnits units, double uncert = 0.0})
      : super.constant(valueSI, AbsorbedDose.absorbedDoseDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions absorbedDoseDimensions =
      const Dimensions.constant(const <String, int>{'Length': 2, 'Time': -2}, qType: AbsorbedDose);

  /// The standard SI unit.
  static final AbsorbedDoseUnits grays = new AbsorbedDoseUnits('grays', null, 'Gy', null, 1.0, true);

  /// Accepted for use with the SI, subject to further review.
  // Note:  do not use 'rad' for singular to avoid confusion with
  // Angle's radians during parsing & output
  static final AbsorbedDoseUnits rads = new AbsorbedDoseUnits('rads', null, null, 'rads', 1.0e-2, true);
}

/// Units acceptable for use in describing AbsorbedDose quantities.
class AbsorbedDoseUnits extends AbsorbedDose with Units {
  /// Constructs a new instance.
  AbsorbedDoseUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on length and time units.
  AbsorbedDoseUnits.lengthTimeUnits(LengthUnits lu, TimeUnits su) : super._internal(lu.valueSI * su.valueSI) {
    name = '${lu.name} per ${su.singular} squared';
    singular = '${lu.singular} per ${su.singular} squared';
    _convToMKS = lu.valueSI * su.valueSI;
    _abbrev1 = lu._abbrev1 != null && su._abbrev1 != null ? '${lu._abbrev1} / ${su._abbrev1}' : null;
    _abbrev2 = lu._abbrev2 != null && su._abbrev2 != null ? '${lu._abbrev2}${su._abbrev2}' : null;
    metricBase = metricBase;
    offset = offset.toDouble();
  }

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => AbsorbedDose;

  /// Derive new AbsorbedDoseUnits using this AbsorbedDoseUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new AbsorbedDoseUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
