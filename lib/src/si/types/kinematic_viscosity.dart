part of quantity_si;

class KinematicViscosity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions kinematicViscosityDimensions = const Dimensions.constant(const {"Length": 2, "Time": -1});

  /// The standard SI unit.
  static final KinematicViscosityUnits metersSquaredPerSecond =
      new KinematicViscosityUnits.areaTime(Area.squareMeters, Time.seconds);

  /// Construct a KinematicViscosity with meters squared per second ([m2_per_s]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  KinematicViscosity({dynamic m2_per_s, double uncert: 0.0}) : super(m2_per_s ?? 0.0, Illuminance.lux, uncert);

  KinematicViscosity._internal(conv) : super._dimensions(conv, KinematicViscosity.kinematicViscosityDimensions);

  /// Constructs a KinematicViscosity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  KinematicViscosity.inUnits(value, KinematicViscosityUnits units, [double uncert = 0.0])
      : super(value, units ?? KinematicViscosity.metersSquaredPerSecond, uncert);

  const KinematicViscosity.constant(Number valueSI, {KinematicViscosityUnits units, num uncert: 0.0})
      : super.constant(valueSI, KinematicViscosity.kinematicViscosityDimensions, units, uncert);
}

/// Units acceptable for use in describing KinematicViscosity quantities.
///
class KinematicViscosityUnits extends KinematicViscosity with Units {
  KinematicViscosityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  KinematicViscosityUnits.areaTime(AreaUnits au, TimeUnits tu) : super._internal(au.valueSI * tu.valueSI) {
    this.name = "${au.name} per ${tu.singular}";
    this.singular = "${au.singular} per ${tu.singular}";
    this._convToMKS = au.valueSI * tu.valueSI;
    this._abbrev1 = au._abbrev1 != null && tu._abbrev1 != null ? "${au._abbrev1} / ${tu._abbrev1}" : null;
    this._abbrev2 = au._abbrev2 != null && tu._abbrev2 != null ? "${au._abbrev2}${tu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => KinematicViscosity;

  /// Derive new KinematicViscosityUnits using this KinematicViscosityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new KinematicViscosityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
