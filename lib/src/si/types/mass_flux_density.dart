part of quantity_si;

/// The mass of a substance which passes per unit of time.
///
/// See the [Wikipedia entry for Mass flow rate](https://en.wikipedia.org/wiki/Mass_flow_rate)
/// for more information.
///
class MassFluxDensity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions massFluxDensityDimensions =
      const Dimensions.constant(const {"Mass": 1, "Time": -1, "Length": -2});

  /// The standard SI unit.
  static final MassFluxDensityUnits kilogramsPerSecondPerSquareMeter =
      new MassFluxDensityUnits.massTimeArea(Mass.kilograms, Time.seconds, Area.squareMeters);

  /// Construct a MassFluxDensity with kilograms per second per square meter ([kg_per_s_per_m2]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  MassFluxDensity({dynamic kg_per_s_per_m2, double uncert: 0.0})
      : super(kg_per_s_per_m2 ?? 0.0, MassFluxDensity.kilogramsPerSecondPerSquareMeter, uncert);

  MassFluxDensity._internal(conv) : super._internal(conv, MassFluxDensity.massFluxDensityDimensions);

  /// Constructs a MassFluxDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  MassFluxDensity.inUnits(value, MassFluxDensityUnits units, [double uncert = 0.0])
      : super(value, units ?? MassFluxDensity.kilogramsPerSecondPerSquareMeter, uncert);

  const MassFluxDensity.constant(Number valueSI, {MassFluxDensityUnits units, num uncert: 0.0})
      : super.constant(valueSI, MassFluxDensity.massFluxDensityDimensions, units, uncert);
}

/// Units acceptable for use in describing MassFluxDensity quantities.
///
class MassFluxDensityUnits extends MassFluxDensity with Units {
  MassFluxDensityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  MassFluxDensityUnits.massTimeArea(MassUnits mu, TimeUnits tu, AreaUnits au)
      : super._internal(mu.valueSI / (tu.valueSI * au.valueSI)) {
    this.name = "${mu.name} per ${tu.singular} per ${au.singular}";
    this.singular = "${mu.singular} per ${tu.singular} per ${au.singular}";
    this._convToMKS = mu.valueSI / (tu.valueSI * au.valueSI);
    this._abbrev1 =
        mu._abbrev1 != null && tu._abbrev1 != null ? "${mu._abbrev1} / ${tu._abbrev1} / ${au._abbrev1}" : null;
    this._abbrev2 = mu._abbrev2 != null && tu._abbrev2 != null ? "${mu._abbrev2}/${tu._abbrev2}/${au._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => MassFluxDensity;

  /// Derive new MassFluxDensityUnits using this MassFluxDensityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new MassFluxDensityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
