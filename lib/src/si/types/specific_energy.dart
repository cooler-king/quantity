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
      const Dimensions.constant(const {"Length": 2, "Time": -2}, type: SpecificEnergy);

  /// The standard SI unit.
  static final SpecificEnergyUnits joulesPerKilogram =
      new SpecificEnergyUnits.energyMass(Energy.joules, Mass.kilograms);

  /// Construct a SpecificEnergy with joules per kilogram ([J_per_kg]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  SpecificEnergy({dynamic J_per_kg, double uncert: 0.0})
      : super(J_per_kg ?? 0.0, SpecificEnergy.joulesPerKilogram, uncert);

  SpecificEnergy._internal(conv) : super._internal(conv, SpecificEnergy.specificEnergyDimensions);

  /// Constructs a SpecificEnergy based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  SpecificEnergy.inUnits(value, SpecificEnergyUnits units, [double uncert = 0.0])
      : super(value, units ?? SpecificEnergy.joulesPerKilogram, uncert);

  const SpecificEnergy.constant(Number valueSI, {SpecificEnergyUnits  units, double uncert: 0.0})
      : super.constant(valueSI, SpecificEnergy.specificEnergyDimensions, units, uncert);
}

/// Units acceptable for use in describing SpecificEnergy quantities.
///
class SpecificEnergyUnits extends SpecificEnergy with Units {
  SpecificEnergyUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  SpecificEnergyUnits.energyMass(EnergyUnits eu, MassUnits mu) : super._internal(eu.valueSI / mu.valueSI) {
    this.name = "${eu.name} per ${mu.singular}";
    this.singular = "${eu.singular} per ${mu.singular}";
    this._convToMKS = eu.valueSI / mu.valueSI;
    this._abbrev1 = eu._abbrev1 != null && mu._abbrev1 != null ? "${eu._abbrev1} / ${mu._abbrev1}" : null;
    this._abbrev2 = eu._abbrev2 != null && mu._abbrev2 != null ? "${eu._abbrev2}/${mu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  SpecificEnergyUnits.lengthTime(LengthUnits lu, TimeUnits tu)
      : super._internal(lu.valueSI * lu.valueSI / (tu.valueSI * tu.valueSI)) {
    this.name = "${lu.name} squared per ${tu.singular} squared";
    this.singular = "${lu.singular} squared per ${tu.singular} squared";
    this._convToMKS = lu.valueSI * lu.valueSI / (tu.valueSI * tu.valueSI);
    this._abbrev1 = lu._abbrev1 != null && tu._abbrev1 != null ? "${lu._abbrev1} sq./ ${tu._abbrev1} sq." : null;
    this._abbrev2 = lu._abbrev2 != null && tu._abbrev2 != null ? "${lu._abbrev2}^2/${tu._abbrev2}^2" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  SpecificEnergyUnits.speed(SpeedUnits su) : super._internal(su.valueSI) {
    this.name = "${su.name} squared";
    this.singular = "${su.singular} squared";
    this._convToMKS = su.valueSI;
    this._abbrev1 = su._abbrev1 != null ? "${su._abbrev1} sq." : null;
    this._abbrev2 = su._abbrev2 != null ? "${su._abbrev2}^2" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => SpecificEnergy;

  /// Derive new SpecificEnergyUnits using this SpecificEnergyUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new SpecificEnergyUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
