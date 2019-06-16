part of quantity_si;

// Also QuantityOfHeat, Work.

/// The ability of a system to perform work; cannot be created or destroyed but can take many forms.
/// See the [Wikipedia entry for Energy](https://en.wikipedia.org/wiki/Energy)
/// for more information.
class Energy extends Quantity {
  /// Constructs an Energy with joules ([J]) or electron volts ([eV]).
  /// Optionally specify a relative standard uncertainty.
  Energy({dynamic J, dynamic eV, double uncert = 0.0})
      : super(J ?? (eV ?? 0.0), eV != null ? Energy.electronVolts : Energy.joules, uncert);

  Energy._internal(dynamic conv) : super._internal(conv, Energy.energyDimensions);

  /// Constructs a Energy based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Energy.inUnits(dynamic value, EnergyUnits units, [double uncert = 0.0])
      : super(value, units ?? Energy.joules, uncert);

  /// Constructs a constant Energy.
  const Energy.constant(Number valueSI, {EnergyUnits units, double uncert = 0.0})
      : super.constant(valueSI, Energy.energyDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions energyDimensions =
      const Dimensions.constant(const <String, int>{'Length': 2, 'Mass': 1, 'Time': -2}, qType: Energy);

  /// The standard SI unit.
  static final EnergyUnits joules = new EnergyUnits('joules', null, 'J', null, 1.0, true);

  /// Accepted for use with the SI.
  static final EnergyUnits electronVolts = new EnergyUnits('electronvolts', null, 'eV', null, 1.60217653e-19, false);

  /// Returns the [Mass] equivalent of this Energy using the famous E=mc^2 relationship.
  Mass toMass() {
    if (valueSI is Precise) {
      final Precise c = new Precise('2.99792458e8');
      return new Mass(kg: valueSI / (c * c), uncert: _ur);
    } else {
      const double c = 299792458;
      return new Mass(kg: valueSI / (c * c), uncert: _ur);
    }
  }
}

/// Units acceptable for use in describing Energy quantities.
class EnergyUnits extends Energy with Units {
  /// Constructs a new instance.
  EnergyUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on power and time units.
  EnergyUnits.powerTime(PowerUnits pu, TimeUnits tu) : super._internal(pu.valueSI * tu.valueSI) {
    name = '${pu.singular} ${tu.name}';
    singular = '${pu.singular} ${tu.singular}';
    _convToMKS = pu.valueSI * tu.valueSI;
    _abbrev1 = pu._abbrev1 != null && tu._abbrev1 != null ? '${pu._abbrev1} ${tu._abbrev1}' : null;
    _abbrev2 = pu._abbrev2 != null && tu._abbrev2 != null ? '${pu._abbrev2}${tu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Energy;

  /// Derive new EnergyUnits using this EnergyUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new EnergyUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
