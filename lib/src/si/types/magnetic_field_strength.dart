part of quantity_si;

/// The intensity of a magnetic field.
///
/// See the [Wikipedia entry for Magnetic field](https://en.wikipedia.org/wiki/Magnetic_field)
/// for more information.
///
class MagneticFieldStrength extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions magneticFieldStrengthDimensions =
      const Dimensions.constant(const {"Length": -1, "Current": 1}, type: MagneticFieldStrength);

  /// The standard SI unit.
  static final MagneticFieldStrengthUnits amperesPerMeter =
      new MagneticFieldStrengthUnits.currentLength(Current.amperes, Length.meters);

  /// Construct a MagneticFieldStrength with amperes per meter ([A_per_m]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  MagneticFieldStrength({dynamic A_per_m, double uncert: 0.0})
      : super(A_per_m ?? 0.0, MagneticFieldStrength.amperesPerMeter, uncert);

  MagneticFieldStrength._internal(dynamic conv)
      : super._internal(conv, MagneticFieldStrength.magneticFieldStrengthDimensions);

  /// Constructs a MagneticFieldStrength based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  MagneticFieldStrength.inUnits(dynamic value, MagneticFieldStrengthUnits units, [double uncert = 0.0])
      : super(value, units ?? MagneticFieldStrength.amperesPerMeter, uncert);

  const MagneticFieldStrength.constant(Number valueSI, {MagneticFieldStrengthUnits units, double uncert: 0.0})
      : super.constant(valueSI, MagneticFieldStrength.magneticFieldStrengthDimensions, units, uncert);
}

/// Units acceptable for use in describing MagneticFieldStrength quantities.
///
class MagneticFieldStrengthUnits extends MagneticFieldStrength with Units {
  MagneticFieldStrengthUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super._internal(conv) {
    this.name = name;
    this.singular = singular;
    this._convToMKS = objToNumber(conv);
    this._abbrev1 = abbrev1;
    this._abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  MagneticFieldStrengthUnits.currentLength(CurrentUnits ecu, LengthUnits lu)
      : super._internal(ecu.valueSI * lu.valueSI) {
    this.name = "${ecu.name} per ${lu.singular}";
    this.singular = "${ecu.singular} per ${lu.singular}";
    this._convToMKS = ecu.valueSI * lu.valueSI;
    this._abbrev1 = ecu._abbrev1 != null && lu._abbrev1 != null ? "${ecu._abbrev1} / ${lu._abbrev1}" : null;
    this._abbrev2 = ecu._abbrev2 != null && lu._abbrev2 != null ? "${ecu._abbrev2}${lu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => MagneticFieldStrength;

  /// Derive new MagneticFieldStrengthUnits using this MagneticFieldStrengthUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new MagneticFieldStrengthUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
