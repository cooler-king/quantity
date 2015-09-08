part of quantity_si;

//until typedefs work with classes
class EnergyFlux extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions energyFluxDimensions = Power.powerDimensions;

  /// The standard SI unit.
  static final EnergyFluxUnits wattsPerSquareMeter = new EnergyFluxUnits.powerArea(Power.watts, Area.squareMeters);

  EnergyFlux({dynamic W_per_m2, double uncert: 0.0})
      : super(W_per_m2 != null ? W_per_m2 : 0.0, EnergyFlux.wattsPerSquareMeter, uncert);

  EnergyFlux._internal(conv) : super._dimensions(conv, EnergyFlux.energyFluxDimensions);

  /// Constructs a EnergyFlux based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  EnergyFlux.inUnits(value, EnergyFluxUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : EnergyFlux.wattsPerSquareMeter, uncert);

  const EnergyFlux.constant(Number valueSI, {EnergyFluxUnits units, num uncert: 0.0})
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
    this._convToMKS = objToNumber(conv);
    this._abbrev1 = abbrev1;
    this._abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset;
  }

  EnergyFluxUnits.powerArea(PowerUnits pu, AreaUnits au) : super._internal(pu.valueSI * au.valueSI) {
    this.name = "${pu.name} per ${au.singular}";
    this.singular = "${pu.singular} per ${au.singular}";
    this._convToMKS = pu.valueSI * au.valueSI;
    this._abbrev1 = pu._abbrev1 != null && au._abbrev1 != null ? "${pu._abbrev1} / ${au._abbrev1}" : null;
    this._abbrev2 = pu._abbrev2 != null && au._abbrev2 != null ? "${pu._abbrev2}/${au._abbrev2}" : null;
    ;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => EnergyFlux;

  /// Derive new EnergyFluxUnits using this EnergyFluxUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new EnergyFluxUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
