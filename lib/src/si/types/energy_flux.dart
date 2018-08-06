part of quantity_si;

/// The rate of transfer of energy through a surface.
///
/// See the [Wikipedia entry for Energy density](https://en.wikipedia.org/wiki/Energy_density)
/// for more information.
///
class EnergyFlux extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions energyFluxDimensions =
      const Dimensions.constant(const <String, int>{'Length': 2, 'Mass': 1, 'Time': -3}, qType: EnergyFlux);

  /// The standard SI unit.
  static final EnergyFluxUnits wattsPerSquareMeter = new EnergyFluxUnits.powerArea(Power.watts, Area.squareMeters);

  /// Construct an EnergyFlux with watts per square meter.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  EnergyFlux({dynamic wattsPerSquareMeter, double uncert = 0.0}) : super(wattsPerSquareMeter ?? 0.0, EnergyFlux.wattsPerSquareMeter, uncert);

  EnergyFlux._internal(dynamic conv) : super._internal(conv, EnergyFlux.energyFluxDimensions);

  /// Constructs a EnergyFlux based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  EnergyFlux.inUnits(dynamic value, EnergyFluxUnits units, [double uncert = 0.0])
      : super(value, units ?? EnergyFlux.wattsPerSquareMeter, uncert);

  const EnergyFlux.constant(Number valueSI, {EnergyFluxUnits units, double uncert = 0.0})
      : super.constant(valueSI, EnergyFlux.energyFluxDimensions, units, uncert);
}

/// Units acceptable for use in describing EnergyFlux quantities.
///
class EnergyFluxUnits extends EnergyFlux with Units {
  EnergyFluxUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  EnergyFluxUnits.powerArea(PowerUnits pu, AreaUnits au) : super._internal(pu.valueSI * au.valueSI) {
    name = '${pu.name} per ${au.singular}';
    singular = '${pu.singular} per ${au.singular}';
    _convToMKS = pu.valueSI * au.valueSI;
    _abbrev1 = pu._abbrev1 != null && au._abbrev1 != null ? '${pu._abbrev1} / ${au._abbrev1}' : null;
    _abbrev2 = pu._abbrev2 != null && au._abbrev2 != null ? '${pu._abbrev2}/${au._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => EnergyFlux;

  /// Derive new EnergyFluxUnits using this EnergyFluxUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new EnergyFluxUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
  
}
