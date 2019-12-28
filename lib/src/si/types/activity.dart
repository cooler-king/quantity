part of quantity_si;

/// A measure of the _effective concentration_ of a species in a mixture.
/// See the [Wikipedia entry for Thermodynamic activity](https://en.wikipedia.org/wiki/Thermodynamic_activity)
/// for more information.
class Activity extends Quantity {
  /// Construct an Activity with either becquerels ([Bq]) or curies ([Ci]).
  /// Optionally specify a relative standard uncertainty.
  // ignore: non_constant_identifier_names
  Activity({dynamic Bq, dynamic Ci, double uncert = 0.0}) : super(Bq ?? (Ci ?? 0.0), Activity.becquerels, uncert);

  Activity._internal(dynamic conv) : super._internal(conv, Activity.activityDimensions);

  /// Constructs a Activity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Activity.inUnits(dynamic value, ActivityUnits units, [double uncert = 0.0])
      : super(value, units ?? Activity.becquerels, uncert);

  /// Constructs a constant Activity.
  const Activity.constant(Number valueSI, {ActivityUnits units, double uncert = 0.0})
      : super.constant(valueSI, Activity.activityDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions activityDimensions =
      const Dimensions.constant(const <String, int>{'Time': -1}, qType: Activity);

  /// The standard SI unit.
  static final ActivityUnits becquerels = new ActivityUnits('becquerels', null, 'Bq', null, 1.0, true);

  /// Accepted for use with the SI, subject to further review.
  static final ActivityUnits curies = new ActivityUnits('curies', null, 'Ci', null, 3.7e10, false);
}

/// Units acceptable for use in describing Activity quantities.
class ActivityUnits extends Activity with Units {
  /// Constructs a new instance.
  ActivityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance from length and time units.
  ActivityUnits.lengthTimeUnits(LengthUnits lu, TimeUnits su) : super._internal(lu.valueSI * su.valueSI) {
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
  Type get quantityType => Activity;

  /// Derive new ActivityUnits using this ActivityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new ActivityUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
