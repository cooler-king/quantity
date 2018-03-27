part of quantity_si;

/// The resistance that is encountered when forming an electric field in a medium.
///
/// See the [Wikipedia entry for Permittivity](https://en.wikipedia.org/wiki/Permittivity)
/// for more information.
///
class Permittivity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions permittivityDimensions =
      const Dimensions.constant(const <String, int>{'Length': -3, 'Time': 4, 'Current': 2, 'Mass': -1}, qType: Permittivity);

  /// The standard SI unit.
  static final PermittivityUnits faradsPerMeter =
      new PermittivityUnits.capacitanceLength(Capacitance.farads, Length.meters);

  /// Construct a Permittivity with farads per meter.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Permittivity({dynamic faradsPerMeter, double uncert: 0.0}) : super(faradsPerMeter ?? 0.0, Permittivity.faradsPerMeter, uncert);

  Permittivity._internal(dynamic conv) : super._internal(conv, Permittivity.permittivityDimensions);

  /// Constructs a Permittivity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Permittivity.inUnits(dynamic value, PermittivityUnits units, [double uncert = 0.0])
      : super(value, units ?? Permittivity.faradsPerMeter, uncert);

  const Permittivity.constant(Number valueSI, {PermittivityUnits units, double uncert: 0.0})
      : super.constant(valueSI, Permittivity.permittivityDimensions, units, uncert);
}

/// Units acceptable for use in describing Permittivity quantities.
///
class PermittivityUnits extends Permittivity with Units {
  /// Constructs a new instance.
  PermittivityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on capacitance and length units.
  PermittivityUnits.capacitanceLength(CapacitanceUnits ecu, LengthUnits lu)
      : super._internal(ecu.valueSI / lu.valueSI) {
    name = '${ecu.name} per ${lu.singular}';
    singular = '${ecu.singular} per ${lu.singular}';
    _convToMKS = ecu.valueSI / lu.valueSI;
    _abbrev1 = ecu._abbrev1 != null && lu._abbrev1 != null ? '${ecu._abbrev1} / ${lu._abbrev1}' : null;
    _abbrev2 = ecu._abbrev2 != null && lu._abbrev2 != null ? '${ecu._abbrev2}/${lu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Permittivity;

  /// Derive new PermittivityUnits using this PermittivityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new PermittivityUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
}

