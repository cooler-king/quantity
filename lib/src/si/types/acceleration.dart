part of quantity_si;

/// The rate of change of speed of an object.
///
/// See the [Wikipedia entry for Acceleration](https://en.wikipedia.org/wiki/Acceleration)
/// for more information.
///
class Acceleration extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions accelerationDimensions =
      const Dimensions.constant(const {"Length": 1, "Time": -2}, type: Acceleration);

  /// The standard SI unit.
  static final AccelerationUnits metersPerSecondSquared =
      new AccelerationUnits.lengthTimeUnits(Length.meters, Time.seconds);

  /// Construct an Acceleration with meters per second squared ([m_per_s2]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Acceleration({dynamic m_per_s2, double uncert: 0.0})
      : super(m_per_s2 ?? 0.0, Acceleration.metersPerSecondSquared, uncert);

  Acceleration._internal(dynamic conv) : super._internal(conv, Acceleration.accelerationDimensions);

  /// Constructs a Acceleration based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Acceleration.inUnits(dynamic value, AccelerationUnits units, [double uncert = 0.0])
      : super(value, units ?? Acceleration.metersPerSecondSquared, uncert);

  const Acceleration.constant(Number valueSI, {AccelerationUnits units, double uncert: 0.0})
      : super.constant(valueSI, Acceleration.accelerationDimensions, units, uncert);
}

/// Units acceptable for use in describing Acceleration quantities.
///
class AccelerationUnits extends Acceleration with Units {
  AccelerationUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  AccelerationUnits.lengthTimeUnits(LengthUnits lu, TimeUnits su) : super._internal(lu.valueSI * su.valueSI) {
    this.name = "${lu.name} per ${su.singular} squared";
    this.singular = "${lu.singular} per ${su.singular} squared";
    this._convToMKS = lu.valueSI * su.valueSI;
    this._abbrev1 = lu._abbrev1 != null && su._abbrev1 != null ? "${lu._abbrev1} / ${su._abbrev1}" : null;
    this._abbrev2 = lu._abbrev2 != null && su._abbrev2 != null ? "${lu._abbrev2}${su._abbrev2}" : null;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Acceleration;

  /// Derive new AccelerationUnits using this AccelerationUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new AccelerationUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
