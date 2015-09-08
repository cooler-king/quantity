part of quantity_si;

class Activity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions activityDimensions = const Dimensions.constant(const {"Time": -1});

  /// The standard SI unit.
  static final ActivityUnits becquerels = new ActivityUnits("becquerels", null, "Bq", null, 1.0, true);

  /// Accepted for use with the SI, subject to further review.
  static final ActivityUnits curies = new ActivityUnits("curies", null, "Ci", null, 3.7e10, false);

  Activity({dynamic Bq, dynamic Ci, double uncert: 0.0})
      : super(Bq != null ? Bq : (Ci != null ? Ci : 0.0), Activity.becquerels, uncert);

  Activity._internal(conv) : super._dimensions(conv, Activity.activityDimensions);

  /// Constructs a Activity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Activity.inUnits(value, ActivityUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Activity.becquerels, uncert);

  const Activity.constant(Number valueSI, {ActivityUnits units, num uncert: 0.0})
      : super.constant(valueSI, Activity.activityDimensions, units, uncert);
}

/// Units acceptable for use in describing Activity quantities.
///
class ActivityUnits extends Activity with Units {
  ActivityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  ActivityUnits.lengthTimeUnits(LengthUnits lu, TimeUnits su) : super._internal(lu.valueSI * su.valueSI) {
    this.name = "${lu.name} per ${su.singular} squared";
    this.singular = "${lu.singular} per ${su.singular} squared";
    this._convToMKS = lu.valueSI * su.valueSI;
    this._abbrev1 = lu._abbrev1 != null && su._abbrev1 != null ? "${lu._abbrev1} / ${su._abbrev1}" : null;
    this._abbrev2 = lu._abbrev2 != null && su._abbrev2 != null ? "${lu._abbrev2}${su._abbrev2}" : null;
    ;
    this.metricBase = metricBase;
    this.offset = offset;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Activity;

  /// Derive new ActivityUnits using this ActivityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new ActivityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
