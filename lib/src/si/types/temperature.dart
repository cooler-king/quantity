part of quantity_si;

class Temperature extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions temperatureDimensions = const Dimensions.constant(const {"Temperature": 1});

  // Units

  /// The standard SI unit.
  static final TemperatureUnits kelvins = new TemperatureUnits("kelvins", "K", null, null, Double.one, true, 0.0);

  /// Derived SI unit.
  static final TemperatureUnits degreesCelsius =
      new TemperatureUnits("degrees Celsius", "deg C", null, "degree Celsius", Double.one, false, 273.15);

  Temperature({dynamic K, dynamic C, double uncert: 0.0})
      : super(K != null ? K : (C != null ? C : 0.0), C != null ? Temperature.degreesCelsius : Temperature.kelvins,
            uncert);

  Temperature._internal(conv) : super._dimensions(conv, Temperature.temperatureDimensions);

  /// Constructs a Temperature based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Temperature.inUnits(value, TemperatureUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Temperature.kelvins, uncert);

  const Temperature.constant(Number valueSI, {TemperatureUnits units, num uncert: 0.0})
      : super.constant(valueSI, Temperature.temperatureDimensions, units, uncert);
}

/// Units acceptable for use in describing [Temperature] quantities.
///
class TemperatureUnits extends Temperature with Units {
  TemperatureUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
      [bool metricBase = false, double offset = 0.0])
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
  Type get quantityType => Temperature;

  /// Derive new TemperatureUnits using this TemperatureUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new TemperatureUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }

  /// Calculates and returns the temperature in Kelvin of the specified value
  /// (which is implicitly in these units).  Takes into account any offset
  /// between absolute temperature scales.
  ///
  Number toMks(value) {
    if (value is num || value is Number) {
      return valueSI * (value + offset);
    } else {
      throw new ArgumentError("num or Number expected");
    }
  }

  /// Calculates and returns the value in the units represented by this Units
  /// object of the specified value (which is implicitly in Kelvins). Takes
  /// into account any offset between absolute temperature scales.
  ///
  Number fromMks(value) {
    if (value is num || value is Number) {
      return (value / valueSI) - offset;
    } else {
      throw new ArgumentError("num or Number expected");
    }
  }
}
