part of quantity_si;

// Also HeatCapacity

class Entropy extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions entropyDimensions =
      const Dimensions.constant(const {"Length": 2, "Mass": 1, "Temperature": -1, "Time": -2});

  /// The standard SI unit.
  static final EntropyUnits joulesPerKelvin =
      new EntropyUnits.energyTemperature(Energy.joules, TemperatureInterval.kelvins);

  Entropy({dynamic J_per_K, double uncert: 0.0})
      : super(J_per_K != null ? J_per_K : 0.0, Entropy.joulesPerKelvin, uncert);

  Entropy._internal(conv) : super._dimensions(conv, Entropy.entropyDimensions);

  /// Constructs a Entropy based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Entropy.inUnits(value, EntropyUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Entropy.joulesPerKelvin, uncert);

  const Entropy.constant(Number valueSI, {EntropyUnits units, num uncert: 0.0})
      : super.constant(valueSI, Entropy.entropyDimensions, units, uncert);
}

/// Units acceptable for use in describing Entropy quantities.
///
class EntropyUnits extends Entropy with Units {
  EntropyUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  EntropyUnits.energyTemperature(EnergyUnits eu, TemperatureIntervalUnits tu)
      : super._internal(eu.valueSI * tu.valueSI) {
    this.name = "${eu.name} per ${tu.singular}";
    this.singular = "${eu.singular} per ${tu.singular}";
    this._convToMKS = eu.valueSI * tu.valueSI;
    this._abbrev1 = eu._abbrev1 != null && tu._abbrev1 != null ? "${eu._abbrev1} / ${tu._abbrev1}" : null;
    this._abbrev2 = eu._abbrev2 != null && tu._abbrev2 != null ? "${eu._abbrev2}${tu._abbrev2}" : null;
    ;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Entropy;

  /// Derive new EntropyUnits using this EntropyUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new EntropyUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
