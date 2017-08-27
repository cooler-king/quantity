part of quantity_si;

/// An objective comparative measure of hot or cold.
///
/// See the [Wikipedia entry for Thermodynamic temperature](https://en.wikipedia.org/wiki/Thermodynamic_temperature)
/// for more information.
///
class Temperature extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions temperatureDimensions =
      const Dimensions.constant(const {"Temperature": 1}, type: Temperature);

  // Units

  /// The standard SI unit.
  static final TemperatureUnits kelvins = new TemperatureUnits("kelvins", "K", null, null, Double.one, true, 0.0);

  /// Derived SI unit.
  static final TemperatureUnits degreesCelsius =
      new TemperatureUnits("degrees Celsius", "deg C", null, "degree Celsius", Double.one, false, 273.15);

  /// Construct a Temperature with kelvins ([K]) or degrees Celsius ([C]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Temperature({dynamic K, dynamic C, double uncert: 0.0})
      : super(K ?? (C ?? 0.0), C != null ? Temperature.degreesCelsius : Temperature.kelvins, uncert);

  Temperature._internal(dynamic conv) : super._internal(conv, Temperature.temperatureDimensions);

  /// Constructs a Temperature based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Temperature.inUnits(dynamic value, TemperatureUnits units, [double uncert = 0.0])
      : super(value, units ?? Temperature.kelvins, uncert);

  const Temperature.constant(Number valueSI, {TemperatureUnits units, double uncert: 0.0})
      : super.constant(valueSI, Temperature.temperatureDimensions, units, uncert);

  /// Override the addition operator to manage the `Temperature`/[TemperatureInterval] relationship.
  ///
  @override
  operator +(dynamic addend) {
    if (addend is TemperatureInterval || addend is Temperature) {
      var newValueSI = valueSI + addend.valueSI;
      var ur = _calcRelativeCombinedUncertaintySumDiff(this, addend as Quantity, newValueSI);
      return new Temperature(K: newValueSI, uncert: ur);
    } else {
      return super + addend;
    }
  }

  /// Override the subtraction operator to manage the `Temperature`/[TemperatureInterval] relationship.
  ///
  /// * Subtracting a `Temperature` returns a [TemperatureInterval] object.
  /// * Subtracting a `TemperatureInterval` returns a [Temperature] object.
  ///
  @override
  operator -(dynamic subtrahend) {
    if (subtrahend is TemperatureInterval) {
      var newValueSI = valueSI - subtrahend.valueSI;
      var ur = _calcRelativeCombinedUncertaintySumDiff(this, subtrahend, newValueSI);
      return new Temperature(K: newValueSI, uncert: ur);
    } else if (subtrahend is Temperature) {
      var newValueSI = valueSI - subtrahend.valueSI;
      var ur = _calcRelativeCombinedUncertaintySumDiff(this, subtrahend, newValueSI);
      return new TemperatureInterval(K: newValueSI, uncert: ur);
    } else {
      return super - subtrahend;
    }
  }

  /// Returns the [TemperatureInterval] equal to this temperature in kelvins.
  ///
  TemperatureInterval toInterval() => new TemperatureInterval(K: valueSI, uncert: _ur);
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
    this.offset = offset.toDouble();
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
}
