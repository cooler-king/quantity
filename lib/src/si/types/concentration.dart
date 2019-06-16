part of quantity_si;

/// The abundance of a constituent divided by the total volume of a mixture.
/// See the [Wikipedia entry for Concentration](https://en.wikipedia.org/wiki/Concentration)
/// for more information.
class Concentration extends Quantity {
  /// Constructs a Concentration with moles per cubic meter.
  /// Optionally specify a relative standard uncertainty.
  Concentration({dynamic molesPerCubicMeter, double uncert = 0.0})
      : super(molesPerCubicMeter ?? 0.0, Concentration.molesPerCubicMeter, uncert);

  Concentration._internal(dynamic conv) : super._internal(conv, Concentration.concentrationDimensions);

  /// Constructs a Concentration based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Concentration.inUnits(dynamic value, ConcentrationUnits units, [double uncert = 0.0])
      : super(value, units ?? Concentration.molesPerCubicMeter, uncert);

  /// Constructs a constant Concentration.
  const Concentration.constant(Number valueSI, {ConcentrationUnits units, double uncert = 0.0})
      : super.constant(valueSI, Concentration.concentrationDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions concentrationDimensions =
      const Dimensions.constant(const <String, int>{'Amount': 1, 'Length': -3}, qType: Concentration);

  /// The standard SI unit **/
  static final ConcentrationUnits molesPerCubicMeter =
      new ConcentrationUnits.amountVolume(AmountOfSubstance.moles, Volume.cubicMeters);
}

/// Units acceptable for use in describing Concentration quantities.
class ConcentrationUnits extends Concentration with Units {
  /// Constructs a new instance.
  ConcentrationUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs concentration units from an amount of substance and volume.
  ConcentrationUnits.amountVolume(AmountOfSubstanceUnits asu, VolumeUnits vu)
      : super._internal(asu.valueSI * vu.valueSI) {
    name = '${asu.name} per ${vu.singular}';
    singular = '${asu.singular} per ${vu.singular}';
    _convToMKS = asu.valueSI * vu.valueSI;
    _abbrev1 = asu._abbrev1 != null && vu._abbrev1 != null ? '${asu._abbrev1} / ${vu._abbrev1}' : null;
    _abbrev2 = asu._abbrev2 != null && vu._abbrev2 != null ? '${asu._abbrev2}/${vu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Concentration;

  /// Derive new ConcentrationUnits using this ConcentrationUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new ConcentrationUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
