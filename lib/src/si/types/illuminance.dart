part of quantity_si;

/// The total luminous flux incident on a surface, per unit area.
///
/// See the [Wikipedia entry for Illuminance](https://en.wikipedia.org/wiki/Illuminance)
/// for more information.
///
class Illuminance extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions illuminanceDimensions =
      const Dimensions.constant(const {"Length": -2, "Intensity": 1, "Solid Angle": 1}, type: Illuminance);

  /// The standard SI unit.
  // Note: singular same as plural
  static final IlluminanceUnits lux = new IlluminanceUnits("lux", null, "lx", "lux", 1.0, true);

  /// Construct an Illuminance with [lux].
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Illuminance({dynamic lux, double uncert: 0.0}) : super(lux ?? 0.0, Illuminance.lux, uncert);

  Illuminance._internal(conv) : super._internal(conv, Illuminance.illuminanceDimensions);

  /// Constructs a Illuminance based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Illuminance.inUnits(value, IlluminanceUnits units, [double uncert = 0.0])
      : super(value, units ?? Illuminance.lux, uncert);

  const Illuminance.constant(Number valueSI, {IlluminanceUnits  units, double uncert: 0.0})
      : super.constant(valueSI, Illuminance.illuminanceDimensions, units, uncert);
}

/// Units acceptable for use in describing Illuminance quantities.
///
class IlluminanceUnits extends Illuminance with Units {
  IlluminanceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Illuminance;

  /// Derive new IlluminanceUnits using this IlluminanceUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new IlluminanceUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
