part of quantity_si;

// Also ImpartedSpecificEnergy, Kerma

/// Energy per unit mass.
///
/// See the [Wikipedia entry for Specific energy](https://en.wikipedia.org/wiki/Specific_energy)
/// for more information.
///
class SpecificEnergy extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions specificEnergyDimensions =
      const Dimensions.constant(const <String, int>{'Length': 2, 'Time': -2}, qType: SpecificEnergy);

  /// The standard SI unit.
  static final SpecificEnergyUnits joulesPerKilogram =
      new SpecificEnergyUnits.energyMass(Energy.joules, Mass.kilograms);

  /// Construct a SpecificEnergy with joules per kilogram.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  SpecificEnergy({dynamic joulesPerKilogram, double uncert: 0.0})
      : super(joulesPerKilogram ?? 0.0, SpecificEnergy.joulesPerKilogram, uncert);

  SpecificEnergy._internal(dynamic conv) : super._internal(conv, SpecificEnergy.specificEnergyDimensions);

  /// Constructs a SpecificEnergy based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  SpecificEnergy.inUnits(dynamic value, SpecificEnergyUnits units, [double uncert = 0.0])
      : super(value, units ?? SpecificEnergy.joulesPerKilogram, uncert);

  const SpecificEnergy.constant(Number valueSI, {SpecificEnergyUnits units, double uncert: 0.0})
      : super.constant(valueSI, SpecificEnergy.specificEnergyDimensions, units, uncert);
}

/// Units acceptable for use in describing SpecificEnergy quantities.
///
class SpecificEnergyUnits extends SpecificEnergy with Units {
  /// Constructs a new instance.
  SpecificEnergyUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on energy and mass units.
  SpecificEnergyUnits.energyMass(EnergyUnits eu, MassUnits mu) : super._internal(eu.valueSI / mu.valueSI) {
    name = '${eu.name} per ${mu.singular}';
    singular = '${eu.singular} per ${mu.singular}';
    _convToMKS = eu.valueSI / mu.valueSI;
    _abbrev1 = eu._abbrev1 != null && mu._abbrev1 != null ? '${eu._abbrev1} / ${mu._abbrev1}' : null;
    _abbrev2 = eu._abbrev2 != null && mu._abbrev2 != null ? '${eu._abbrev2}/${mu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Constructs a new instance based on length and time units.
  SpecificEnergyUnits.lengthTime(LengthUnits lu, TimeUnits tu)
      : super._internal(lu.valueSI * lu.valueSI / (tu.valueSI * tu.valueSI)) {
    name = '${lu.name} squared per ${tu.singular} squared';
    singular = '${lu.singular} squared per ${tu.singular} squared';
    _convToMKS = lu.valueSI * lu.valueSI / (tu.valueSI * tu.valueSI);
    _abbrev1 = lu._abbrev1 != null && tu._abbrev1 != null ? '${lu._abbrev1} sq./ ${tu._abbrev1} sq.' : null;
    _abbrev2 = lu._abbrev2 != null && tu._abbrev2 != null ? '${lu._abbrev2}^2/${tu._abbrev2}^2' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Constructs a new instance based on speed units.
  SpecificEnergyUnits.speed(SpeedUnits su) : super._internal(su.valueSI) {
    name = '${su.name} squared';
    singular = '${su.singular} squared';
    _convToMKS = su.valueSI;
    _abbrev1 = su._abbrev1 != null ? '${su._abbrev1} sq.' : null;
    _abbrev2 = su._abbrev2 != null ? '${su._abbrev2}^2' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => SpecificEnergy;

  /// Derive new SpecificEnergyUnits using this SpecificEnergyUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new SpecificEnergyUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
  
}
