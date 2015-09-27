part of quantity_si;

class AngularAcceleration extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions angularAccelerationDimensions = const Dimensions.constant(const {"Angle": 1, "Time": -2});

  /// The Standard SI unit.
  static final AngularAccelerationUnits radianPerSecondSquared =
      new AngularAccelerationUnits.angleTime(Angle.radians, Time.seconds);

  /// Accepted for use with the SI.
  static final AngularAccelerationUnits degreePerSecondSquared =
      new AngularAccelerationUnits.angleTime(Angle.degrees, Time.seconds);

  /// Construct an AngularAcceleration with either radians per second squared ([rad_per_s2])
  /// or degrees per second squared ([deg_per_s2]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  AngularAcceleration({dynamic rad_per_s2, dynamic deg_per_s2, double uncert: 0.0})
      : super(rad_per_s2 ?? (deg_per_s2 ?? 0.0), AngularAcceleration.radianPerSecondSquared, uncert);

  AngularAcceleration._internal(conv) : super._dimensions(conv, AngularAcceleration.angularAccelerationDimensions);

  /// Constructs a AngularAcceleration based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  AngularAcceleration.inUnits(value, AngularAccelerationUnits units, [double uncert = 0.0])
      : super(value, units ?? AngularAcceleration.radianPerSecondSquared, uncert);

  const AngularAcceleration.constant(Number valueSI, {AngularAccelerationUnits units, num uncert: 0.0})
      : super.constant(valueSI, AngularAcceleration.angularAccelerationDimensions, units, uncert);
}

/// Units acceptable for use in describing AngularAcceleration quantities.
///
class AngularAccelerationUnits extends AngularAcceleration with Units {
  AngularAccelerationUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  AngularAccelerationUnits.angleTime(AngleUnits au, TimeUnits tu) : super._internal(au.valueSI * tu.valueSI) {
    this.name = "${au.name} per ${tu.singular} squared";
    this.singular = "${au.singular} per ${tu.singular} squared";
    this._convToMKS = au.valueSI * tu.valueSI;
    this._abbrev1 = au._abbrev1 != null && tu._abbrev1 != null ? "${au._abbrev1} / ${tu._abbrev1}" : null;
    this._abbrev2 = au._abbrev2 != null && tu._abbrev2 != null ? "${au._abbrev2}${tu._abbrev2}" : null;
    ;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => AngularAcceleration;

  /// Derive new AngularAccelerationUnits using this AngularAccelerationUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new AngularAccelerationUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
