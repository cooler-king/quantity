part of quantity_core;

class DoseEquivalent extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions doseEquivalentDimensions =
      SpecificEnergy.specificEnergyDimensions;

  /// The standard SI unit.
  static final DoseEquivalentUnits seiverts =
      new DoseEquivalentUnits("seiverts", null, "Sv", null, 1.0, true);

  /// Accepted for use with the SI, subject to further review.
  static final DoseEquivalentUnits rems =
      new DoseEquivalentUnits("rems", null, null, null, 1.0e-2, true);

  DoseEquivalent({dynamic Sv, dynamic rems, double uncert: 0.0})
      : super(
            Sv != null ? Sv : (rems != null ? rems : 0.0),
            rems != null ? DoseEquivalent.rems : DoseEquivalent.seiverts,
            uncert);

  DoseEquivalent._internal(conv)
      : super._dimensions(conv, DoseEquivalent.doseEquivalentDimensions);

  /// Constructs a DoseEquivalent based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  DoseEquivalent.inUnits(value, DoseEquivalentUnits units,
      [double uncert = 0.0])
      : super(value, units != null ? units : DoseEquivalent.seiverts, uncert);

  const DoseEquivalent.constant(Number valueSI,
      {DoseEquivalentUnits units, num uncert: 0.0})
      : super.constant(
            valueSI, DoseEquivalent.doseEquivalentDimensions, units, uncert);
}

/// Units acceptable for use in describing DoseEquivalent quantities.
///
class DoseEquivalentUnits extends DoseEquivalent with Units {
  DoseEquivalentUnits(String name, String abbrev1, String abbrev2,
      String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => DoseEquivalent;

  /// Derive new DoseEquivalentUnits using this DoseEquivalentUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new DoseEquivalentUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
