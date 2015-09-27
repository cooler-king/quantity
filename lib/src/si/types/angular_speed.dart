part of quantity_si;

class AngularSpeed extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions angularSpeedDimensions = const Dimensions.constant(const {"Angle": 1, "Time": -1});

  /// The standard SI unit
  static final AngularSpeedUnits radiansPerSecond = new AngularSpeedUnits.angleTime(Angle.radians, Time.seconds);

  /// Accepted for use with the SI
  static final AngularSpeedUnits degreesPerSecond = new AngularSpeedUnits.angleTime(Angle.degrees, Time.seconds);

  /// Construct an AngularSpeed with either radians per second ([rad_per_s])
  /// or degrees per second ([deg_per_s]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  AngularSpeed({dynamic rad_per_s, dynamic deg_per_s, double uncert: 0.0})
      : super(rad_per_s ?? (deg_per_s ?? 0.0),
            deg_per_s != null ? AngularSpeed.degreesPerSecond : AngularSpeed.radiansPerSecond, uncert);

  AngularSpeed._internal(conv) : super._dimensions(conv, AngularSpeed.angularSpeedDimensions);

  /// Constructs a AngularSpeed based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  AngularSpeed.inUnits(value, AngularSpeedUnits units, [double uncert = 0.0])
      : super(value, units ?? AngularSpeed.radiansPerSecond, uncert);

  const AngularSpeed.constant(Number valueSI, {AngularSpeedUnits units, num uncert: 0.0})
      : super.constant(valueSI, AngularSpeed.angularSpeedDimensions, units, uncert);
}

/// Units acceptable for use in describing AngularSpeed quantities.
///
class AngularSpeedUnits extends AngularSpeed with Units {
  AngularSpeedUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  AngularSpeedUnits.angleTime(AngleUnits au, TimeUnits tu) : super._internal(au.valueSI * tu.valueSI) {
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
  Type get quantityType => AngularSpeed;

  /// Derive new AngularSpeedUnits using this AngularSpeedUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new AngularSpeedUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
