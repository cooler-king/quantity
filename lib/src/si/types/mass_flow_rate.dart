part of quantity_si;

/// The mass of a substance which passes per unit of time.
///
/// See the [Wikipedia entry for Mass flow rate](https://en.wikipedia.org/wiki/Mass_flow_rate)
/// for more information.
///
class MassFlowRate extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions massFlowRateDimensions =
      const Dimensions.constant(const <String, int>{'Mass': 1, 'Time': -1}, qType: MassFlowRate);

  /// The standard SI unit.
  static final MassFlowRateUnits kilogramsPerSecond = new MassFlowRateUnits.massTime(Mass.kilograms, Time.seconds);

  /// Construct a MassFlowRate with kilograms per second ([kg_per_s]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  MassFlowRate({dynamic kg_per_s, double uncert: 0.0})
      : super(kg_per_s ?? 0.0, MassFlowRate.kilogramsPerSecond, uncert);

  MassFlowRate._internal(dynamic conv) : super._internal(conv, MassFlowRate.massFlowRateDimensions);

  /// Constructs a MassFlowRate based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  MassFlowRate.inUnits(dynamic value, MassFlowRateUnits units, [double uncert = 0.0])
      : super(value, units ?? MassFlowRate.kilogramsPerSecond, uncert);

  const MassFlowRate.constant(Number valueSI, {MassFlowRateUnits units, double uncert: 0.0})
      : super.constant(valueSI, MassFlowRate.massFlowRateDimensions, units, uncert);
}

/// Units acceptable for use in describing MassFlowRate quantities.
///
class MassFlowRateUnits extends MassFlowRate with Units {
  MassFlowRateUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  MassFlowRateUnits.massTime(MassUnits mu, TimeUnits tu) : super._internal(mu.valueSI * tu.valueSI) {
    this.name = '${mu.name} per ${tu.singular}';
    this.singular = '${mu.singular} per ${tu.singular}';
    this._convToMKS = mu.valueSI * tu.valueSI;
    this._abbrev1 = mu._abbrev1 != null && tu._abbrev1 != null ? '${mu._abbrev1} / ${tu._abbrev1}' : null;
    this._abbrev2 = mu._abbrev2 != null && tu._abbrev2 != null ? '${mu._abbrev2}${tu._abbrev2}' : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => MassFlowRate;

  /// Derive new MassFlowRateUnits using this MassFlowRateUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new MassFlowRateUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        this.offset);
  
}
