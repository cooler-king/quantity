part of quantity_si;

// Also SpecificEntropy

class SpecificHeatCapacity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions specificHeatCapacityDimensions =
      const Dimensions.constant(const {"Length": 2, "Time": -2, "Temperature": -1});

  /// The standard SI unit.
  static final SpecificHeatCapacityUnits joulesPerKilogramKelvin =
      new SpecificHeatCapacityUnits.energyMassTemperature(Energy.joules, Mass.kilograms, TemperatureInterval.kelvins);

  SpecificHeatCapacity({dynamic J_per_kgK, double uncert: 0.0})
      : super(J_per_kgK != null ? J_per_kgK : 0.0, SpecificHeatCapacity.joulesPerKilogramKelvin, uncert);

  SpecificHeatCapacity._internal(conv) : super._dimensions(conv, SpecificHeatCapacity.specificHeatCapacityDimensions);

  /// Constructs a SpecificHeatCapacity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  SpecificHeatCapacity.inUnits(value, SpecificHeatCapacityUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : SpecificHeatCapacity.joulesPerKilogramKelvin, uncert);

  const SpecificHeatCapacity.constant(Number valueSI, {SpecificHeatCapacityUnits units, num uncert: 0.0})
      : super.constant(valueSI, SpecificHeatCapacity.specificHeatCapacityDimensions, units, uncert);
}

/// Units acceptable for use in describing SpecificHeatCapacity quantities.
///
class SpecificHeatCapacityUnits extends SpecificHeatCapacity with Units {
  SpecificHeatCapacityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  SpecificHeatCapacityUnits.energyMassTemperature(EnergyUnits eu, MassUnits mu, TemperatureIntervalUnits tu)
      : super._internal(eu.valueSI / (mu.valueSI * tu.valueSI)) {
    this.name = "${eu.name} per ${mu.singular} ${tu.singular}";
    this.singular = "${eu.singular} per ${mu.singular} ${tu.singular}";
    this._convToMKS = eu.valueSI / (mu.valueSI * tu.valueSI);
    this._abbrev1 =
        eu._abbrev1 != null && mu._abbrev1 != null ? "${eu._abbrev1} / ${mu._abbrev1} ${tu._abbrev1}" : null;
    this._abbrev2 = eu._abbrev2 != null && mu._abbrev2 != null ? "${eu._abbrev2}${mu._abbrev2}${tu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => SpecificHeatCapacity;

  /// Derive new SpecificHeatCapacityUnits using this SpecificHeatCapacityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new SpecificHeatCapacityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
