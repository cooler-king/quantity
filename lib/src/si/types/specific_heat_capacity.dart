part of quantity_si;

// Also SpecificEntropy

/// The heat capacity per unit mass of a material.
///
/// See the [Wikipedia entry for Heat capacity](https://en.wikipedia.org/wiki/Heat_capacity)
/// for more information.
///
class SpecificHeatCapacity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions specificHeatCapacityDimensions =
      const Dimensions.constant(const <String, int>{'Length': 2, 'Time': -2, 'Temperature': -1}, qType: SpecificHeatCapacity);

  /// The standard SI unit.
  static final SpecificHeatCapacityUnits joulesPerKilogramKelvin =
      new SpecificHeatCapacityUnits.energyMassTemperature(Energy.joules, Mass.kilograms, TemperatureInterval.kelvins);

  /// Construct a SpecificHeatCapacity with joules per kilogram kelvin.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  SpecificHeatCapacity({dynamic joulesPerKilogramKelvin, double uncert = 0.0})
      : super(joulesPerKilogramKelvin ?? 0.0, SpecificHeatCapacity.joulesPerKilogramKelvin, uncert);

  SpecificHeatCapacity._internal(dynamic conv)
      : super._internal(conv, SpecificHeatCapacity.specificHeatCapacityDimensions);

  /// Constructs a SpecificHeatCapacity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  SpecificHeatCapacity.inUnits(dynamic value, SpecificHeatCapacityUnits units, [double uncert = 0.0])
      : super(value, units ?? SpecificHeatCapacity.joulesPerKilogramKelvin, uncert);

  const SpecificHeatCapacity.constant(Number valueSI, {SpecificHeatCapacityUnits units, double uncert = 0.0})
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
    _convToMKS = objToNumber(conv);
    _abbrev1 = abbrev1;
    _abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  SpecificHeatCapacityUnits.energyMassTemperature(EnergyUnits eu, MassUnits mu, TemperatureIntervalUnits tu)
      : super._internal(eu.valueSI / (mu.valueSI * tu.valueSI)) {
    name = '${eu.name} per ${mu.singular} ${tu.singular}';
    singular = '${eu.singular} per ${mu.singular} ${tu.singular}';
    _convToMKS = eu.valueSI / (mu.valueSI * tu.valueSI);
    _abbrev1 =
        eu._abbrev1 != null && mu._abbrev1 != null ? '${eu._abbrev1} / ${mu._abbrev1} ${tu._abbrev1}' : null;
    _abbrev2 = eu._abbrev2 != null && mu._abbrev2 != null ? '${eu._abbrev2}${mu._abbrev2}${tu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => SpecificHeatCapacity;

  /// Derive new SpecificHeatCapacityUnits using this SpecificHeatCapacityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new SpecificHeatCapacityUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
  
}
