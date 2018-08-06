part of quantity_si;

// Also, ElectromotiveForce, EMF, Potential

/// The difference in electric potential energy between two points per unit electric charge
///
/// See the [Wikipedia entry for Voltage](https://en.wikipedia.org/wiki/Voltage)
/// for more information.
///
class ElectricPotentialDifference extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions electricPotentialDifferenceDimensions = const Dimensions.constant(
      const <String, int>{'Current': -1, 'Time': -3, 'Length': 2, 'Mass': 1},
      qType: ElectricPotentialDifference);

  /// The standard SI unit.
  static final ElectricPotentialDifferenceUnits volts =
      new ElectricPotentialDifferenceUnits('volts', null, 'V', null, 1.0, true);

  /// Construct an ElectricPotentialDifference with volts ([V]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  ElectricPotentialDifference({dynamic V, double uncert = 0.0})
      : super(V ?? 0.0, ElectricPotentialDifference.volts, uncert);

  ElectricPotentialDifference._internal(dynamic conv)
      : super._internal(conv, ElectricPotentialDifference.electricPotentialDifferenceDimensions);

  /// Constructs a ElectricPotentialDifference based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  ElectricPotentialDifference.inUnits(dynamic value, ElectricPotentialDifferenceUnits units, [double uncert = 0.0])
      : super(value, units ?? ElectricPotentialDifference.volts, uncert);

  const ElectricPotentialDifference.constant(Number valueSI,
      {ElectricPotentialDifferenceUnits units, double uncert = 0.0})
      : super.constant(valueSI, ElectricPotentialDifference.electricPotentialDifferenceDimensions, units, uncert);
}

/// Units acceptable for use in describing ElectricPotentialDifference quantities.
///
class ElectricPotentialDifferenceUnits extends ElectricPotentialDifference with Units {
  ElectricPotentialDifferenceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => ElectricPotentialDifference;

  /// Derive new ElectricPotentialDifferenceUnits using this ElectricPotentialDifferenceUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new ElectricPotentialDifferenceUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);

}
