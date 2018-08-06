part of quantity_si;

/// Energy per mole of a substance.
///
/// See the [Wikipedia entry for Specific energy](https://en.wikipedia.org/wiki/Specific_energy)
/// for more information.
///
class MolarEnergy extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions molarEnergyDimensions =
      const Dimensions.constant(const <String, int>{'Mass': 1, 'Length': 2, 'Time': -2, 'Amount': -1}, qType: MolarEnergy);

  /// The standard SI unit.
  static final MolarEnergyUnits joulesPerMole =
      new MolarEnergyUnits.energyAmount(Energy.joules, AmountOfSubstance.moles);

  /// Construct a MolarEnergy with joules per mole.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  MolarEnergy({dynamic joulesPerMole, double uncert = 0.0}) : super(joulesPerMole ?? 0.0, MolarEnergy.joulesPerMole, uncert);

  MolarEnergy._internal(dynamic conv) : super._internal(conv, MolarEnergy.molarEnergyDimensions);

  /// Constructs a MolarEnergy based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  MolarEnergy.inUnits(dynamic value, MolarEnergyUnits units, [double uncert = 0.0])
      : super(value, units ?? MolarEnergy.joulesPerMole, uncert);

  const MolarEnergy.constant(Number valueSI, {MolarEnergyUnits units, double uncert = 0.0})
      : super.constant(valueSI, MolarEnergy.molarEnergyDimensions, units, uncert);
}

/// Units acceptable for use in describing MolarEnergy quantities.
///
class MolarEnergyUnits extends MolarEnergy with Units {
  /// Constructs a new instance.
  MolarEnergyUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on energy and amount of substance units.
  MolarEnergyUnits.energyAmount(EnergyUnits eu, AmountOfSubstanceUnits aosu)
      : super._internal(eu.valueSI * aosu.valueSI) {
    name = '${eu.name} per ${aosu.singular}';
    singular = '${eu.singular} per ${aosu.singular}';
    _convToMKS = eu.valueSI * aosu.valueSI;
    _abbrev1 = eu._abbrev1 != null && aosu._abbrev1 != null ? '${eu._abbrev1} / ${aosu._abbrev1}' : null;
    _abbrev2 = eu._abbrev2 != null && aosu._abbrev2 != null ? '${eu._abbrev2}${aosu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => MolarEnergy;

  /// Derive new MolarEnergyUnits using this MolarEnergyUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new MolarEnergyUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
  
}
