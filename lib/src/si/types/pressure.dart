part of quantity_si;

// Also Stress

/// Force applied perpendicular to the surface of an object per unit area
/// over which that force is distributed.
///
/// See the [Wikipedia entry for Pressure](https://en.wikipedia.org/wiki/Pressure)
/// for more information.
///
class Pressure extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions pressureDimensions = const Dimensions.constant(const {"Length": -1, "Mass": 1, "Time": -2});

  /// The standard SI unit.
  static final PressureUnits pascals = new PressureUnits("pascals", null, "Pa", null, 1.0, true);

  /// Accepted for use with the SI, subject to further review.
  static final PressureUnits bars = new PressureUnits("bars", null, null, null, 1.0e5, true);

  /// Construct a pressure with pascals ([Pa]) or [bars].
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Pressure({dynamic Pa, dynamic bars, double uncert: 0.0})
      : super(Pa ?? (bars ?? 0.0), bars != null ? Pressure.bars : Pressure.pascals, uncert);

  Pressure._internal(conv) : super._dimensions(conv, Pressure.pressureDimensions);

  /// Constructs a Pressure based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Pressure.inUnits(value, PressureUnits units, [double uncert = 0.0]) : super(value, units ?? Pressure.pascals, uncert);

  const Pressure.constant(Number valueSI, {PressureUnits units, num uncert: 0.0})
      : super.constant(valueSI, Pressure.pressureDimensions, units, uncert);
}

/// Units acceptable for use in describing Pressure quantities.
///
class PressureUnits extends Pressure with Units {
  PressureUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  PressureUnits.forceArea(ForceUnits fu, AreaUnits au) : super._internal(fu.valueSI * au.valueSI) {
    this.name = "${fu.name} per ${au.singular}";
    this.singular = "${fu.singular} per ${au.singular}";
    this._convToMKS = fu.valueSI * au.valueSI;
    this._abbrev1 = fu._abbrev1 != null && au._abbrev1 != null ? "${fu._abbrev1} / ${au._abbrev1}" : null;
    this._abbrev2 = fu._abbrev2 != null && au._abbrev2 != null ? "${fu._abbrev2}${au._abbrev2}" : null;
    this.metricBase = metricBase;
    this.offset = offset;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Pressure;

  /// Derive new PressureUnits using this PressureUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new PressureUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
