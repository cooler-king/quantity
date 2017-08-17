part of quantity_si;

/// The ability of a material to conduct heat.
///
/// See the [Wikipedia entry for Thermal conductivity](https://en.wikipedia.org/wiki/Thermal_conductivity)
/// for more information.
///
class ThermalConductivity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions thermalConductivityDimensions = const Dimensions.constant(
      const {"Length": 1, "Mass": 1, "Time": -3, "Temperature": -1},
      type: ThermalConductivity);

  /// The standard SI unit.
  static final ThermalConductivityUnits wattsPerMeterKelvin =
      new ThermalConductivityUnits.powerLengthTemperature(Power.watts, Length.meters, TemperatureInterval.kelvins);

  /// Construct a ThermalConductivity with watts per meter kelvin ([W_per_mK]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  ThermalConductivity({dynamic W_per_mK, double uncert: 0.0})
      : super(W_per_mK ?? 0.0, ThermalConductivity.wattsPerMeterKelvin, uncert);

  ThermalConductivity._internal(conv) : super._internal(conv, ThermalConductivity.thermalConductivityDimensions);

  /// Constructs a ThermalConductivity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  ThermalConductivity.inUnits(value, ThermalConductivityUnits units, [double uncert = 0.0])
      : super(value, units ?? ThermalConductivity.wattsPerMeterKelvin, uncert);

  const ThermalConductivity.constant(Number valueSI, {ThermalConductivityUnits units, double uncert: 0.0})
      : super.constant(valueSI, ThermalConductivity.thermalConductivityDimensions, units, uncert);
}

/// Units acceptable for use in describing ThermalConductivity quantities.
///
class ThermalConductivityUnits extends ThermalConductivity with Units {
  ThermalConductivityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  ThermalConductivityUnits.powerLengthTemperature(PowerUnits pu, LengthUnits lu, TemperatureIntervalUnits tiu)
      : super._internal(pu.valueSI / (lu.valueSI * tiu.valueSI)) {
    this.name = "${pu.name} per ${lu.singular} ${tiu.singular}";
    this.singular = "${pu.singular} per ${lu.singular} ${tiu.singular}";
    this._convToMKS = pu.valueSI / (lu.valueSI * tiu.valueSI);
    this._abbrev1 =
        pu._abbrev1 != null && lu._abbrev1 != null ? "${pu._abbrev1} / ${lu._abbrev1} ${tiu._abbrev1}" : null;
    this._abbrev2 = pu._abbrev2 != null && lu._abbrev2 != null ? "${pu._abbrev2}/${lu._abbrev2}${tiu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => ThermalConductivity;

  /// Derive new ThermalConductivityUnits using this ThermalConductivityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new ThermalConductivityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
