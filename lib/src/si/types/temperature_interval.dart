part of quantity_si;

/// The difference between two temperatures, where temperature is an objective comparative
/// measure of hot or cold.
/// See the [Wikipedia entry for Thermodynamic temperature](https://en.wikipedia.org/wiki/Thermodynamic_temperature)
/// for more information.
class TemperatureInterval extends Quantity {
  /// Constructs a TemperatureInterval with kelvin ([K]) or degrees Celsius ([degC]).
  /// Optionally specify a relative standard uncertainty.
  TemperatureInterval({dynamic K, dynamic degC, double uncert = 0.0})
      : super(K ?? (degC ?? 0.0), degC != null ? TemperatureInterval.degreesCelsius : TemperatureInterval.kelvins,
            uncert);

  TemperatureInterval._internal(dynamic conv)
      : super._internal(conv, TemperatureInterval.temperatureIntervalDimensions);

  /// Constructs a TemperatureInterval based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  TemperatureInterval.inUnits(dynamic value, TemperatureIntervalUnits units, [double uncert = 0.0])
      : super(value, units ?? TemperatureInterval.kelvins, uncert);

  /// Constructs a constant TemperatureInterval.
  const TemperatureInterval.constant(Number valueSI, {TemperatureIntervalUnits units, double uncert = 0.0})
      : super.constant(valueSI, TemperatureInterval.temperatureIntervalDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions temperatureIntervalDimensions =
      const Dimensions.constant(const <String, int>{'Temperature': 1}, qType: TemperatureInterval);

  /// The standard SI unit.
  static final TemperatureIntervalUnits kelvins = new TemperatureIntervalUnits('kelvins', null, 'K', null, 1.0, true);

  /// Derived SI unit.
  static final TemperatureIntervalUnits degreesCelsius =
      new TemperatureIntervalUnits('degrees Celsius', 'deg C', null, 'degree Celsius', 1.0, true);

  /// Override the addition operator to manage the [Temperature]/`TemperatureInterval` relationship.
  ///
  /// * Adding a `Temperature` returns a [Temperature] object.
  /// * Adding a `TemperatureInterval` returns a [TemperatureInterval] object.
  @override
  Quantity operator +(dynamic addend) {
    if (addend is TemperatureInterval) {
      final Number newValueSI = valueSI + addend.valueSI;
      final double ur = _calcRelativeCombinedUncertaintySumDiff(this, addend, newValueSI);
      return new TemperatureInterval(K: newValueSI, uncert: ur);
    } else if (addend is Temperature) {
      final Number newValueSI = valueSI + addend.valueSI;
      final double ur = _calcRelativeCombinedUncertaintySumDiff(this, addend, newValueSI);
      return new Temperature(K: newValueSI, uncert: ur);
    } else {
      return super + addend;
    }
  }

  /// Override the subtraction operator to manage the [Temperature]/`TemperatureInterval` relationship.
  ///
  /// * Subtracting a `TemperatureInterval` returns a `TemperatureInterval` object.
  /// * Attempting to subtract a `Temperature` from a `TemperatureInterval` throws a
  /// [QuantityException] as a physically nonsensical operation.
  @override
  Quantity operator -(dynamic subtrahend) {
    if (subtrahend is TemperatureInterval) {
      final Number newValueSI = valueSI - subtrahend.valueSI;
      final double ur = _calcRelativeCombinedUncertaintySumDiff(this, subtrahend, newValueSI);
      return new TemperatureInterval(K: newValueSI, uncert: ur);
    } else if (subtrahend is Temperature) {
      throw const QuantityException('Subtracting a Temperature from a TemperatureInterval is not supported.');
    } else {
      return super - subtrahend;
    }
  }

  /// Returns the [Temperature] equal to this temperature interval measured from 0 degrees kelvin.
  Temperature toTemperature() => new Temperature(K: valueSI, uncert: _ur);
}

/// Units acceptable for use in describing TemperatureInterval quantities.
class TemperatureIntervalUnits extends TemperatureInterval with Units {
  /// Constructs a new instance.
  TemperatureIntervalUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => TemperatureInterval;

  /// Derive new TemperatureIntervalUnits using this TemperatureIntervalUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new TemperatureIntervalUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
