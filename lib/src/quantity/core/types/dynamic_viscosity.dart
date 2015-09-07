part of quantity_core;

class DynamicViscosity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions dynamicViscosityDimensions =
      const Dimensions.constant(const {"Mass": 1, "Length": -1, "Time": -1});

  /// The standard SI unit.
  static final DynamicViscosityUnits pascalSeconds =
      new DynamicViscosityUnits.pressureTime(Pressure.pascals, Time.seconds);

  /// Another name for [pascalSeconds]
  static final DynamicViscosityUnits poiseuille = pascalSeconds;

  DynamicViscosity({dynamic rad_per_s2, dynamic deg_per_s2, double uncert: 0.0})
      : super(
            rad_per_s2 != null
                ? rad_per_s2
                : (deg_per_s2 != null ? deg_per_s2 : 0.0),
            DynamicViscosity.pascalSeconds,
            uncert);

  DynamicViscosity._internal(conv)
      : super._dimensions(conv, DynamicViscosity.dynamicViscosityDimensions);

  /// Constructs a DynamicViscosity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  DynamicViscosity.inUnits(value, DynamicViscosityUnits units,
      [double uncert = 0.0])
      : super(value, units != null ? units : DynamicViscosity.pascalSeconds,
            uncert);

  const DynamicViscosity.constant(Number valueSI,
      {DynamicViscosityUnits units, num uncert: 0.0})
      : super.constant(valueSI, DynamicViscosity.dynamicViscosityDimensions,
            units, uncert);
}

/// Units acceptable for use in describing DynamicViscosity quantities.
///
class DynamicViscosityUnits extends DynamicViscosity with Units {
  DynamicViscosityUnits(String name, String abbrev1, String abbrev2,
      String singular, dynamic conv,
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

  DynamicViscosityUnits.pressureTime(PressureUnits pu, TimeUnits tu)
      : super._internal(pu.valueSI * tu.valueSI) {
    this.name = "${pu.singular} ${tu.name}";
    this.singular = "${pu.singular} ${tu.singular}";
    this._convToMKS = pu.valueSI * tu.valueSI;
    this._abbrev1 = pu._abbrev1 != null && tu._abbrev1 != null
        ? "${pu._abbrev1} ${tu._abbrev1}"
        : null;
    this._abbrev2 = pu._abbrev2 != null && tu._abbrev2 != null
        ? "${pu._abbrev2}${tu._abbrev2}"
        : null;
    ;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => DynamicViscosity;

  /// Derive new DynamicViscosityUnits using this DynamicViscosityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new DynamicViscosityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
