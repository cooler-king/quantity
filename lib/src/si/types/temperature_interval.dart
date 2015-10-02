part of quantity_si;

/// The difference between two temperatures, where temperature is an objective comparative
/// measure of hot or cold.
///
/// See the [Wikipedia entry for Thermodynamic temperature](https://en.wikipedia.org/wiki/Thermodynamic_temperature)
/// for more information.
///
class TemperatureInterval extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions temperatureIntervalDimensions = const Dimensions.constant(const {"Temperature": 1});

  /// The standard SI unit.
  static final TemperatureIntervalUnits kelvins = new TemperatureIntervalUnits("kelvins", null, "K", null, 1.0, true);

  /// Derived SI unit.
  static final TemperatureIntervalUnits degreesCelsius =
      new TemperatureIntervalUnits("degrees Celsius", "deg C", null, "degree Celsius", 1.0, true);

  /// Construct a TemperatureInterval with kelvin ([K]) or degrees Celsius ([degC]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  TemperatureInterval({dynamic K, dynamic degC, double uncert: 0.0})
      : super(K ?? (degC ?? 0.0), degC != null ? TemperatureInterval.degreesCelsius : TemperatureInterval.kelvins,
            uncert);

  TemperatureInterval._internal(conv) : super._dimensions(conv, TemperatureInterval.temperatureIntervalDimensions);

  /// Constructs a TemperatureInterval based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  TemperatureInterval.inUnits(value, TemperatureIntervalUnits units, [double uncert = 0.0])
      : super(value, units ?? TemperatureInterval.kelvins, uncert);

  const TemperatureInterval.constant(Number valueSI, {TemperatureIntervalUnits units, num uncert: 0.0})
      : super.constant(valueSI, TemperatureInterval.temperatureIntervalDimensions, units, uncert);
}

/// Units acceptable for use in describing TemperatureInterval quantities.
///
class TemperatureIntervalUnits extends TemperatureInterval with Units {
  TemperatureIntervalUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => TemperatureInterval;

  /// Derive new TemperatureIntervalUnits using this TemperatureIntervalUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new TemperatureIntervalUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
