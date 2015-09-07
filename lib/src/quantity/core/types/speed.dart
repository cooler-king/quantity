part of quantity_core;

// also velocity (?)

class Speed extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions speedDimensions =
      const Dimensions.constant(const {"Length": 1, "Time": -1});

  /// The standard SI unit.
  static final SpeedUnits metersPerSecond =
      new SpeedUnits.lengthTime(Length.meters, Time.seconds);

  /// Accepted for use with the SI, subject to further review.
  static final SpeedUnits knots =
      new SpeedUnits("knots", null, null, null, 5.144444444e-1, false);

  Speed({dynamic m_per_s, dynamic knots, double uncert: 0.0})
      : super(m_per_s != null ? m_per_s : (knots != null ? knots : 0.0),
            knots != null ? Speed.knots : Speed.metersPerSecond, uncert);

  Speed._internal(conv) : super._dimensions(conv, Speed.speedDimensions);

  /// Constructs a Speed based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Speed.inUnits(value, SpeedUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Speed.metersPerSecond, uncert);

  const Speed.constant(Number valueSI, {SpeedUnits units, num uncert: 0.0})
      : super.constant(valueSI, Speed.speedDimensions, units, uncert);
}

/// Units acceptable for use in describing Speed quantities.
///
class SpeedUnits extends Speed with Units {
  SpeedUnits(String name, String abbrev1, String abbrev2, String singular,
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

  SpeedUnits.lengthTime(LengthUnits lu, TimeUnits tu)
      : super._internal(lu.valueSI / tu.valueSI) {
    this.name = "${lu.name} per ${tu.singular}";
    this.singular = "${lu.singular} per ${tu.singular}";
    this._convToMKS = lu.valueSI / tu.valueSI;
    this._abbrev1 = lu._abbrev1 != null && tu._abbrev1 != null
        ? "${lu._abbrev1} / ${tu._abbrev1}"
        : null;
    this._abbrev2 = lu._abbrev2 != null && tu._abbrev2 != null
        ? "${lu._abbrev2}/${tu._abbrev2}"
        : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Speed;

  /// Derive new SpeedUnits using this SpeedUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new SpeedUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
