part of quantity_si;

/// The ability of a material to conduct heat.
/// See the [Wikipedia entry for Thermal conductivity](https://en.wikipedia.org/wiki/Thermal_conductivity)
/// for more information.
class ThermalConductivity extends Quantity {
  /// Constructs a ThermalConductivity with watts per meter kelvin.
  /// Optionally specify a relative standard uncertainty.
  ThermalConductivity({dynamic wattsPerMeterKelvin, double uncert = 0.0})
      : super(wattsPerMeterKelvin ?? 0.0, ThermalConductivity.wattsPerMeterKelvin, uncert);

  ThermalConductivity._internal(dynamic conv)
      : super._internal(conv, ThermalConductivity.thermalConductivityDimensions);

  /// Constructs a ThermalConductivity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ThermalConductivity.inUnits(dynamic value, ThermalConductivityUnits units, [double uncert = 0.0])
      : super(value, units ?? ThermalConductivity.wattsPerMeterKelvin, uncert);

  /// Constructs a constant ThermalConductivity.
  const ThermalConductivity.constant(Number valueSI, {ThermalConductivityUnits units, double uncert = 0.0})
      : super.constant(valueSI, ThermalConductivity.thermalConductivityDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions thermalConductivityDimensions = const Dimensions.constant(
      const <String, int>{'Length': 1, 'Mass': 1, 'Time': -3, 'Temperature': -1},
      qType: ThermalConductivity);

  /// The standard SI unit.
  static final ThermalConductivityUnits wattsPerMeterKelvin =
      new ThermalConductivityUnits.powerLengthTemperature(Power.watts, Length.meters, TemperatureInterval.kelvins);
}

/// Units acceptable for use in describing ThermalConductivity quantities.
class ThermalConductivityUnits extends ThermalConductivity with Units {
  /// Constructs a new instance.
  ThermalConductivityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on power, length and temperature interval units.
  ThermalConductivityUnits.powerLengthTemperature(PowerUnits pu, LengthUnits lu, TemperatureIntervalUnits tiu)
      : super._internal(pu.valueSI / (lu.valueSI * tiu.valueSI)) {
    name = '${pu.name} per ${lu.singular} ${tiu.singular}';
    singular = '${pu.singular} per ${lu.singular} ${tiu.singular}';
    _convToMKS = pu.valueSI / (lu.valueSI * tiu.valueSI);
    _abbrev1 = pu._abbrev1 != null && lu._abbrev1 != null ? '${pu._abbrev1} / ${lu._abbrev1} ${tiu._abbrev1}' : null;
    _abbrev2 = pu._abbrev2 != null && lu._abbrev2 != null ? '${pu._abbrev2}/${lu._abbrev2}${tiu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => ThermalConductivity;

  /// Derive new ThermalConductivityUnits using this ThermalConductivityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new ThermalConductivityUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
