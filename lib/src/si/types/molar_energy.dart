part of quantity_si;

/// Energy per mole of a substance.
///
/// See the [Wikipedia entry for Specific energy](https://en.wikipedia.org/wiki/Specific_energy)
/// for more information.
///
class MolarEnergy extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions molarEnergyDimensions =
      const Dimensions.constant(const {"Mass": 1, "Length": 2, "Time": -2, "Amount": -1});

  /// The standard SI unit.
  static final MolarEnergyUnits joulesPerMole =
      new MolarEnergyUnits.energyAmount(Energy.joules, AmountOfSubstance.moles);

  /// Construct a MolarEnergy with joules per mole ([J_per_mol]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  MolarEnergy({dynamic J_per_mol, double uncert: 0.0}) : super(J_per_mol ?? 0.0, MolarEnergy.joulesPerMole, uncert);

  MolarEnergy._internal(conv) : super._internal(conv, MolarEnergy.molarEnergyDimensions);

  /// Constructs a MolarEnergy based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  MolarEnergy.inUnits(value, MolarEnergyUnits units, [double uncert = 0.0])
      : super(value, units ?? MolarEnergy.joulesPerMole, uncert);

  const MolarEnergy.constant(Number valueSI, {MolarEnergyUnits units, num uncert: 0.0})
      : super.constant(valueSI, MolarEnergy.molarEnergyDimensions, units, uncert);
}

/// Units acceptable for use in describing MolarEnergy quantities.
///
class MolarEnergyUnits extends MolarEnergy with Units {
  MolarEnergyUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  MolarEnergyUnits.energyAmount(EnergyUnits eu, AmountOfSubstanceUnits aosu)
      : super._internal(eu.valueSI * aosu.valueSI) {
    this.name = "${eu.name} per ${aosu.singular}";
    this.singular = "${eu.singular} per ${aosu.singular}";
    this._convToMKS = eu.valueSI * aosu.valueSI;
    this._abbrev1 = eu._abbrev1 != null && aosu._abbrev1 != null ? "${eu._abbrev1} / ${aosu._abbrev1}" : null;
    this._abbrev2 = eu._abbrev2 != null && aosu._abbrev2 != null ? "${eu._abbrev2}${aosu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => MolarEnergy;

  /// Derive new MolarEnergyUnits using this MolarEnergyUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new MolarEnergyUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
