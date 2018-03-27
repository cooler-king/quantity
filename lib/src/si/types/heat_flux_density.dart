part of quantity_si;

// Also EnergyFluxDensity, Irradiance, PowerFluxDensity

/// Heat rate per unit area.
///
/// See the [Wikipedia entry for Heat flux](https://en.wikipedia.org/wiki/Heat_flux)
/// for more information.
///
class HeatFluxDensity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions heatFluxDensityDimensions =
      const Dimensions.constant(const <String, int>{'Mass': 1, 'Time': -3}, qType: HeatFluxDensity);

  /// The standard SI unit.
  static final HeatFluxDensityUnits wattsPerSquareMeter =
      new HeatFluxDensityUnits.powerArea(Power.watts, Area.squareMeters);

  /// Construct a HeatFluxDensity with watts per square meter.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  HeatFluxDensity({dynamic wattsPerSquareMeter, double uncert: 0.0})
      : super(wattsPerSquareMeter ?? 0.0, HeatFluxDensity.wattsPerSquareMeter, uncert);

  HeatFluxDensity._internal(dynamic conv) : super._internal(conv, HeatFluxDensity.heatFluxDensityDimensions);

  /// Constructs a HeatFluxDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  HeatFluxDensity.inUnits(dynamic value, HeatFluxDensityUnits units, [double uncert = 0.0])
      : super(value, units ?? HeatFluxDensity.wattsPerSquareMeter, uncert);

  const HeatFluxDensity.constant(Number valueSI, {HeatFluxDensityUnits units, double uncert: 0.0})
      : super.constant(valueSI, HeatFluxDensity.heatFluxDensityDimensions, units, uncert);
}

/// Units acceptable for use in describing HeatFluxDensity quantities.
///
class HeatFluxDensityUnits extends HeatFluxDensity with Units {
  HeatFluxDensityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  HeatFluxDensityUnits.powerArea(PowerUnits pu, AreaUnits au) : super._internal(pu.valueSI * au.valueSI) {
    name = '${pu.name} per ${au.singular}';
    singular = '${pu.singular} per ${au.singular}';
    _convToMKS = pu.valueSI * au.valueSI;
    _abbrev1 = pu._abbrev1 != null && au._abbrev1 != null ? '${pu._abbrev1} / ${au._abbrev1}' : null;
    _abbrev2 = pu._abbrev2 != null && au._abbrev2 != null ? '${pu._abbrev2}${au._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => HeatFluxDensity;

  /// Derive new HeatFluxDensityUnits using this HeatFluxDensityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new HeatFluxDensityUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
  
}
