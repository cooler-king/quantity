part of quantity_core;

class Exposure extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions exposureDimensions =
      const Dimensions.constant(const {"Current": 1, "Mass": -1, "Time": 1});

  /// The standard SI unit.
  static final ExposureUnits coulombsPerKilogram =
      new ExposureUnits.chargeMass(Charge.coulombs, Mass.kilograms);

  /// Accepted for use with the SI, subject to further review.
  static final ExposureUnits roentgens =
      new ExposureUnits("roentgens", null, "R", null, 2.58e-4, false);

  Exposure({dynamic C_per_kg, dynamic R, double uncert: 0.0})
      : super(
            C_per_kg != null ? C_per_kg : (R != null ? R : 0.0),
            R != null ? Exposure.roentgens : Exposure.coulombsPerKilogram,
            uncert);

  Exposure._internal(conv)
      : super._dimensions(conv, Exposure.exposureDimensions);

  /// Constructs a Exposure based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Exposure.inUnits(value, ExposureUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Exposure.coulombsPerKilogram,
            uncert);

  const Exposure.constant(Number valueSI,
      {ExposureUnits units, num uncert: 0.0})
      : super.constant(valueSI, Exposure.exposureDimensions, units, uncert);
}

/// Units acceptable for use in describing Exposure quantities.
///
class ExposureUnits extends Exposure with Units {
  ExposureUnits(String name, String abbrev1, String abbrev2, String singular,
      dynamic conv,
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

  ExposureUnits.chargeMass(ChargeUnits ecu, MassUnits mu)
      : super._internal(ecu.valueSI * mu.valueSI) {
    this.name = "${ecu.name} per ${mu.singular}";
    this.singular = "${ecu.singular} per ${mu.singular}";
    this._convToMKS = ecu.valueSI * mu.valueSI;
    this._abbrev1 = ecu._abbrev1 != null && mu._abbrev1 != null
        ? "${ecu._abbrev1} / ${mu._abbrev1}"
        : null;
    this._abbrev2 = ecu._abbrev2 != null && mu._abbrev2 != null
        ? "${ecu._abbrev2}${mu._abbrev2}"
        : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Exposure;

  /// Derive new ExposureUnits using this ExposureUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new ExposureUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
