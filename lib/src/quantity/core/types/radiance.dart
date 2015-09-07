part of quantity_core;

class Radiance extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions radianceDimensions = const Dimensions.constant(
      const {"Mass": 1, "Solid Angle": -1, "Time": -3});

  /// The standard SI unit.
  static final RadianceUnits wattsPerSquareMeterSteradian =
      new RadianceUnits.powerAreaSolidAngle(
          Power.watts, Area.squareMeters, SolidAngle.steradians);

  Radiance({dynamic W_per_m2sr, double uncert: 0.0})
      : super(W_per_m2sr != null ? W_per_m2sr : 0.0,
            Radiance.wattsPerSquareMeterSteradian, uncert);

  Radiance._internal(conv)
      : super._dimensions(conv, Radiance.radianceDimensions);

  /// Constructs a Radiance based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Radiance.inUnits(value, RadianceUnits units, [double uncert = 0.0])
      : super(
            value,
            units != null ? units : Radiance.wattsPerSquareMeterSteradian,
            uncert);

  const Radiance.constant(Number valueSI,
      {RadianceUnits units, num uncert: 0.0})
      : super.constant(valueSI, Radiance.radianceDimensions, units, uncert);
}

/// Units acceptable for use in describing Radiance quantities.
///
class RadianceUnits extends Radiance with Units {
  RadianceUnits(String name, String abbrev1, String abbrev2, String singular,
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

  RadianceUnits.powerAreaSolidAngle(
      PowerUnits ecu, AreaUnits mu, SolidAngleUnits sau)
      : super._internal(ecu.valueSI / (mu.valueSI * sau.valueSI)) {
    this.name = "${ecu.name} per ${mu.singular} ${sau.singular}";
    this.singular = "${ecu.singular} per ${mu.singular} ${sau.singular}";
    this._convToMKS = ecu.valueSI / (mu.valueSI * sau.valueSI);
    this._abbrev1 = ecu._abbrev1 != null && mu._abbrev1 != null
        ? "${ecu._abbrev1} / ${mu._abbrev1} ${sau.singular}"
        : null;
    this._abbrev2 = ecu._abbrev2 != null && mu._abbrev2 != null
        ? "${ecu._abbrev2}/${mu._abbrev2}${sau.singular}"
        : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Radiance;

  /// Derive new RadianceUnits using this RadianceUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new RadianceUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
